//
//  UITableView+SBExtras.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

#define reusableTableCellOfClassWithBlock(TABLE, CLASS, STYLE, BLOCK) \
(CLASS *)[(TABLE) reusableCellOfClass:[CLASS class] style:STYLE identifier:@"ia." @#CLASS initializationBlock:BLOCK]

#define reusableTableCellOfClass(TABLE, CLASS, STYLE) \
(CLASS *)[(TABLE) reusableCellOfClass:[CLASS class] style:STYLE identifier:@"ia." @#CLASS initializationBlock:nil]

@interface UITableView (SBExtras)

- (UITableViewCell *)reusableCellOfClass:(Class)class style:(UITableViewCellStyle)style identifier:(NSString *)identifier initializationBlock:(void(^)(id cell))block;

@end