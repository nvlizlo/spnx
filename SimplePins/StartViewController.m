//
//  ViewController.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "StartViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MapViewController.h"
#import <CoreData/CoreData.h>
#import "User+CoreDataProperties.h"
#import "Defines.h"
#import "AppDelegate.h"

@interface StartViewController () <FBSDKLoginButtonDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User userById:LAST_OBJECT_ID];
    if ( user != nil) {
        [self logInWithUser:user];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (IBAction)logInButtonPressed:(UIButton *)sender {
    //update for UIAlertController
    [super logInButtonPressed:sender];
    User *currentUser;
    if ((currentUser = [User getUserByName:self.usernameTextField.text password:self.passwordTextField.text]) == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"That user isn't exist"
                                                            message:@"Would you like to create new user?"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Yes", @"No", nil];
        alertView.tag = AlertViewTagRegister;
        [alertView show];
    } else {
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [self logInWithUser:currentUser];
    }
}

#pragma mark FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error != nil) {
        NSLog(@"%@", error.description);
    } else if (result.isCancelled) {
        NSLog(@"The result was cancelled");
    } else {
        NSLog(@"Logged in");
        if ([FBSDKAccessToken currentAccessToken] != nil) {
            [self logInWithFacebookUser:[FBSDKAccessToken currentAccessToken].tokenString];
        }
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"Log out");
}

- (BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton {
    return YES;
}

- (void)logInWithFacebookUser:(NSString *)tokenString {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"fields" : @"name,picture.type(large)"}];
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:parameters
                                      tokenString:tokenString
                                          version:nil
                                       HTTPMethod:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             User *user;
             NSString *username = [result valueForKey:@"name"];
             NSString *userPassword = [[result valueForKey:@"id"] substringToIndex:PASSWORD_LENGTH];
             if ([User getUserByName:username password:userPassword] != nil) {
                 user = [User getUserByName:username password:userPassword];
             } else {
                 user = [User createNewUser:username password:userPassword];
             }
             [self logInWithUser:user];
         }
     }];
}

@end
