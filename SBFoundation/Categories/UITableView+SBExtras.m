//
//  UITableView+SBExtras.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "UITableView+SBExtras.h"

@implementation UITableView (SBExtras)

- (UITableViewCell *)reusableCellOfClass:(Class)class style:(UITableViewCellStyle)style identifier:(NSString *)identifier initializationBlock:(void(^)(id cell))block {
	UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
	if(!cell) {
		cell = [[class alloc] initWithStyle:style reuseIdentifier:identifier];
		if(block != nil) block(cell);
	}
	return cell;
}

@end
