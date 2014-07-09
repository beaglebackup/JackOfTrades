//
//  JTMenuViewController.h
//  JackOfTrades
//
//  Created by Admin on 7/9/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIButton *ipmButton;
@property (strong, nonatomic) IBOutlet UIButton *articlesButton;
@property (strong, nonatomic) IBOutlet UIButton *videoButton;
@property (strong, nonatomic) IBOutlet UIButton *feedbackButton;

- (IBAction)didTapCloseButton:(id)sender;

@end
