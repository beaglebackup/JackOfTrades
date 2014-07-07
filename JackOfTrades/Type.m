//
//  Type.m
//  JackOfTrades
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//
#import <Parse/PFObject+Subclass.h>
#import "Type.h"

@implementation Type

@dynamic name;



+ (NSString *)parseClassName {
    return @"Type";
}

+ (NSString *)nameKey {
    return @"name";
}



@end
