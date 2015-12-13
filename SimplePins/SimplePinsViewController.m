//
//  SimplePinsViewController.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/13/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "SimplePinsViewController.h"
#import "MapViewController.h"
#import "RegisterViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Defines.h"

@interface SimplePinsViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@end

@implementation SimplePinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)logInWithUser:(User *)user {
    [self saveLastUsedObjectId:user];
    MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    mapViewController.user = user;
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (void)moveToRegisterViewController {
    RegisterViewController *registerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (IBAction)logInButtonPressed:(UIButton *)sender {
    //update for UIAlertController
    if (self.usernameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Username is empty!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    } else if (self.passwordTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Password is empty!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
}

- (void)saveLastUsedObjectId:(User *)user {
    [[NSUserDefaults standardUserDefaults] setObject:user.objectID.URIRepresentation.absoluteString forKey:LAST_OBJECT_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == AlertViewTagRegister) {
        switch (buttonIndex) {
            case 0:
                [self moveToRegisterViewController];
                break;
            case 1:
                break;
            default:
                break;
        }
    } else if (alertView.tag == AlertViewTagContinue) {
        switch (buttonIndex) {
            case 0:
                [FBSDKAccessToken setCurrentAccessToken:nil];
                [self logInWithUser:[User getUserByName:_usernameTextField.text password:_passwordTextField.text]];
                break;
            case 1:
                break;
            default:
                break;
        }
    }
}

@end
