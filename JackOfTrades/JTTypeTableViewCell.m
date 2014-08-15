//
//  JTTypeTableViewCell.m
//  JackOfTrades
//
//  Created by Admin on 8/14/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTTypeTableViewCell.h"

@implementation JTTypeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapLeftTypeButton:(id)sender {
}

- (IBAction)didTapRightTypeButton:(id)sender {
}
@end
