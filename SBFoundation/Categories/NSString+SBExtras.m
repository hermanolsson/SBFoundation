//
//  NSString+SBExtras.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "NSString+SBExtras.h"
#import "NSAttributedString+SBExtras.h"

@interface NSString (SBExtrasPrivate)
- (NSAttributedString *)attributedStringWithFont:(UIFont *)font;
@end

@implementation NSString (SBExtras)

- (CGSize)drawInPath:(UIBezierPath *)path withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment {
    return [[self attributedStringWithFont:font] drawInPath:path withLineBreakMode:lineBreakMode alignment:alignment];
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToPath:(UIBezierPath *)path lineBreakMode:(UILineBreakMode)lineBreakMode {
    return [[self attributedStringWithFont:font] sizeConstrainedToPath:path withLineBreakMode:lineBreakMode];
}

@end

@implementation NSString (SBExtrasPrivate)

- (NSAttributedString *)attributedStringWithFont:(UIFont *)font {
    
    // Create the string
    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString(string, CFRangeMake(0, 0), (__bridge CFStringRef)self);
    
    // Font
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    CFAttributedStringSetAttribute(string, CFRangeMake(0, CFAttributedStringGetLength(string)), kCTFontAttributeName, ctFont);
    CFRelease(ctFont);
    
    // Color
    CFAttributedStringSetAttribute(string, CFRangeMake(0, CFAttributedStringGetLength(string)), kCTForegroundColorFromContextAttributeName, kCFBooleanTrue);
 
    return (__bridge NSAttributedString*)string;
}

@end
