//
//  AppDelegate.m
//  JackOfTrades
//
//  Created by Gabriel on 5/23/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "AppDelegate.h"
#import "JTLogInViewController.h"
#import "JTSignUpViewController.h"
#import "JTWelcomeViewController.h"
#import "Type.h"
#import "Subtype.h"

@interface AppDelegate ()
    
@property (nonatomic, strong) JTWelcomeViewController* welcomeController;
@property (nonatomic, strong) UINavigationController* navController;

@end

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
    
    
    self.navController = (UINavigationController*)self.window.rootViewController;
    self.welcomeController = (JTWelcomeViewController*)[self.navController .viewControllers  objectAtIndex:0];


    
    
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


#pragma mark - Login/Signup

- (void)presentLoginViewControllerAnimated:(BOOL)animated withDismissButton:(BOOL)withDismissButton {
    
    JTLogInViewController *loginViewController = [[JTLogInViewController alloc] init];
    [loginViewController setDelegate:self];
    
    if (withDismissButton == YES) {
        
        loginViewController.fields = PFLogInFieldsFacebook |
        PFLogInFieldsUsernameAndPassword
        | PFLogInFieldsLogInButton
        | PFLogInFieldsSignUpButton
        | PFLogInFieldsPasswordForgotten
        | PFLogInFieldsDismissButton;
        
    } else {
        
        loginViewController.fields = PFLogInFieldsFacebook |
        PFLogInFieldsUsernameAndPassword
        | PFLogInFieldsLogInButton
        | PFLogInFieldsSignUpButton
        | PFLogInFieldsPasswordForgotten;
        
    }
    
    
    
    JTSignUpViewController *signUpViewController = [[JTSignUpViewController alloc] init];
    [signUpViewController setDelegate:self];
    [loginViewController setSignUpController:signUpViewController];
    


    [self.welcomeController presentViewController:loginViewController animated:NO completion:nil];
    
}


- (void)userDidLogIn:(PFUser*)user {
    
//    
//    ////////////////////////////////////
//    // Subscribe to private push channel
//    if (user) {
//        
//        NSString *privateChannelName = [NSString stringWithFormat:@"user_%@", [user objectId]];
//        // Add the user to the installation so we can track the owner of the device
//        [[PFInstallation currentInstallation] setObject:[PFUser currentUser] forKey:kPAPInstallationUserKey];
//        // Subscribe user to private channel
//        [[PFInstallation currentInstallation] addUniqueObject:privateChannelName forKey:kPAPInstallationChannelsKey];
//        // Save installation object
//        [[PFInstallation currentInstallation] saveEventually];
//        
//        [user setObject:privateChannelName forKey:kPAPUserPrivateChannelKey];
//        [user saveEventually];
//    }
//    
    
    
  
    [self proceedToMainInterface:user];

}


- (void)userHasLoggedIn {
    

    [self proceedToMainInterface:[PFUser currentUser]];
    
}


- (void)proceedToMainInterface:(PFUser *)user {
    
    // Present the main interface
    [self.navController performSegueWithIdentifier:@"welcomeToType" sender:nil];

    
}

#pragma mark PFLoginViewController Delegate

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    
    [self userDidLogIn:user];
    
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    
    [logInController dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark PFSignupViewController Delegate

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    
    //////////////////////
    // Set the entered username as the displayname
//    [user setObject:[user username] forKey:kPAPUserDisplayNameKey];
//    [user saveEventually];
    
    
    ////////////////////
    // Pop the signup screen
    [self.welcomeController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    
    
    [self userDidLogIn:user];
    
}




@end
