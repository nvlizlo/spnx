//
//  ViewController.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MapViewController.h"
#import <CoreData/CoreData.h>
#import "User.h"

@interface ViewController () <FBSDKLoginButtonDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessToken] != nil) {
        [self logInWithCurrentUser];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_usernameTextField resignFirstResponder];
}

- (IBAction)logInButtonPressed:(UIButton *)sender {
    if (_usernameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Username is empty!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        
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
        if ([result.grantedPermissions containsObject:@"public_profile"]) {
            if ([FBSDKAccessToken currentAccessToken] != nil) {
                [self logInWithCurrentUser];
            }
        }
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"Log out");
}

- (BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton {
    return YES;
}

- (void)logInWithCurrentUser {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"fields" : @"name,picture.type(large)"}];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             NSString *name = [result valueForKey:@"name"];
             MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
             mapViewController.username = name;
             [self.navigationController pushViewController:mapViewController animated:YES];
         }
         
     }];
}

#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
