//
//  NSArray+SBExtras.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "NSArray+SBExtras.h"

@implementation NSArray (SBExtras)

- (id)firstObject {
    if (![self count])
        return nil;
    
    return [self objectAtIndex:0];
}

@end
