//
//  SBFoundation.h
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

// Global Macros

#define SBRadiansToDregrees(RADIANS) ((RADIANS) * (180.0 / M_PI))
#define SBDegreesToRadians(DEGREES) ((DEGREES) / 180.0 * M_PI)

#define SBReturnStatic(THING) \
static id thing = nil; \
if (!thing) \
thing = THING; \
return thing

#define SBDeclareConstString(NAME) extern NSString * const NAME
#define SBDefineConstString(NAME) NSString * const NAME = @#NAME

#define SBDefineStaticVoid(NAME) static void * NAME = &NAME

// Categories
#import <SBFoundation/Categories/NSArray+SBExtras.h>
#import <SBFoundation/Categories/NSObject+SBExtras.h>
#import <SBFoundation/Categories/UITableView+SBExtras.h>
#import <SBFoundation/Categories/UIView+SBExtras.h>
#import <SBFoundation/Categories/NSString+SBExtras.h>

// Helpers
#import <SBFoundation/Helpers/SBLog.h>
#import <SBFoundation/Helpers/SBDrawingHelpers.h>

// Controllers
#import <SBFoundation/Controllers/SBNetworkActivityIndicatorQueue.h>

// External
#import <SBFoundation/MAKVONotificationCenter.h>