//
//  SBNetworkActivityIndicatorQueue.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBNetworkActivityIndicatorQueue.h"

@interface SBNetworkActivityIndicatorQueue ()
@property (nonatomic, assign) NSInteger count;
@end

@implementation SBNetworkActivityIndicatorQueue
@synthesize count = _count;

+ (id)sharedQueue {
	static SBNetworkActivityIndicatorQueue *queue = nil;
	if (!queue)
		queue = [self new];
	
	return queue;
}

+ (void)startActivity {
	SBNetworkActivityIndicatorQueue *queue = [self sharedQueue];
	
	if(queue.count == 0)
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	queue.count++;
}

+ (void)endActivity {
	SBNetworkActivityIndicatorQueue *queue = [self sharedQueue];
    
	queue.count--;
    
	if(queue.count <= 0)
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

+ (void)resetAndStopActivity {
	SBNetworkActivityIndicatorQueue *queue = [self sharedQueue];
	
	queue.count = 0;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
@end
