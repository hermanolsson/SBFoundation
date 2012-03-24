//
//  UIView+SBExtras.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "UIView+SBExtras.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (SBExtras)

@dynamic viewController;
@dynamic cornerRadius, borderWidth, borderColor;
@dynamic left, right, top, bottom;
@dynamic width, height;
@dynamic origin, size;

- (UIViewController*)viewController {
	for (UIView *next = [self superview]; next; next = [next superview]) {
		UIResponder *nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:[UIViewController class]])
			return (UIViewController*)nextResponder;
	}
	return nil;
}

- (CGFloat)cornerRadius {
	return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	[self.layer setCornerRadius:cornerRadius];
}

- (CGFloat)borderWidth {
	return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	[self.layer setBorderWidth:borderWidth];
}

- (UIColor*)borderColor {
	return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor*)borderColor {
	[self.layer setBorderColor:borderColor.CGColor];
}

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
	CGRect frame = self.frame;
	frame.origin.x = left;
	[self setFrame:frame];
}


- (CGFloat)right {
	return (self.frame.origin.x + self.frame.size.width);
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	[self setFrame:frame];
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
	CGRect frame = self.frame;
	frame.origin.y = top;
	[self setFrame:frame];
}

- (CGFloat)bottom {
	return (self.frame.origin.y + self.frame.size.height);
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	[self setFrame:frame];
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	[self setFrame:frame];
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	[self setFrame:frame];
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	[self setFrame:frame];
}

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	[self setFrame:frame];
}

@end
