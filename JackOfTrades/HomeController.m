//
//  ViewController.m
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "HomeController.h"
#import "JTHomeButton.h"

@interface HomeController ()

@end

@implementation HomeController

@synthesize objects;

- (void)viewDidLoad
{
    [super viewDidLoad];
	[homeScrollView setScrollEnabled:YES];
    [homeScrollView setContentSize:CGSizeMake(320,600)];
    
    // Call Parse for Data
    self.objects = nil;
    
    
//    // Create Buttons
//    [self.objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        
//        if (idx % 2) { // odd
//            
//        }
//        else { //even
//            
//        }
//        
//        
//        UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
//        
//        // Set a tag to identify the object later
//        button.tag = idx;
//        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.objects count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell " forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    // Add a button to the cell
    JTHomeButton* button = [JTHomeButton buttonWithType:UIButtonTypeSystem];
    
    // Set a tag to identify the object later
    button.tag = indexPath.item;
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:button];

    
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

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
//    self.searchResults[searchTerm][indexPath.row];
//    // 2
//    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
//    retval.height += 35; retval.width += 35; return retval;
    
    
    
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - ()
- (void)didTapButton:(UIButton *)button {
    
    [self.objects objectAtIndex:button.tag];
    
}

@end
