//
//  SBLog.m
//  SBFoundation
//
//  Copyright 2011 Simon Blommegård. All rights reserved.
//

#import "SBLog.h"

#ifdef DEBUG
void SBDebug(const char *fileName, int lineNumber, NSString *fmt, ...) {
	va_list args;
	va_start(args, fmt);
	
	NSString *msg = [[NSString alloc] initWithFormat:fmt arguments:args];
	NSString *filePath = [[NSString alloc] initWithUTF8String:fileName];    
	
	NSLog(@"[%@:%d] %@", [filePath lastPathComponent], lineNumber, msg);
	
	va_end(args);
}
#else
void SBDebug(const char *fileName, int lineNumber, NSString *fmt, ...) {
}
#endif
