//
//  PAPLogInViewController.m
//  Anypic
//
//  Created by Mattieu Gamache-Asselin on 5/17/12.
//

#import "JTLogInViewController.h"
#import "UIImage+Extensions.h"
#import "JTWelcomeViewController.h"

@interface JTLogInViewController ()

@property (nonatomic, strong) UIButton* continueButton;
@end


@implementation JTLogInViewController

@synthesize continueButton;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    // Title View
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
//    [titleLabel setTextColor:[UIColor colorNavBarTitle]];
    [titleLabel setText:@"Gabe's World"];
    [titleLabel sizeToFit];
    UIView *titleView = [[UIView alloc] initWithFrame:titleLabel.frame];
    [titleView addSubview:titleLabel];
    self.logInView.logo = titleView;



    
    self.logInView.usernameField.backgroundColor = [UIColor darkGrayColor];
    self.logInView.usernameField.textColor = [UIColor whiteColor];
    self.logInView.usernameField.layer.shadowOpacity = 0.0;
    self.logInView.usernameField.font = [UIFont systemFontOfSize:16.0f];
    self.logInView.usernameField.borderStyle = UITextBorderStyleNone;
    self.logInView.usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    self.logInView.passwordField.backgroundColor = [UIColor darkGrayColor];
    self.logInView.passwordField.textColor = [UIColor whiteColor];
    self.logInView.passwordField.layer.shadowOpacity = 0.0;
    self.logInView.passwordField.font = [UIFont systemFontOfSize:16.0f];
    self.logInView.passwordField.borderStyle = UITextBorderStyleNone;
    self.logInView.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    [self.logInView.signUpButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.logInView.signUpButton setTitleEdgeInsets:UIEdgeInsetsMake( 0.0f, 10.0f, 0.0f, 0.0f)];
    [self.logInView.signUpButton setTitleColor:[UIColor colorPurple] forState:UIControlStateSelected];
    [self.logInView.signUpButton setTitleColor:[UIColor colorPurple] forState:UIControlStateHighlighted];
    [self.logInView.signUpButton setTitleColor:[UIColor colorPurple] forState:UIControlStateNormal];

    [self.logInView.signUpButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorLavender]] forState:UIControlStateNormal]; // Need to keep these in here to override superclass settings
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorLavender]] forState:UIControlStateSelected];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorLavender]] forState:UIControlStateHighlighted];
    [self.logInView.signUpButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal]; // Need to keep these in here to override superclass settings
    [self.logInView.signUpButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
    [self.logInView.signUpButton.titleLabel setShadowOffset:CGSizeMake( 0.0f, 0.0f)];
    
    
    
    [self.logInView.logInButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.logInView.logInButton setTitleEdgeInsets:UIEdgeInsetsMake( 0.0f, 10.0f, 0.0f, 0.0f)];
    [self.logInView.logInButton setTitleColor:[UIColor colorPurple] forState:UIControlStateNormal];
    [self.logInView.logInButton setTitleColor:[UIColor colorPurple] forState:UIControlStateSelected];
    [self.logInView.logInButton setTitleColor:[UIColor colorPurple] forState:UIControlStateHighlighted];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorLavender]] forState:UIControlStateNormal]; // Need to keep these in here to override superclass settings
    [self.logInView.logInButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorLavender]] forState:UIControlStateSelected];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorLavender]] forState:UIControlStateHighlighted];
    [self.logInView.logInButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal]; // Need to keep these in here to override superclass settings
    [self.logInView.logInButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
    [self.logInView.logInButton.titleLabel setShadowOffset:CGSizeMake( 0.0f, 0.0f)];
    
    
    
    

    
    [self.logInView.signUpLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.logInView.signUpLabel setTextColor:[UIColor blackColor]];
    self.logInView.signUpLabel.shadowColor = [UIColor clearColor];

    

    
    

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    CGRect logoFrame = self.logInView.logo.frame;
    logoFrame.origin.y = 40.0f;
    [self.logInView.logo setFrame:logoFrame];
    
    
    CGRect usernameFrame = self.logInView.usernameField.frame;
    usernameFrame.origin.y = logoFrame.origin.y + logoFrame.size.height + 10.0f;
    [self.logInView.usernameField setFrame:usernameFrame];
    
    
    CGRect passwordFrame = self.logInView.passwordField.frame;
    passwordFrame.origin.y = usernameFrame.origin.y + usernameFrame.size.height + 1.0f;
    [self.logInView.passwordField setFrame:passwordFrame];
    
    
    CGRect loginFrame = self.logInView.logInButton.frame;
    loginFrame.origin.y = passwordFrame.origin.y + passwordFrame.size.height + 10.0f;
    [self.logInView.logInButton setFrame:loginFrame];
    [self.logInView.logInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // There's a bug in PFLoginView and this needs to be reset here

    
    
    CGRect forgotFrame = self.logInView.passwordForgottenButton.frame;
    CGFloat forgotYOffset = ((passwordFrame.origin.y + passwordFrame.size.height) - usernameFrame.origin.y) / 2 - forgotFrame.size.height/2;
    forgotFrame.origin.y = usernameFrame.origin.y + forgotYOffset;
    [self.logInView.passwordForgottenButton setFrame:forgotFrame];

    
    
    
    CGRect signupFrame = self.logInView.signUpButton.frame;
    signupFrame.origin.y = loginFrame.origin.y + loginFrame.size.height + 50.0f;
    [self.logInView.signUpButton setFrame:signupFrame];
    
    CGRect signUpLabelFrame = self.logInView.signUpLabel.frame;
    signUpLabelFrame.origin.y = signupFrame.origin.y - signUpLabelFrame.size.height - 5.0f;
    [self.logInView.signUpLabel setFrame:signUpLabelFrame];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}




@end
