//
//  AntViewController.h
//  JackOfTrades
//
//  Created by Gabriel on 6/16/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTSubtypeViewController : UIViewController {
    
}

@property (strong, nonatomic) IBOutlet UICollectionView *subtypeCollectionView;


@property (strong, nonatomic) NSArray* objects;

/**
 * typeName - Used to pass the Type to query on
 *
 */
@property (strong, nonatomic) NSString* typeName;



@end
