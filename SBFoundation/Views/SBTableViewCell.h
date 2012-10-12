//
//  SBTableViewCell.h
//  Shower
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBTableViewCell : UITableViewCell
@property (nonatomic, strong, readonly) UIView *cellContentView;

- (void)drawBackgroundRect:(CGRect)rect;
- (void)drawSelectedBackgroundRect:(CGRect)rect;
- (void)drawContentRect:(CGRect)rect;

@end
