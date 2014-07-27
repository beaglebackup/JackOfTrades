//
//  JTDatabaseManager.m
//  JackOfTrades
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "JTDatabaseManager.h"


@implementation JTDatabaseManager

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Queries
+ (void)queryForTypesWithCallback:(void(^)(NSArray *types, NSError *error))callback{
    
    PFQuery *typeQuery = [Type query];
    
    [typeQuery orderByAscending:[Type nameKey]];

    [typeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            callback(objects,nil);
        }
    }];
}

+ (void)queryForSubtypes:(NSString*)type withCallback:(void(^)(NSArray *types, NSError *error))callback{
    
    PFQuery *subtypeQuery = [Subtype query];
    
    NSLog(@"queryForSubtypes -- type = %@",type);
    
    [subtypeQuery whereKey:[Subtype parentStringKey] equalTo:type];
    
    // Only include basic keys
    NSArray* keys = [NSArray arrayWithObjects:[Subtype nameKey],
                                             [Subtype parentStringKey],
                                             nil];
    [subtypeQuery selectKeys:keys];
    
    [subtypeQuery orderByAscending:[Subtype nameKey]];
    
    [subtypeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            callback(objects,nil);
        }
    }];
}


+ (void)getAllKeysForSubtype:(Subtype*)subtype withCallback:(void(^)(Subtype* theSubtype, NSError *error))callback{
    
    // Requery without any key restraints (get all keys)
    PFQuery *subtypeQuery = [Subtype query];
    
    [subtypeQuery getObjectInBackgroundWithId:[subtype objectId] block:^(PFObject *object, NSError *error) {
        callback(object, error);
    }];

    
 
}


@end
