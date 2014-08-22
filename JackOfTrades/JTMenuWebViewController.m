//
//  JTMenuWebViewController.m
//  JackOfTrades
//
//  Created by Gabriel on 8/21/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTMenuWebViewController.h"

@interface JTMenuWebViewController ()

@end

@implementation JTMenuWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string {
    if(self = [super init]){
        theURL = url;
        theTitle = string;
        
    }
    return self;
    
}

- (id)initWithURL:(NSURL *)url {
    return [self initWithURL:url andTitle:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    webTitle.title = theTitle;
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:theURL];
    [webView loadRequest:requestObject];
    
}

-(IBAction) done:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)viewWillDisappear:(BOOL)Animated {
    [super viewWillDisappear:Animated];
    webView.delegate=nil;
    [webView stopLoading];
}

- (void)webViewDidStartLoad:(UIWebView *)wv{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)wv{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
//   UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle
//                      message:errorString delgate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//  [errorView show];
}

-(void)didPresentAlertView:(UIAlertView *)alertView {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
