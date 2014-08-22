//
//  JTTypeExpandController.h
//  JackOfTrades
//
//  Created by Admin on 8/14/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "JTTypeTableViewCell.h"


@interface JTTypeExpandController : UIViewController <UITableViewDataSource, UITableViewDelegate, SKSTableViewDelegate, JTTypeTableViewCellDelegate>

@property (strong, nonatomic) NSArray* objects;
@property (strong, nonatomic) NSArray* objectsSubtypeArrays;

@property (strong, nonatomic) IBOutlet SKSTableView *typeExpandTableView;

@end

