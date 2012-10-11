//
//  SBTableViewCell.m
//  SBFoundation
//
//  Copyright (c) 2012 Simon Blommegård. All rights reserved.
//

#import "SBTableViewCell.h"

@interface SBTableViewCellDrawingView : UIView {
    id _target;
    SEL _selector;
}
- (id)initWithTarger:(id)target selector:(SEL)selector;
@end

@implementation SBTableViewCellDrawingView
- (id)initWithTarger:(id)target selector:(SEL)selector {
    if (self = [super initWithFrame:CGRectZero]) {
		_target = target;
		_selector = selector;
	}
	return self;
}
- (void)drawRect:(CGRect)rect {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [_target performSelector:_selector withObject:[NSValue valueWithCGRect:rect]];
#pragma clang diagnostic pop
}
@end

@interface SBTableViewCell ()
@property (nonatomic, strong) UIView *cellContentView;
@end

@implementation SBTableViewCell
@synthesize cellContentView = _cellContentView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCellContentView:[[SBTableViewCellDrawingView alloc] initWithTarger:self selector:@selector(_drawContentRect:)]];
        [self.cellContentView setFrame:self.contentView.frame];
        [self.cellContentView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
        [self.cellContentView setContentMode:UIViewContentModeLeft];
        [self.cellContentView setOpaque:NO];
        
        [self.contentView addSubview:self.cellContentView];
        
        [self setBackgroundView:[[SBTableViewCellDrawingView alloc] initWithTarger:self selector:@selector(_drawBackgroundRect:)]];
        [self.backgroundView setContentMode:UIViewContentModeLeft];
        [self.backgroundView setOpaque:YES];
    }
    return self;
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[self.cellContentView setNeedsDisplay];
    [self.backgroundView setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	[self setNeedsDisplay];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self setNeedsDisplay];
}

#pragma mark - Private

- (void)_drawBackgroundRect:(NSValue*)value {
	[self drawBackgroundRect:[value CGRectValue]];
}
- (void)_drawContentRect:(NSValue*)value {
	[self drawContentRect:[value CGRectValue]];
}

#pragma mark - Public

- (void)drawBackgroundRect:(CGRect)rect {}
- (void)drawContentRect:(CGRect)rect {}

@end
