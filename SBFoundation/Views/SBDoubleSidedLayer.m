//
//  SBDoubleSidedLayer.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBDoubleSidedLayer.h"

@implementation SBDoubleSidedLayer

- (id)init {
	if (self = [super init]) {
    [self setDoubleSided:YES];
	}
  
	return self;
}

- (void)layoutSublayers {
	[super layoutSublayers];
	
	[self.frontLayer setFrame:self.bounds];
	[self.backLayer setFrame:self.bounds];
}


#pragma mark - Properties

- (void)setFrontLayer:(CALayer *)frontLayer{
	if (_frontLayer != frontLayer) {
		[_frontLayer removeFromSuperlayer];
		_frontLayer = frontLayer;
		[_frontLayer setDoubleSided:NO];
		[self addSublayer:frontLayer];
		[self setNeedsLayout];
	}
}

- (void)setBackLayer:(CALayer *)backLayer {
	if (_backLayer != backLayer) {
		[_backLayer removeFromSuperlayer];
		_backLayer = backLayer;
		[_backLayer setDoubleSided:NO];
		CATransform3D transform = CATransform3DMakeRotation(M_PI, 0.f, 1.f, 0.f);
		[_backLayer setTransform:transform];
		[self addSublayer:_backLayer];
		[self setNeedsLayout];
	}
}

@end

