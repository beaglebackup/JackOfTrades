//
//  ViewController.h
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTTypeController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    
    
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@property (strong, nonatomic) NSArray* objects;



@end
