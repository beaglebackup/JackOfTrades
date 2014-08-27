//
//  JTSubDetailsViewController.h
//  JackOfTrades
//
//  Created by Admin on 7/27/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTSubDetailsViewController : UIViewController <UIWebViewDelegate>


@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString* navTitle;
@property (strong, nonatomic) NSURL* url;

@end
