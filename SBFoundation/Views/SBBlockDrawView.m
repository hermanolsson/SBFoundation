//
//  SBBlockDrawView.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBBlockDrawView.h"

@implementation SBBlockDrawView
@synthesize drawRect = _drawRect;

- (void)drawRect:(CGRect)rect {
    if (self.drawRect)
        self.drawRect(self, rect);
}

@end
