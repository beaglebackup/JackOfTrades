//
//  JTTypeExpandController.h
//  JackOfTrades
//
//  Created by Admin on 8/14/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKExpandTableView.h"

@interface JTTypeExpandController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* objects;

@property (strong, nonatomic) IBOutlet JKExpandTableView *typeExpandTableView;

@end

