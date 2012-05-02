//
//  SBFoundation.h
//  SBFoundation
//
//  Created by Simon Blommegård on 2012-04-20.
//  Copyright (c) 2012 Doubleint. All rights reserved.
//

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
#import "NSArray+SBExtras.h"
#import "NSObject+SBExtras.h"
#import "UITableView+SBExtras.h"
#import "UIView+SBExtras.h"
#import "NSString+SBExtras.h"
#import "NSAttributedString+SBExtras.h"

// Helpers
#import "SBLog.h"
#import "SBDrawingHelpers.h"

// Controllers
#import "SBNetworkActivityIndicatorQueue.h"

// External
#import "MAKVONotificationCenter.h"
#import "TFKeychain.h"