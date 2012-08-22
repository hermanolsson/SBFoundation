//
//  SBBlockDrawLayer.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SBBlockDrawLayer : CALayer
@property (nonatomic, copy) void (^drawInContext)(SBBlockDrawLayer *layer, CGContextRef ctx);
@end
