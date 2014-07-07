//
//  RoachViewController.m
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTDetailsViewController.h"

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
    PFFile* mainImageFile = _subtype.mainPhoto;
    
    if(mainImageFile != NULL)
    {
        [mainImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {

            _mainImageView.image = [UIImage imageWithData:imageData];
            
        }];
    }
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
