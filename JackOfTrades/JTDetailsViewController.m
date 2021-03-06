//
//  RoachViewController.m
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTDetailsViewController.h"
#import "JTSubDetailsViewController.h"
#import "JTImageViewerViewController.h"

typedef enum {
    JTSubDetailsButtonsRX,
    JTSubDetailsButtonsBulb,
	JTSubDetailsButtonsHands,
    JTSubDetailsButtonsToolbox
} JTSubDetailsButtonsIndex;

@interface JTDetailsViewController ()

@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;


@end

@implementation JTDetailsViewController

@synthesize subtype=_subtype, navTitle=_navTitle, mainImageView=_mainImageView, textView=_textView, textWebView=_textWebView, rxButton=_rxButton, toolboxButton=_toolboxButton, handsButton=_handsButton, bulbButton=_bulbButton, buttonBar=_buttonBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the title
    self.title = _navTitle;

    
    // Set text for button (to pass to subdetailsVC)
    self.rxButton.detailType = @"RX";
    self.handsButton.detailType = @"Hands";
    self.toolboxButton.detailType = @"Toolbox";
    self.bulbButton.detailType = @"Bulb";
    
    
    // Activity Indicator
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.center = self.mainImageView.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    

    // Button Bar
    self.buttonBar.backgroundColor = [UIColor colorLavender];
    
    
    // Set the tags to identify the buttons when pressed
    self.rxButton.tag = JTSubDetailsButtonsRX;
    self.bulbButton.tag = JTSubDetailsButtonsBulb;
    self.handsButton.tag = JTSubDetailsButtonsHands;
    self.toolboxButton.tag = JTSubDetailsButtonsToolbox;
    
    
    // Action for imageViewer
    [self.mainImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImage:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.mainImageView addGestureRecognizer:singleTap];

    
    
    // Call Parse for Data
    [JTDatabaseManager getAllKeysForSubtype:self.subtype withCallback:^(Subtype *theSubtype, NSError *error) {
        
        // Handle errors
        if (error) {
            
            if ([error code] == kPFErrorObjectNotFound) {
                NSLog(@"Uh oh, we couldn't find the object!");
            }
            else if ([error code] == kPFErrorConnectionFailed) {
                NSLog(@"Uh oh, we couldn't even connect to the Parse Cloud!");
            }
            else {
                NSLog(@"Error: %@", [[error userInfo] objectForKey:@"error"]);
            }
        }
        
        else {
            _subtype = theSubtype;
            
            [self objectsDidLoad:error];
        }
    }];
    
    
 

}

- (void)objectsDidLoad:(NSError *)error {
    
    
    
    // Load textWebView
    NSURL* textURL = [NSURL URLWithString:_subtype.mainText];
    NSURLRequest* request = [NSURLRequest requestWithURL:textURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    [self.textWebView loadRequest:request];

    

    
    
    // Set the image
//    UIActivityIndicatorView* imageActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    imageActivityView.center = _mainImageView.center;
//    [self.view addSubview:imageActivityView];
//    [imageActivityView startAnimating];

    PFFile* mainImageFile = _subtype.mainPhoto;
    
    if(mainImageFile != NULL)
    {
        [mainImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            
            [self.activityIndicator stopAnimating];
            
            if (!error) {
                _mainImageView.image = [UIImage imageWithData:imageData];

            }
        
        }];
    }
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIWebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"JTSubDetailsViewController -- error = %@",error);
    
    [self.activityIndicator stopAnimating];
}



#pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     JTDetailsButton* button = (JTDetailsButton*)sender;
     
     // Subdetails
     if ([[segue identifier] isEqualToString:@"detailsToSubdetails"])
     {
        
         NSURL* url;
         
         switch (button.tag) {
             case JTSubDetailsButtonsRX:
                 url = [NSURL URLWithString:self.subtype.RX];
                 break;
                 
             case JTSubDetailsButtonsBulb:
                 url = [NSURL URLWithString:self.subtype.bulb];
                 break;
                 
             case JTSubDetailsButtonsHands:
                 url = [NSURL URLWithString:self.subtype.hands];
                 break;
                 
             case JTSubDetailsButtonsToolbox:
                 url = [NSURL URLWithString:self.subtype.toolbox];
                 break;
                 
             default:
                 break;
         }
         
         JTSubDetailsViewController *subdetailsVC = [segue destinationViewController];

         
         NSLog(@"JTDetailsViewController -- button.titleLabel.text = %@",button.titleLabel.text);
         NSLog(@"JTDetailsViewController --  url= %@",url);

         subdetailsVC.navTitle = [NSString stringWithFormat:@"%@: %@",button.detailType, self.subtype.name];
         subdetailsVC.url = url;
     }
     
     // Image Viewer
     else if ([[segue identifier] isEqualToString:@"imageViewer"]) {
         
         JTImageViewerViewController *imageViewerVC = [segue destinationViewController];
         imageViewerVC.passedImage = self.mainImageView.image;
     }
     
     // No backButton text
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
 }

#pragma mark - Buttons
- (IBAction)didTapRXButton:(id)sender {
    [self performSegueWithIdentifier:@"detailsToSubdetails" sender:sender];
}

- (IBAction)didTapBulbButton:(id)sender {
    [self performSegueWithIdentifier:@"detailsToSubdetails" sender:sender];
}

- (IBAction)didTapHandsButton:(id)sender {
    [self performSegueWithIdentifier:@"detailsToSubdetails" sender:sender];
}

- (IBAction)didTapToolboxButton:(id)sender {
    [self performSegueWithIdentifier:@"detailsToSubdetails" sender:sender];
}

- (void)didTapImage:(id)sender {
    [self performSegueWithIdentifier:@"imageViewer" sender:sender];
}


@end
