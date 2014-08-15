//
//  JTTypeExpandController.m
//  JackOfTrades
//
//  Created by Admin on 8/14/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTTypeExpandController.h"
#import "JTTypeTableViewCell.h"
#import "Type.h"
#import "JTSubtypeViewController.h"


@interface JTTypeExpandController ()

@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;

@end



@implementation JTTypeExpandController

@synthesize objects, typeExpandTableView;


- (void)viewDidLoad
{
    NSLog(@"in type controller");
    
    [super viewDidLoad];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.typeExpandTableView.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    
    // Set the collectionView delegate
    self.typeExpandTableView.delegate = self;
    self.typeExpandTableView.dataSource = self;
    
    
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
            self.objects = types;
            
            NSLog(@"self.objects = %@",self.objects);
            
            [self objectsDidLoad:error];
        }
    }];
}


- (void)objectsDidLoad:(NSError *)error {
    
    [self.activityIndicator stopAnimating];
    
    [self.typeExpandTableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"[self.objects count] = %lu",(unsigned long)[self.objects count]);
    
    return [self.objects count];
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
    
    
    // Get the object
    Type* type = [self.objects objectAtIndex:indexPath.item];
    
    
    // Set a tag to identify the object later
    cell.leftTypeButton.tag = indexPath.item;
    
    
    // Set the title && Add the trigger
    [cell.leftTypeButton setTitle:type.name forState:UIControlStateNormal];
    [cell.leftTypeButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}





#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    if ([[segue identifier] isEqualToString:@"typeToSubtype"])
    {
        JTSubtypeViewController *subtypeVC = [segue destinationViewController];
        subtypeVC.typeName = button.titleLabel.text;
    }
}


#pragma mark - ()
- (void)didTapButton:(id)sender {
    
    UIButton* button = (UIButton*)sender;
    
    [self.objects objectAtIndex:button.tag];
    
    [self performSegueWithIdentifier:@"typeToSubtype" sender:sender];
    
    
}

@end
