//
//  SBBlockDrawView.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBBlockView : UIView
@property (nonatomic, copy) void(^drawRect)(UIView *view, CGRect rect);
@property (nonatomic, copy) void(^layoutSubviewsBlock)(UIView *view);
@end
