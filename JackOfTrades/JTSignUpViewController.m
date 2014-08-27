//
//  WSSignUpViewController.m
//  WSPhoto
//
//  Created by Admin on 1/21/14.
//
//

#import "JTSignUpViewController.h"
#import "UIImage+Extensions.h"

@interface JTSignUpViewController ()

@end

@implementation JTSignUpViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        [self createViews];
        
    }
    return self;
}

-(void)createViews {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Title View
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
//    [titleLabel setTextColor:[UIColor colorNavBarTitle]];
//    [titleLabel setText:[kLocalizedAppName uppercaseString]];
    [titleLabel sizeToFit];
    UIView *titleView = [[UIView alloc] initWithFrame:titleLabel.frame];
    [titleView addSubview:titleLabel];
    self.signUpView.logo = titleView;
    
    
    
    [self.signUpView.signUpButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.signUpView.signUpButton setTitleEdgeInsets:UIEdgeInsetsMake( 0.0f, 10.0f, 0.0f, 0.0f)];
    [self.signUpView.signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.signUpView.signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.signUpView.signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal]; // Need to keep these in here to override superclass settings
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.signUpView.signUpButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
    [self.signUpView.signUpButton.titleLabel setShadowOffset:CGSizeMake( 0.0f, 0.0f)];
    
    
    self.signUpView.usernameField.backgroundColor = [UIColor darkGrayColor];
    self.signUpView.usernameField.textColor = [UIColor whiteColor];
    self.signUpView.usernameField.layer.shadowOpacity = 0.0;
    self.signUpView.usernameField.font = [UIFont systemFontOfSize:15.0f];
    self.signUpView.usernameField.borderStyle = UITextBorderStyleNone;
    self.signUpView.usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    self.signUpView.passwordField.backgroundColor = [UIColor darkGrayColor];
    self.signUpView.passwordField.textColor = [UIColor whiteColor];
    self.signUpView.passwordField.layer.shadowOpacity = 0.0;
    self.signUpView.passwordField.font = [UIFont systemFontOfSize:15.0f];
    self.signUpView.passwordField.borderStyle = UITextBorderStyleNone;
    self.signUpView.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    self.signUpView.emailField.backgroundColor = [UIColor darkGrayColor];
    self.signUpView.emailField.textColor = [UIColor whiteColor];
    self.signUpView.emailField.layer.shadowOpacity = 0.0;
    self.signUpView.emailField.font = [UIFont systemFontOfSize:15.0f];
    self.signUpView.emailField.borderStyle = UITextBorderStyleNone;
    self.signUpView.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;


    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
