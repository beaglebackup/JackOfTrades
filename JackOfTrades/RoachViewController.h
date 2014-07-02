//
//  RoachViewController.h
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoachViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *americanButton;
@property (strong, nonatomic) IBOutlet UIButton *brownBandedButton;
@property (strong, nonatomic) IBOutlet UIButton *germanButton;
@property (strong, nonatomic) IBOutlet UIButton *orientalButton;
@property (strong, nonatomic) IBOutlet UILabel *americanInfoLabel;

//text scroll
@property (strong, nonatomic) IBOutlet UITextView *americanInfoTextScroll;

//button
@property (strong, nonatomic) IBOutlet UIButton *americanRxButton;
@property (strong, nonatomic) IBOutlet UIButton *americanBulbButton;
@property (strong, nonatomic) IBOutlet UIButton *americanHandsButton;
@property (strong, nonatomic) IBOutlet UIButton *americanToolButton;

//subviews
@property (strong, nonatomic) IBOutlet UITextView *americanRxSubViewTextView;
@property (strong, nonatomic) IBOutlet UITextView *americanBulbSubViewTextView;
@property (strong, nonatomic) IBOutlet UITextView *americanHandsSubViewTextView;
@property (strong, nonatomic) IBOutlet UITextView *americanToolSubViewTextView;





@end
