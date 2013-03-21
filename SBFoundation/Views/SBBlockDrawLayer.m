//
//  SBBlockDrawLayer.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBBlockDrawLayer.h"
#import <UIKit/UIKit.h>

@implementation SBBlockDrawLayer

- (id)init {
  if (self = [super init]) {
    [self setContentsScale:[UIScreen mainScreen].scale];
  }
  return self;
}

- (void)drawInContext:(CGContextRef)ctx {
  if (self.drawInContext)
    self.drawInContext(self, ctx);
}

@end
