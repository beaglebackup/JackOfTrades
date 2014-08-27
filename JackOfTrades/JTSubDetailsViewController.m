//
//  JTSubDetailsViewController.m
//  JackOfTrades
//
//  Created by Admin on 7/27/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTSubDetailsViewController.h"

@interface JTSubDetailsViewController ()

@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;

@property (strong, nonatomic) UILabel* failedLoadError;


@end

@implementation JTSubDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];


    // Set the title
    self.title = self.navTitle;
    
    NSLog(@"JTSubDetailsViewController -- self.navtitle = %@",self.navTitle);
    NSLog(@"JTSubDetailsViewController -- self.url = %@",self.url);

    // Load Webview
    NSURLRequest* request = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    [self.webView loadRequest:request];

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
