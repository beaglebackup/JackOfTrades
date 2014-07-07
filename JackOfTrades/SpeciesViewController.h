//
//  AntViewController.h
//  JackOfTrades
//
//  Created by Gabriel on 6/16/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeciesViewController : UIViewController {
    
    IBOutlet UICollectionView *speciesCollectionView;
}



@property (strong, nonatomic) NSArray* objects;


@property (strong, nonatomic) IBOutlet UIButton *argentineAntButton;
@property (strong, nonatomic) IBOutlet UIButton *blackVelvetAntButton;
@property (strong, nonatomic) IBOutlet UIButton *carpenterAntButton;
@property (strong, nonatomic) IBOutlet UIButton *crazyAntButton;
@property (strong, nonatomic) IBOutlet UIButton *odorousAntButton;
@property (strong, nonatomic) IBOutlet UIButton *pavementAntButton;
@property (strong, nonatomic) IBOutlet UIButton *pharoahAntButton;
@property (strong, nonatomic) IBOutlet UIButton *redFireAntButton;
@property (strong, nonatomic) IBOutlet UIButton *southernFireAntButton;
@property (strong, nonatomic) IBOutlet UIButton *thiefAntButton;
@property (strong, nonatomic) IBOutlet UIButton *velvetyAntButton;



@end
