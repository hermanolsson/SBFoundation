//
//  NSString+SBExtras.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSString (SBExtras)

- (CGSize)drawInPath:(UIBezierPath *)path withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToPath:(UIBezierPath *)path lineBreakMode:(UILineBreakMode)lineBreakMode;

@end
