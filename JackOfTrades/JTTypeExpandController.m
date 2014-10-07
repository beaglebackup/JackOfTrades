//
//  JTTypeExpandController.m
//  JackOfTrades
//
//  Created by Admin on 8/14/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTTypeExpandController.h"
#import "Type.h"
#import "JTSubtypeViewController.h"
#import "JTDetailsViewController.h"
#import "JTTypeSegueHackButton.h"


@interface JTTypeExpandController () {
    NSInteger selectedObject;
}

@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;

@end



@implementation JTTypeExpandController

@synthesize objects, objectsSubtypeArrays, typeExpandTableView;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorPurple];

    
    // Set the title
    self.title = @"Jack of Trades";
    
    
    // Hide back button for this view
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setBackBarButtonItem:nil];
    
    
    // Back button for child view
    UIBarButtonItem *backButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];


    
    
    
    // Activity Indicator
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.typeExpandTableView.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    

    
    // Call Parse for Data
    [JTDatabaseManager queryForTypesWithCallback:^(NSArray *types, NSError *error) {
        
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
            
            
            // Order subtypes
            __block NSMutableArray* orderedTypes = [[NSMutableArray alloc] initWithCapacity:[types count]];
            
            [types enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
                Type* type = (Type*)obj;
                NSArray* subtypes = type.subtypes;                
                NSArray* orderedSubtypes = [subtypes sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                    NSString *first = [(Subtype*)a name];
                    NSString *second = [(Subtype*)b name];
                    return [first compare:second];
                }];
                
                type.subtypes = orderedSubtypes;
                
                [orderedTypes insertObject:type atIndex:idx];
                
            }];
            
            self.objects = orderedTypes;
            
            [self objectsDidLoad:error];
        }
    }];
}


- (void)objectsDidLoad:(NSError *)error {
    
    [self.activityIndicator stopAnimating];
    
    // Set the tableVew delegate
    self.typeExpandTableView.SKSTableViewDelegate = self;
    
    [self.typeExpandTableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (ceil([self.objects count]/2)); // Divide by two - round up
}



- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtObjectIndex:(NSInteger)objectIndex
{
    Type* typeObject = (Type*)self.objects[objectIndex];
    
    return typeObject.subtypes.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JTTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typeTableViewCell"];
    
    if (nil == cell) {
        
        cell = [[JTTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"typeTableViewCell"];
    }
    
    cell.delegate = self;
    cell.backgroundColor = [UIColor colorPurple];
    
    NSInteger leftItem = indexPath.row * 2;
    NSInteger rightItem = indexPath.row * 2 + 1;
    
    
    // Get the objects
    Type* typeLeft = [self.objects objectAtIndex:leftItem];
    Type* typeRight = [self.objects objectAtIndex:rightItem];

    
    // Set a tag to identify the object later
    cell.leftTypeButton.tag = leftItem;
    cell.rightTypeButton.tag = rightItem;

    
    // Set the title && Add the trigger
    [cell.leftTypeLabel setText:typeLeft.name];
    [cell.rightTypeLabel setText:typeRight.name];

    
    // Set the thumb images
    PFFile* leftThumbFile = typeLeft.thumb;
        
    if(leftThumbFile != NULL)
    {
        
        [leftThumbFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            [self.activityIndicator stopAnimating];
            if (!error) {
                [cell.leftTypeButton setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
            }
        }];
    }
    
    PFFile* rightThumbFile = typeRight.thumb;
    if(rightThumbFile != NULL)
    {
        [rightThumbFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            [self.activityIndicator stopAnimating];
            if (!error) {
                [cell.rightTypeButton setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
            }
        }];
    }


    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath objectIndex:(NSInteger)objectIndex

{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.tag = objectIndex;
    
    
    Type* type = self.objects[objectIndex];
    Subtype* subtype = type.subtypes[indexPath.subRow-1]; // FIXME: Why -1?
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", subtype.name];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Get the Type (from self.objects)
    Type* type = self.objects[selectedObject];
    
    Subtype* subtype = type.subtypes[indexPath.subRow-1]; // FIXME: Why -1?
    
    JTTypeSegueHackButton* button = [[JTTypeSegueHackButton alloc] init];
    button.subtype = subtype;

    
    [self performSegueWithIdentifier:@"subtypeToDetail" sender:button];

}


    



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JTTypeSegueHackButton* button = (JTTypeSegueHackButton*)sender;
    
    if ([[segue identifier] isEqualToString:@"subtypeToDetail"])
    {
        JTDetailsViewController *detailsVC = [segue destinationViewController];
        detailsVC.subtype = button.subtype;
        detailsVC.navTitle = button.subtype.name;
    }
    
    // No backButton text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

}


#pragma mark - ()
- (void)typeCell:(JTTypeTableViewCell *)typeCell didTapButton:(UIButton *)button {

    NSInteger row = floor(button.tag / 2); // Divide by two - round down
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    selectedObject = button.tag; // Hack to save the objectIndex
    
    [self.typeExpandTableView expandCell:typeCell atIndexPath:indexPath forObjectIndex:button.tag];

    
}

@end
