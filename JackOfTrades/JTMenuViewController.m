//
//  JTMenuViewController.m
//  JackOfTrades
//
//  Created by Admin on 7/9/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTMenuViewController.h"

@interface JTMenuViewController ()

@end

@implementation JTMenuViewController

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
    
    self.view.backgroundColor = [UIColor colorLightBeige];
    // Do any additional setup after loading the view.
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

- (IBAction)didTapCloseButton:(id)sender {
        
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)openPortalButton:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.training.pestecipm.com"]];

}
@end
