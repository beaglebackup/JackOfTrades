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
@property (strong, nonatomic) IBOutlet UIButton *portalButton;
@property (strong, nonatomic) IBOutlet UIButton *pestecButton;
@property (strong, nonatomic) IBOutlet UIButton *spcbButton;




- (IBAction)didTapCloseButton:(id)sender;
- (IBAction)openPortalButton:(id)sender;
- (IBAction)openArticlesButton:(id)sender;
- (IBAction)openIPMButton:(id)sender;
- (IBAction)openVideosButton:(id)sender;
- (IBAction)openSPCBButton:(id)sender;
- (IBAction)openFeedBackButton:(id)sender;
- (IBAction)openPestecButton:(id)sender;




@end
