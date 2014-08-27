//
//  PAPWelcomeViewController.m
//  Anypic
//
//  Created by Héctor Ramos on 5/10/12.
//

#import "JTWelcomeViewController.h"
#import "AppDelegate.h"

@interface JTWelcomeViewController ()



@end

@implementation JTWelcomeViewController


#pragma mark - UIViewController


- (id)init {
    
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // View Stuffs
    UIImageView* backgroudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    [self.view addSubview:backgroudImageView];
    [self.view sendSubviewToBack:backgroudImageView];
    
    
    
   
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
        
    /////////////////
    // If not logged in, present login view controller
    if ([self presentLoginViewController]) {
        
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentLoginViewControllerAnimated:NO withDismissButton:NO];
        return;
    }
    
    else {
        
        /////////////////
        // Or else just start the app if everything checks out
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] userHasLoggedIn];
    }
    
    
    
    // Refresh current user with server side data -- checks if user is still valid and so on
    if ([PFUser currentUser]) {
    
        [[PFUser currentUser] refreshInBackgroundWithTarget:self selector:@selector(refreshCurrentUserCallbackWithResult:error:)];
    }
    
}




#pragma mark - ()
- (BOOL)presentLoginViewController {
    
    if (![PFUser currentUser]) {
        
        return YES;
    }

    return NO;
}



- (void)refreshCurrentUserCallbackWithResult:(PFObject *)refreshedObject error:(NSError *)error {
    
    // A kPFErrorObjectNotFound error on currentUser refresh signals a deleted user
    if (error && error.code == kPFErrorObjectNotFound) {
        NSLog(@"User does not exist.");
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] logOut];
        return;
    }
}



@end
