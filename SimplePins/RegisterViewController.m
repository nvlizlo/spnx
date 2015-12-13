//
//  RegisterViewController.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/13/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "RegisterViewController.h"
#import "MapViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface RegisterViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)logInButtonPressed:(UIButton *)sender {
    [super logInButtonPressed:sender];
    User *currentUser;
    if ((currentUser = [User getUserByName:self.usernameTextField.text password:self.passwordTextField.text]) != nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"That user already exist"
                                    message:@"Would you like to create and continue with this user?"
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Yes", @"No", nil];
        alertView.tag = AlertViewTagContinue;
        [alertView show];
    } else {
        currentUser = [User createNewUser:self.usernameTextField.text password:self.passwordTextField.text];
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [self logInWithUser:currentUser];
    }
}

@end
