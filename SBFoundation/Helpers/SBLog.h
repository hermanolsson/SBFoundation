//
//  SBLog.h
//  SBFoundation
//
//  Copyright 2011 Simon Blommegård. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SBLog(format...)				SBDebug(__FILE__, __LINE__, format)
#define SBLogFullSel()					SBLog(@"%@", FULL_SEL_STR)

// Thanks to @msson and ACLog (https://gist.github.com/974375) for the folowing macros:

#define SBLogId(o)						SBLog(@"%s = %@", # o, o)
#define SBLogInt(i)                     SBLog(@"%s = %d", # i, i)
#define SBLogUnsignedInt(u)             SBLog(@"%s = %u", # u, u)
#define SBLogBOOL(b)					SBLog(@"%s = %@", # b, b?@"YES":@"NO")
#define SBLogFloat(f)					SBLog(@"%s = %f", # f, f)
#define SBLogLongLong(l)				SBLog(@"%s = %lld", # l, l)
#define SBLogLongFloat(f)				SBLog(@"%s = %Lf", # f, f)
#define SBLogCGPoint(p)					SBLog(@"%s = %@", # p, NSStringFromCGPoint(p))
#define SBLogCGRect(r)					SBLog(@"%s = %@", # r, NSStringFromCGRect(r))
#define SBLogCGSize(s)					SBLog(@"%s = %@", # s, NSStringFromCGSize(s))
#define SBLogUIEdgeInsets(i)			SBLog(@"%s = %@", # i, NSStringFromUIEdgeInsets(i))
#define SBLogCGAffineTransform(a)       SBLog(@"%s = %@", # a, NSStringFromCGAffineTransform(a))
#define SBLogClass(o)					SBLog(@"%s = %@", # o, NSStringFromClass([o class]))
#define SBLogSelector(s)				SBLog(@"%s = %@", # s, NSStringFromSelector(s))
#define SBLogProtocol(p)				SBLog(@"%s = %@", # p, NSStringFromProtocol(p))
#define SBLogRange(r)					SBLog(@"%s = %@", # r, NSStringFromRange(r))

#define SEL_STR NSStringFromSelector(_cmd)
#define CLS_STR NSStringFromClass([self class])
#define FULL_SEL_STR [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]

void SBDebug(const char *fileName, int lineNumber, NSString *format, ...);
