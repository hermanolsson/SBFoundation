//
//  SBDoubleSidedLayer.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SBDoubleSidedLayer : CATransformLayer
@property (nonatomic, strong) CALayer *frontLayer;
@property (nonatomic, strong) CALayer *backLayer;
@end
