//
//  Subtype.m
//  JackOfTrades
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//
#import <Parse/PFObject+Subclass.h>
#import "Subtype.h"

@implementation Subtype

@dynamic name;
@dynamic mainPhoto;
@dynamic text;
@dynamic parentString;


+ (NSString *)parseClassName {
    return @"Subtype";
}

+ (NSString *)nameKey {
    return @"name";
}

+ (NSString *)parentStringKey {
    return @"parentString";
}



@end
