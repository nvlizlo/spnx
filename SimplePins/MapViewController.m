//
//  MapViewController.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "MapViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"
#import "Defines.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkLocationAuthorizationStatus];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[FBSDKLoginManager new] logOut];
}

- (void)checkLocationAuthorizationStatus {
    _locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        _mapView.showsUserLocation = YES;
    } else {
        [_locationManager requestWhenInUseAuthorization];
    }
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    for(MKAnnotationView *annotationView in views) {
        if(annotationView.annotation == _mapView.userLocation) {
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            
            span.latitudeDelta=0.1;
            span.longitudeDelta=0.1;
            
            CLLocationCoordinate2D location=_mapView.userLocation.coordinate;
            
            region.span=span;
            region.center=location;
            
            [_mapView setRegion:region animated:YES];
            [_mapView regionThatFits:region];
        }
    }
}

- (void)setUser:(User *)user {
    _user = user;
    self.title = [NSString stringWithFormat:@"Welcome, %@", _user.name];
}

@end
