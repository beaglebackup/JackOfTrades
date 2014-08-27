//
//  JTTypeExpandButton.m
//  JackOfTrades
//
//  Created by Admin on 8/16/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTTypeExpandButton.h"

@implementation JTTypeExpandButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView];
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setupView];

        // Initialization code
    }
    return self;
}

- (void) setupView {
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                            -self.imageView.frame.size.width,
                                            0,
                                            0);
//    self.imageEdgeInsets = UIEdgeInsetsMake(self.titleLabel.frame.size.height,
//                                            self.frame.size.width/2 - self.imageView.frame.size.width/2,
//                                            0,
//                                            0);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
