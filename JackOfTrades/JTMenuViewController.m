//
//  JTMenuViewController.m
//  JackOfTrades
//
//  Created by Admin on 7/9/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTMenuViewController.h"
#import "JTMenuWebViewController.h"

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
    // Do any additional setup after loading the view.
}

//Web Browser
- (void)viewDidUnload
{
    [self setArticlesButton:nil];
    [super viewDidUnload];
    //release any retained subviews of the main view.
    //e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    //return YES for supported orientations
//    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpSideDown);
//}


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


- (IBAction)openArticlesButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.pctonline.com/"];
    JTMenuWebViewController *webViewController =
    [[JTMenuWebViewController alloc] initWithURL:url andTitle:@"PCT Online"];
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)openIPMButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.epa.gov/opp00001/factsheets/ipm.htm/"];
    JTMenuWebViewController *webViewController =
    [[JTMenuWebViewController alloc] initWithURL:url andTitle:@"IPM"];
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)openVideosButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/"];
    JTMenuWebViewController *webViewController =
    [[JTMenuWebViewController alloc] initWithURL:url andTitle:@"Youtube"];
    [self presentModalViewController:webViewController animated:YES];
}


- (IBAction)openPortalButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.training.pestecipm.com/"];
    JTMenuWebViewController *webViewController =
    [[JTMenuWebViewController alloc] initWithURL:url andTitle:@"Portal"];
    [self presentModalViewController:webViewController animated:YES];
}

@end
