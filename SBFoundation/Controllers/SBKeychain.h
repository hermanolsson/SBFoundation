//
//  SBKeychain.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBKeychain : NSObject

+ (id)dataForKey:(NSString *)key class:(Class)outpucClass; // nil => NSData
+ (BOOL)setData:(id)data forKey:(NSString *)key;

@end
