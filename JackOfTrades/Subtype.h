//
//  Subtype.h
//  JackOfTrades
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Subtype : PFObject <PFSubclassing>

@property (retain) NSString *name;
@property (retain) PFFile *mainPhoto;
@property (retain) NSString *mainText;

@property (retain) NSString* RX;
@property (retain) NSString* hands;
@property (retain) NSString* toolbox;
@property (retain) NSString* bulb;



@property (retain) NSString *parentString;



+ (NSString *)parseClassName;

+ (NSString *)nameKey;

+ (NSString *)parentStringKey;

+ (NSString *)textPointerKey;
@end
