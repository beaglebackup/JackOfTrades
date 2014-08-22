//
//  SKSTableViewCell.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableViewCell.h"
#import "SKSTableViewCellIndicator.h"

#define kIndicatorViewTag -1

@interface SKSTableViewCell ()

@end

@implementation SKSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandable = YES;
        self.expandingLeft = NO;
        self.expandingRight = NO;
        
        self.accessoryView.hidden = YES;

    }
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        self.expandable = YES;
        self.expandingLeft = NO;
        self.expandingRight = NO;
        
        self.accessoryView.hidden = YES;

    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isExpandingLeft || self.isExpandingRight) {
        
        if (![self containsIndicatorView]) {
//            [self addIndicatorView];
        }
        else {
//            [self removeIndicatorView];
//            [self addIndicatorView];
        }
    }
}

static UIImage *_image = nil;
- (UIView *)expandableView
{
    if (!_image) {
        _image = [UIImage imageNamed:@"expandableImage.png"];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    button.frame = frame;
    
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    
    return button;
}

- (void)setExpandable:(BOOL)isExpandable
{
    if (isExpandable)
        [self setAccessoryView:[self expandableView]];
    
    _expandable = isExpandable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)addIndicatorView
{
    
    
    CGRect bounds = self.accessoryView.bounds;

    CGFloat x;
    
    if (self.isExpandingLeft) {
        x = self.contentView.center.x/2; // A quarter of the cell width
    }
    else if (self.isExpandingRight) {
        x = self.contentView.center.x + self.contentView.center.x/2; // 3/4 of the cell width
    }
    
    CGFloat y = self.frame.size.height - bounds.size.height;
    
    CGPoint point = CGPointMake(x, y);
    
    CGRect frame = CGRectMake((point.x - CGRectGetWidth(bounds) * 1.5), point.y * 1.4, CGRectGetWidth(bounds) * 3.0, CGRectGetHeight(self.bounds) - point.y * 1.4);
    SKSTableViewCellIndicator *indicatorView = [[SKSTableViewCellIndicator alloc] initWithFrame:frame];
    indicatorView.tag = kIndicatorViewTag;
    
    [SKSTableViewCellIndicator setIndicatorColor:[UIColor colorLavender]];
    
    [self.contentView addSubview:indicatorView];
}

- (void)removeIndicatorView
{
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    if (indicatorView)
    {
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}

- (BOOL)containsIndicatorView
{
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
}

- (void)accessoryViewAnimation
{
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isExpandingLeft || self.isExpandingRight) {
            
            self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            
        } else {
            self.accessoryView.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finished) {
        
        if (!self.isExpandingLeft && !self.isExpandingRight)
            [self removeIndicatorView];
        
    }];
}

@end
