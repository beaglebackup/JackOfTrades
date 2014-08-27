//
//  AppDelegate.m
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "AppDelegate.h"
#import "Type.h"
#import "Subtype.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Register Parse data subclasses
    [Type registerSubclass];
    [Subtype registerSubclass];
    
    
    // Initialize Parse
    [Parse setApplicationId:@"qnCDYVRzw5ysXZGS7r25ntqsFq5HGCyWIG7CtGHO"
                  clientKey:@"EodWjT2NWMIKDq2I98FcqefhDv9Uvc9wDS5v3YlA"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [self setupAppearance];
    
    
    // Admin
//    [JTDatabaseManager addSubtypesToTypes];
//    [JTDatabaseManager moveSubtypeTextToClass];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - ()
- (void) setupAppearance {
    // Navigation bar appearance (background and title)
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20.0f], NSFontAttributeName, nil]];
    
    if([UINavigationBar instancesRespondToSelector:@selector(barTintColor)]){ //iOS7
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorLightBeige]];
    }
    else {
        [[UINavigationBar appearance] setBackgroundColor:[UIColor colorLightBeige]];

    }
    // Navigation bar buttons appearance
    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorLightBeige], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18.0f], NSFontAttributeName, nil]];
}

@end
