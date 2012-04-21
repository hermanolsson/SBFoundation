//
//  NSAttributedString+SBExtras.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSAttributedString (SBExtras)

// Return the bounding size
- (CGSize)drawInPath:(UIBezierPath *)path withLineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment;
- (CGSize)sizeConstrainedToPath:(UIBezierPath *)path withLineBreakMode:(UILineBreakMode)lineBreakMode alignment:(CTTextAlignment)alignment;

@end
