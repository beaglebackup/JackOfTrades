//
//  JTTypeTableViewCell.h
//  JackOfTrades
//
//  Created by Admin on 8/14/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTTypeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *rightTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *leftTypeButton;

- (IBAction)didTapLeftTypeButton:(id)sender;
- (IBAction)didTapRightTypeButton:(id)sender;

@end
