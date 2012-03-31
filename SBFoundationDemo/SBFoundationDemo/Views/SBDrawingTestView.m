//
//  SBDrawingTestView.m
//  SBFoundationDemo
//
//  Created by Simon Blommegård on 2012-03-27.
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBDrawingTestView.h"
#import <CoreText/CoreText.h>

@implementation SBDrawingTestView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100,100,200,200)];
    
    NSString *string = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu ornare libero. Sed lectus est, tempor non lobortis et, tristique a sapien. Donec laoreet ligula vel augue auctor lobortis. Duis sollicitudin dui at purus pellentesque malesuada. Vivamus dictum viverra tincidunt. Sed mollis urna ac arcu viverra lobortis convallis nunc mollis. Pellentesque ultrices luctus erat non lacinia. In velit augue, rhoncus at elementum rhoncus, rutrum ac ligula. Nam dapibus cursus luctus. Nam vitae odio quis est condimentum blandit id id dolor. Ut venenatis interdum tincidunt. Duis tristique nulla vitae elit sodales adipiscing. Sed lacus ipsum, bibendum at lobortis tristique, laoreet quis mi. Sed vel nisi felis, vel pellentesque felis. Vestibulum luctus, ipsum quis vestibulum malesuada, sem lorem tristique magna, in rutrum quam felis a eros. Maecenas accumsan nibh ut neque sodales rhoncus.";
    
    [[UIColor redColor] set];
    [string drawInPath:path
              withFont:[UIFont boldSystemFontOfSize:10.]
         lineBreakMode:UILineBreakModeTailTruncation
             alignment:kCTLeftTextAlignment];
}

@end
