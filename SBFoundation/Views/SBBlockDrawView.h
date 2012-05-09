//
//  SBBlockDrawView.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBBlockDrawView : UIView
@property (nonatomic, copy) void(^drawRect)(UIView *view, CGRect rect);
@end
