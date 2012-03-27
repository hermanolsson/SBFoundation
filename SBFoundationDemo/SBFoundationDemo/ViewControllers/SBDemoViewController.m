//
//  SBDemoViewController.m
//  SBFoundationDemo
//
//  Created by Simon Blommegård on 2012-03-24.
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBDemoViewController.h"
#import "SBDrawingTestView.h"
@interface SBDemoViewController ()
@property (nonatomic, strong) SBDrawingTestView *drawingTestView;
@end

@implementation SBDemoViewController
@synthesize drawingTestView = _drawingTestView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.drawingTestView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [self setDrawingTestView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Properties


- (SBDrawingTestView *)drawingTestView {
    if (!_drawingTestView) {
        _drawingTestView = [[SBDrawingTestView alloc] initWithFrame:self.view.bounds];
        [_drawingTestView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    }
    return _drawingTestView;
}

@end
