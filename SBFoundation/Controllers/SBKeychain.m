//
//  SBKeychain.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBKeychain.h"
#import <Security/Security.h>

@implementation SBKeychain

+ (NSString*)serviceName {
	return [[NSBundle mainBundle] bundleIdentifier];
}

+ (id)dataForKey:(NSString *)key class:(Class)outpucClass {
	NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                         (id)kCFBooleanTrue, kSecReturnData,
                         kSecClassGenericPassword, kSecClass,
                         key, kSecAttrAccount,
                         [self serviceName], kSecAttrService, nil];
	
	CFDataRef keychainData = NULL;
	OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&keychainData);
	if(status) return nil;
	
  id data = nil;
  
  if (!outpucClass)
    data = (__bridge id)keychainData;
  
  else if ([outpucClass instancesRespondToSelector:@selector(initWithData:encoding:)])
    data = [[outpucClass alloc] initWithData:(__bridge id)keychainData encoding:NSUTF8StringEncoding];
  
  else if ([outpucClass instancesRespondToSelector:@selector(initWithData:)])
    data = [[outpucClass alloc]initWithData:(__bridge id)keychainData];
  
  else
    [NSException raise:NSInternalInconsistencyException
                format:@"Class %@ does not respond to -initWithData:encoding: or -initWithData:.", NSStringFromClass(outpucClass)];
    
  
	CFRelease(keychainData);
	return data;
}


+ (BOOL)setData:(id)data forKey:(NSString *)key {
	NSData *keychainData = nil;
  
  if ([data isKindOfClass:[NSData class]])
    keychainData = data;
  
  else if ([data respondsToSelector:@selector(dataUsingEncoding:)])
    keychainData = [data dataUsingEncoding:NSUTF8StringEncoding];
  
  else if ([data respondsToSelector:@selector(data)])
    keychainData = [data data];
  
  else
    [NSException raise:NSInternalInconsistencyException
                format:@"Class %@ does not respond to -dataUsingEncoding: or -data.", NSStringFromClass([data class])];
  
	NSDictionary *spec = [NSDictionary dictionaryWithObjectsAndKeys:
                        (__bridge id)kSecClassGenericPassword, kSecClass,
                        key, kSecAttrAccount,
                        [self serviceName], kSecAttrService, nil];
	
  
	if(!key) {
		return !SecItemDelete((__bridge CFDictionaryRef)spec);
	}
  else if([self dataForKey:key class:[data class]]) {
		NSDictionary *update = [NSDictionary dictionaryWithObject:keychainData forKey:(__bridge id)kSecValueData];
		return !SecItemUpdate((__bridge CFDictionaryRef)spec, (__bridge CFDictionaryRef)update);
	}
  else{
		NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:spec];
		[data setObject:keychainData forKey:(__bridge id)kSecValueData];
		return !SecItemAdd((__bridge CFDictionaryRef)data, NULL);
	}
}

@end
