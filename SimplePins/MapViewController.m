//
//  MapViewController.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "MapViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[FBSDKLoginManager new] logOut];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUsername:(NSString *)username {
    _username = username;
    self.title = [NSString stringWithFormat:@"Welcome, %@", _username];
}

@end
