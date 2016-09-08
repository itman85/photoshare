//
//  SignUpViewController.m
//  
//
//  Created by Phan Nguyen on 3/26/2015.
//  Copyright (c) 2015. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignUpViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signup:(id)sender {
    NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (username.length != 0 && password.length != 0) {
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            } else {
                // Show the errorString somewhere and let the user try again.
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error signing up" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
        }];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username or password field is empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
