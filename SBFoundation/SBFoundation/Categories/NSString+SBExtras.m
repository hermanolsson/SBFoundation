//
//  NSString+SBExtras.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "NSString+SBExtras.h"

@interface NSString (SBExtrasPrivate)
- (CGSize)inPath:(UIBezierPath *)path withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment draw:(BOOL)draw;
@end

@implementation NSString (SBExtras)

- (CGSize)drawInPath:(UIBezierPath *)path withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment {
    return [self inPath:path withFont:font lineBreakMode:lineBreakMode alignment:alignment draw:YES];
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToPath:(UIBezierPath *)path lineBreakMode:(UILineBreakMode)lineBreakMode {
    return [self inPath:path withFont:font lineBreakMode:lineBreakMode alignment:kCTLeftTextAlignment draw:NO];
}

- (CGSize)inPath:(UIBezierPath *)path withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment draw:(BOOL)draw {
    CTLineBreakMode trunctationLineBreakMode = kCTLineBreakByClipping;
    CTLineBreakMode attributeLineBreakMode = kCTLineBreakByWordWrapping;
    
    switch (lineBreakMode) {
        case UILineBreakModeCharacterWrap:
            attributeLineBreakMode = kCTLineBreakByCharWrapping;
            break;
        case UILineBreakModeHeadTruncation:
            trunctationLineBreakMode = kCTLineBreakByTruncatingHead;
            break;
        case UILineBreakModeTailTruncation:
            trunctationLineBreakMode = kCTLineBreakByTruncatingTail;
            break;
        case UILineBreakModeMiddleTruncation:
            trunctationLineBreakMode = kCTLineBreakByTruncatingMiddle;
            break;
        default:
            break;
    }
    
    // Save contex and flip the coordinate system
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [path applyTransform:CGAffineTransformMakeScale(1., -1.)];
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, path.bounds.size.height);
    CGContextScaleCTM(context, 1., -1.);
    
    // Create the string
    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (string, CFRangeMake(0, 0), (__bridge CFStringRef)self);
    
    // Alignment + LineBreakMode
    CTParagraphStyleSetting settings[] = {
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment}
        ,{kCTParagraphStyleSpecifierLineBreakMode, sizeof(attributeLineBreakMode), &attributeLineBreakMode}
    };
    
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    CFAttributedStringSetAttribute(string, CFRangeMake(0, CFAttributedStringGetLength(string)), kCTParagraphStyleAttributeName, paragraphStyle);
    CFRelease(paragraphStyle);
    
    // Font
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    CFAttributedStringSetAttribute(string, CFRangeMake(0, CFAttributedStringGetLength(string)), kCTFontAttributeName, ctFont);
    CFRelease(ctFont);
    
    // Color
    CFAttributedStringSetAttribute(string, CFRangeMake(0, CFAttributedStringGetLength(string)), kCTForegroundColorFromContextAttributeName, kCFBooleanTrue);
    
    // Create the framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, CFAttributedStringGetLength(string)), path.CGPath, NULL);
    
    BOOL truncateLastLine = (trunctationLineBreakMode == kCTLineBreakByTruncatingHead ||
                             trunctationLineBreakMode == kCTLineBreakByTruncatingMiddle || 
                             trunctationLineBreakMode == kCTLineBreakByTruncatingTail);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSUInteger numberOfLines = CFArrayGetCount(lines);
    
    if (numberOfLines < 1) {
        CFRelease(string);
        CFRelease(framesetter);
        CFRelease(frame);
        return CGSizeZero;
    }
    
    // We need to store the size
    CGFloat minimumOrigin = CGFLOAT_MAX;
    CGFloat maximumWidth = CGFLOAT_MIN;
    
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    // Draw "normal" rows
    for (NSUInteger lineIndex = 0; lineIndex < numberOfLines-1; lineIndex++) {
        CGContextSetTextPosition(context, lineOrigins[lineIndex].x, lineOrigins[lineIndex].y);
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        if (draw)
            CTLineDraw(line, context);
        
        // Sizing
        if (lineOrigins[lineIndex].x < minimumOrigin)
            minimumOrigin = lineOrigins[lineIndex].x;
        
        CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, NULL, NULL, NULL);
        
        if (lineOrigins[lineIndex].x + width > maximumWidth)
            maximumWidth = lineOrigins[lineIndex].x + width;
    }
    
    // Set origin for last row
    CGContextSetTextPosition(context, lineOrigins[numberOfLines-1].x, lineOrigins[numberOfLines-1].y);
    
    CTLineRef lastLine = CFArrayGetValueAtIndex(lines, numberOfLines-1);
    lastLine = CFRetain(lastLine);
    
    if (truncateLastLine) {
        // Create truncation token by using correct attributes
        CFRange lastLineRange = CTLineGetStringRange(lastLine);
        CFDictionaryRef attributes = CFAttributedStringGetAttributes(string, lastLineRange.location + lastLineRange.length - 1, NULL);
        CFAttributedStringRef tokenString = CFAttributedStringCreate(kCFAllocatorDefault, CFSTR("\u2026"), attributes);
        CTLineRef truncationToken = CTLineCreateWithAttributedString(tokenString);
        CFRelease(tokenString);
        
        // Create a new string with the rest of all our string
        CFRange truncationStringRange = CFRangeMake(CTLineGetStringRange(lastLine).location, 0); 
        truncationStringRange.length = CFAttributedStringGetLength(string) - truncationStringRange.location; 
        
        CFAttributedStringRef truncationString = CFAttributedStringCreateWithSubstring(kCFAllocatorDefault, string, truncationStringRange);
        CTLineRef truncationLine = CTLineCreateWithAttributedString(truncationString); 
        CFRelease(truncationString);
        
        // Get correct truncstionType
        CTLineTruncationType truncationType;
        
        // Multiple lines, only use kCTLineTruncationEnd
        if (numberOfLines != 1)
            truncationType = kCTLineTruncationEnd;
        else
            switch (trunctationLineBreakMode) {
                case kCTLineBreakByTruncatingHead:
                    truncationType = kCTLineTruncationStart;
                    break;
                case kCTLineBreakByTruncatingMiddle:
                    truncationType = kCTLineTruncationMiddle;
                    break;
                case kCTLineBreakByTruncatingTail:
                default:
                    truncationType = kCTLineTruncationEnd;
                    break;
            }
        
        // Truncate
        double lastLineWidth = CTLineGetTypographicBounds(lastLine, NULL, NULL, NULL)+CTLineGetTrailingWhitespaceWidth(lastLine);
        CTLineRef truncatedLine = CTLineCreateTruncatedLine(truncationLine, lastLineWidth, truncationType, truncationToken);
        
        CFRelease(truncationLine);
        CFRelease(truncationToken);
        
        if (truncatedLine == NULL) 
            truncatedLine = CFRetain(lastLine); 
        
        lastLine = truncatedLine;
    }
    
    if (draw)
        CTLineDraw(lastLine, context);
    
    // Sizing
    if (lineOrigins[numberOfLines-1].x < minimumOrigin)
        minimumOrigin = lineOrigins[numberOfLines-1].x;
    
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(lastLine, NULL, NULL, NULL);
    
    if (lineOrigins[numberOfLines-1].x + width > maximumWidth)
        maximumWidth = lineOrigins[numberOfLines-1].x + width;
    
    // Release
    CFRelease(lastLine);
    CFRelease(string);
    CFRelease(framesetter);
    CFRelease(frame); 
    
    // Restore context
    CGContextRestoreGState(context);
    
    // We need a better way figure out the total height
    return CGSizeMake(maximumWidth-minimumOrigin,path.bounds.size.height-lineOrigins[numberOfLines-1].y+font.pointSize-15.);   
}

@end
