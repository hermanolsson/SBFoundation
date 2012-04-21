//
//  SBNetworkActivityIndicatorQueue.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBNetworkActivityIndicatorQueue : NSObject

+ (void)startActivity;
+ (void)endActivity;
+ (void)resetAndStopActivity;

@end
