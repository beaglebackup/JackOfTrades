//
//  RoachViewController.h
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subtype.h"

@interface JTDetailsViewController : UIViewController




/**
 * subtype - The passed subtype object
 *
 */
@property (strong, nonatomic) Subtype* subtype;

@property (strong, nonatomic) NSString* navTitle;

@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIView *buttonBar;
@property (strong, nonatomic) IBOutlet UIButton *rxButton;
@property (strong, nonatomic) IBOutlet UIButton *toolboxButton;
@property (strong, nonatomic) IBOutlet UIButton *handsButton;
@property (strong, nonatomic) IBOutlet UIButton *bulbButton;


- (IBAction)didTapRXButton:(id)sender;
- (IBAction)didTapBulbButton:(id)sender;
- (IBAction)didTapHandsButton:(id)sender;
- (IBAction)didTapToolboxButton:(id)sender;




@end
