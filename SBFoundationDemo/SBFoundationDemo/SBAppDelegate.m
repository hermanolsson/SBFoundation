//
//  SBAppDelegate.m
//  SBFoundationDemo
//
//  Created by Simon Blommegård on 2012-03-24.
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBAppDelegate.h"

@implementation SBAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    return YES;
}

@end
