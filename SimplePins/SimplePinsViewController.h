//
//  SimplePinsViewController.h
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/13/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

typedef enum {
    AlertViewTagRegister,
    AlertViewTagContinue
} AlertViewTag;

@interface SimplePinsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (void)logInWithUser:(User *)user;
- (IBAction)logInButtonPressed:(UIButton *)sender;
- (void)saveLastUsedObjectId:(User *)user;

@end
