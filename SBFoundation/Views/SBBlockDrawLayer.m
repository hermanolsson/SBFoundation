//
//  SBBlockDrawLayer.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBBlockDrawLayer.h"

@implementation SBBlockDrawLayer

- (void)drawInContext:(CGContextRef)ctx {
  if (self.drawInContext)
    self.drawInContext(self, ctx);
}

@end
