//
//  JTMenuWebViewController.h
//  JackOfTrades
//
//  Created by Gabriel on 8/21/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTMenuWebViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
    
    NSURL *theURL;
    NSString *theTitle;
    IBOutlet UIWebView *webView;
    IBOutlet UINavigationItem *webTitle;
    
}

- (id)initWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string;
-(IBAction) done:(id)sender;


@end
