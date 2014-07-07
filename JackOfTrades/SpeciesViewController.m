//
//  AntViewController.m
//  JackOfTrades
//
//  Created by Gabriel on 6/16/14.
//  Copyright (c) 2014 Gabriel. All rights reserved.
//

#import "SpeciesViewController.h"

@interface SpeciesViewController ()

@end

@implementation SpeciesViewController

@synthesize objects;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Call Parse for Data
    self.objects = nil;
    
    
    // Create Buttons
    [self.objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if (idx % 2) { // odd
            
        }
        else { //even
        
        }
        
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        // Set a tag to identify the object later
        button.tag = idx;
        [button addTarget:self action:@selector(didTapSpeciesButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - ()
- (void)didTapSpeciesButton:(UIButton *)button {
    
    
    
   
}

@end
