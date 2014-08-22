//
//  JTTypeTableViewCell.h
//  JackOfTrades
//
//  Created by Admin on 8/14/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableViewCell.h"
#import "JTTypeExpandButton.h"

@protocol JTTypeTableViewCellDelegate;


@interface JTTypeTableViewCell : SKSTableViewCell

@property (strong, nonatomic) IBOutlet JTTypeExpandButton *rightTypeButton;
@property (strong, nonatomic) IBOutlet JTTypeExpandButton *leftTypeButton;
@property (strong, nonatomic) IBOutlet UILabel *leftTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightTypeLabel;

- (IBAction)didTapLeftTypeButton:(id)sender;
- (IBAction)didTapRightTypeButton:(id)sender;


/*! @name Delegate */
@property (nonatomic, strong) id<JTTypeTableViewCellDelegate> delegate;

@end


@protocol JTTypeTableViewCellDelegate <NSObject>

@required

- (void)typeCell:(JTTypeTableViewCell *)typeCell didTapButton:(UIButton *)button;

@end