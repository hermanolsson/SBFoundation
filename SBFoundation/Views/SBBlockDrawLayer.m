//
//  SBBlockDrawLayer.m
//  SBFoundation
//
//  Created by Simon Blommegård on 8/20/12.
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBBlockDrawLayer.h"

@implementation SBBlockDrawLayer

- (void)drawInContext:(CGContextRef)ctx {
  if (self.drawInContext)
    self.drawInContext(self, ctx);
}

@end
