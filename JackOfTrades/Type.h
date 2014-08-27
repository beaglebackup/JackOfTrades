//
//  Type.h
//  JackOfTrades
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface Type : PFObject <PFSubclassing>


@property (retain) NSString *name;
@property (retain) PFFile *thumb;
@property (retain) NSArray *subtypes;

+ (NSString *)parseClassName;

+ (NSString *)nameKey;

+ (NSString *)subtypesKey;


@end
