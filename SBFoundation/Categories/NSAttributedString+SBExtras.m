//
//  NSAttributedString+SBExtras.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "NSAttributedString+SBExtras.h"

@interface NSAttributedString (SBExtrasPrivate)
- (CGSize)inPath:(UIBezierPath *)path withLineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment draw:(BOOL)draw;
@end


@implementation NSAttributedString (SBExtras)

- (CGSize)drawInPath:(UIBezierPath *)path withLineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment {
    return [self inPath:path withLineBreakMode:lineBreakMode alignment:alignment draw:YES];
}

- (CGSize)sizeConstrainedToPath:(UIBezierPath *)path withLineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment {
    return [self inPath:path withLineBreakMode:lineBreakMode alignment:kCTLeftTextAlignment draw:NO];
}

@end

@implementation NSAttributedString (SBExtrasPrivate)

- (CGSize)inPath:(UIBezierPath *)path withLineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment draw:(BOOL)draw {
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
    
    CGPoint pathBoundingBoxOffset = CGPointMake(CGPathGetBoundingBox(path.CGPath).origin.x, CGPathGetBoundingBox(path.CGPath).origin.y);
    [path applyTransform:CGAffineTransformMakeScale(1., -1.)];
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, pathBoundingBoxOffset.x, path.bounds.size.height+pathBoundingBoxOffset.y);
    CGContextScaleCTM(context, 1., -1.);
    
    // Create the string
    CFMutableAttributedStringRef string = CFAttributedStringCreateMutableCopy(kCFAllocatorDefault, 0, (__bridge CFAttributedStringRef)self);
    
    // Alignment + LineBreakMode
    CTParagraphStyleSetting settings[] = {
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment}
        ,{kCTParagraphStyleSpecifierLineBreakMode, sizeof(attributeLineBreakMode), &attributeLineBreakMode}
    };
    
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    CFAttributedStringSetAttribute(string, CFRangeMake(0, CFAttributedStringGetLength(string)), kCTParagraphStyleAttributeName, paragraphStyle);
    CFRelease(paragraphStyle);
    
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
        CFRange lastLineRange = CTLineGetStringRange(lastLine);
        
        // Get correct truncstionType & position
        CTLineTruncationType truncationType;
        NSUInteger truncationAttributePosition = lastLineRange.location;
        
        // Multiple lines, only use kCTLineTruncationEnd
        if (numberOfLines != 1) {
            truncationType = kCTLineTruncationEnd;
            truncationAttributePosition += (lastLineRange.length - 1);
        }
        else
            switch (trunctationLineBreakMode) {
                case kCTLineBreakByTruncatingHead:
                    truncationType = kCTLineTruncationStart;
                    break;
                case kCTLineBreakByTruncatingMiddle:
                    truncationType = kCTLineTruncationMiddle;
                    truncationAttributePosition += (lastLineRange.length / 2);
                    break;
                case kCTLineBreakByTruncatingTail:
                default:
                    truncationType = kCTLineTruncationEnd;
                    truncationAttributePosition += (lastLineRange.length - 1);
                    break;
            }
        
        // Create truncation token by using correct attributes
        CFDictionaryRef attributes = CFAttributedStringGetAttributes(string, truncationAttributePosition, NULL);
        CFAttributedStringRef tokenString = CFAttributedStringCreate(kCFAllocatorDefault, CFSTR("\u2026"), attributes);
        CTLineRef truncationToken = CTLineCreateWithAttributedString(tokenString);
        CFRelease(tokenString);
        
        // Create a new string with the rest of all our string
        CFRange truncationStringRange = CFRangeMake(CTLineGetStringRange(lastLine).location, 0); 
        truncationStringRange.length = CFAttributedStringGetLength(string) - truncationStringRange.location; 
        
        CFAttributedStringRef truncationString = CFAttributedStringCreateWithSubstring(kCFAllocatorDefault, string, truncationStringRange);
        CTLineRef truncationLine = CTLineCreateWithAttributedString(truncationString); 
        CFRelease(truncationString);
        
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
    return CGSizeMake(maximumWidth-minimumOrigin,path.bounds.size.height-lineOrigins[numberOfLines-1].y);
}

@end