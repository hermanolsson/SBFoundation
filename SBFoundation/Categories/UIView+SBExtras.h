//
//  UIView+SBExtras.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SBExtras)

@property (nonatomic, readonly) UIViewController *viewController;

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

- (UIImage*)imageWithRect:(CGRect)frame transparentInsets:(UIEdgeInsets)insets;

@end
