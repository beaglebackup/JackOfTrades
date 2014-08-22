//
//  ViewController.m
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTTypeController.h"
#import "JTTypeButton.h"
#import "JTTypeCollectionCell.h"
#import "JTSubtypeViewController.h"
#import "Type.h"

@interface JTTypeController ()

@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;

@end

@implementation JTTypeController

@synthesize objects, collectionView;

- (void)viewDidLoad
{
    NSLog(@"in type controller");
    
    [super viewDidLoad];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.collectionView.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];

    
    // Set the collectionView delegate
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
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
    
    [self.collectionView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"[self.objects count] = %lu",(unsigned long)[self.objects count]);
    
    return [self.objects count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {

   
    JTTypeCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"TypeCollectionCell" forIndexPath:indexPath];
    
    
    // Get the object
    Type* type = [self.objects objectAtIndex:indexPath.item];
    
    
    // Set a tag to identify the object later
    cell.button.tag = indexPath.item;
    
    
    // Set the title && Add the trigger
    [cell.button setTitle:type.name forState:UIControlStateNormal];
    [cell.button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    

    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


#pragma mark – UICollectionViewDelegateFlowLayout

//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
////    NSString *searchTerm = self.searches[indexPath.section];
////    FlickrPhoto *photo = self.objects[indexPath.item];
////    // 2
////    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
////    retval.height += 35; retval.width += 35; return retval;
//
//     return CGSizeMake(100.0f, 50.0f);
//
//
//}
//
//
//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(50, 20, 50, 20);
//}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JTTypeButton* button = (JTTypeButton*)sender;
    
    if ([[segue identifier] isEqualToString:@"typeToSubtype"])
    {
        JTSubtypeViewController *subtypeVC = [segue destinationViewController];
        subtypeVC.typeName = button.titleLabel.text;
    }
}


#pragma mark - ()
- (void)didTapButton:(id)sender {

    JTTypeButton* button = (JTTypeButton*)sender;
    
    [self.objects objectAtIndex:button.tag];
    
    [self performSegueWithIdentifier:@"typeToSubtype" sender:sender];

    
}

@end
