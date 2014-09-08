//
//  JTDatabaseManager.h
//  JackOfTrades
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Type.h"
#import "Subtype.h"

@interface JTDatabaseManager : NSObject


#pragma mark - Queries
+ (void)queryForTypesWithCallback:(void(^)(NSArray *types, NSError *error))callback;
+ (void)queryForSubtypes:(NSString*)type withCallback:(void(^)(NSArray *types, NSError *error))callback;
+ (void)getAllKeysForSubtype:(Subtype*)subtype withCallback:(void(^)(Subtype* theSubtype, NSError *error))callback;


#pragma mark - Admin
+ (void)addSubtypesToTypes;

@end
