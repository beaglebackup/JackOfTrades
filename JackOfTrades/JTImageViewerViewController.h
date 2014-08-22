//
//  JTImageViewerViewController.h
//  JackOfTrades
//
//  Created by Admin on 8/5/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTImageViewerViewController : UIViewController

@property (strong, nonatomic) UIImage* passedImage;
@property (strong, nonatomic) IBOutlet UIImageView *largeImageView;


@end
