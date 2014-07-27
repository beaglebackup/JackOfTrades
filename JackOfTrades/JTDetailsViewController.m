//
//  RoachViewController.m
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTDetailsViewController.h"
#import "JTSubDetailsViewController.h"

typedef enum {
    JTSubDetailsButtonsRX,
    JTSubDetailsButtonsBulb,
	JTSubDetailsButtonsHands,
    JTSubDetailsButtonsToolbox
} JTSubDetailsButtonsIndex;

@interface JTDetailsViewController ()

@end

@implementation JTDetailsViewController

@synthesize subtype=_subtype, titleLabel=_titleLabel, mainImageView=_mainImageView, textView=_textView, rxButton=_rxButton, toolboxButton=_toolboxButton, handsButton=_handsButton, bulbButton=_bulbButton;

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
    
    // Set the tags to identify the buttons when pressed
    self.rxButton.tag = JTSubDetailsButtonsRX;
    self.bulbButton.tag = JTSubDetailsButtonsBulb;
    self.handsButton.tag = JTSubDetailsButtonsHands;
    self.toolboxButton.tag = JTSubDetailsButtonsToolbox;
    
    
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
    
    // Set the title && text
    _titleLabel.text = _subtype.name;
    _textView.text = _subtype.text;
    

    
    
    // Set the image
    UIActivityIndicatorView* imageActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    imageActivityView.center = _mainImageView.center;
    [self.view addSubview:imageActivityView];
    [imageActivityView startAnimating];

    PFFile* mainImageFile = _subtype.mainPhoto;
    
    if(mainImageFile != NULL)
    {
        [mainImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            
            [imageActivityView stopAnimating];
            
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

#pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     UIButton* button = (UIButton*)sender;
     
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
     
     
     
     if ([[segue identifier] isEqualToString:@"detailsToSubdetails"])
     {
         JTSubDetailsViewController *subdetailsVC = [segue destinationViewController];
         
         NSLog(@"JTDetailsViewController -- button.titleLabel.text = %@",button.titleLabel.text);
         NSLog(@"JTDetailsViewController --  url= %@",url);

         subdetailsVC.navTitle = button.titleLabel.text;
         subdetailsVC.url = url;
     }
 }
 


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
@end
