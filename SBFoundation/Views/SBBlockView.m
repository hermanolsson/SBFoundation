//
//  SBBlockDrawView.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBBlockView.h"

@implementation SBBlockView
@synthesize drawRect = _drawRect;
@synthesize layoutSubviewsBlock = _layoutSubviewsBlock;

- (void)drawRect:(CGRect)rect {
    if (self.drawRect)
        self.drawRect(self, rect);
}

- (void)layoutSubviews {
  if (self.layoutSubviewsBlock)
    self.layoutSubviewsBlock(self);
}

@end
