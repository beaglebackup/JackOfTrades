//
//  AntViewController.m
//  JackOfTrades
//
//  Created by Gabriel on 6/16/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTSubtypeViewController.h"
#import "JTSubtypeButton.h"
#import "JTSubtypeCollectionCell.h"
#import "JTDetailsViewController.h"
#import "Subtype.h"

@interface JTSubtypeViewController ()

@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;


@end

@implementation JTSubtypeViewController

@synthesize typeName, objects, subtypeCollectionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.center = self.subtypeCollectionView.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];

    
    
    // Set the collectionView delegate
    self.subtypeCollectionView.delegate = self;
    self.subtypeCollectionView.dataSource = self;
    
    
    // Call Parse for Data
    [JTDatabaseManager queryForSubtypes:typeName withCallback:^(NSArray *subtypes, NSError *error) {
        
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
            self.objects = subtypes;
            
            NSLog(@"JTSubtypeViewController -- self.objects = %@",self.objects);
            
            [self objectsDidLoad:error];
        }
    }];
}


- (void)objectsDidLoad:(NSError *)error {
    
    [self.activityIndicator stopAnimating];

    
    [self.subtypeCollectionView reloadData];
    
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
    
    
    JTSubtypeCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"SubtypeCollectionCell" forIndexPath:indexPath];
    
    
    // Get the object
    Subtype* subtype = [self.objects objectAtIndex:indexPath.item];
    
    
    // Set a tag to identify the object later
    cell.button.tag = indexPath.item;
    
    
    NSLog(@"subtype.name = %@",subtype.name);

    
    // Set the title && Add the trigger
    [cell.button setTitle:subtype.name forState:UIControlStateNormal];
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
    // Get the subtype object to pass it to detailsVC
    JTSubtypeButton* button = (JTSubtypeButton*)sender;
    Subtype* subtype = [self.objects objectAtIndex:button.tag];
    
    NSLog(@"subtype = %@",subtype);

    
    if ([[segue identifier] isEqualToString:@"subtypeToDetail"])
    {
        JTDetailsViewController *detailsVC = [segue destinationViewController];
        detailsVC.subtype = subtype;
    }
}


#pragma mark - ()
- (void)didTapButton:(id)sender {
    
    NSLog(@"didTapButton");
    [self performSegueWithIdentifier:@"subtypeToDetail" sender:sender];
    
    
}

@end
