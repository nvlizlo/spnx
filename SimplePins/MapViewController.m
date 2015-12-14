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
#import "SimplePinAnnotation.h"
#import "SimplePinAnnotationView.h"
#import "Pin.h"
#import "AppDelegate.h"

@interface MapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *initialLocation;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mapViewRemoveAnnotation:) name:REMOVE_ANNOTATION object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadAnnotations];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkLocationAuthorizationStatus];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)checkLocationAuthorizationStatus {
    _locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        _mapView.showsUserLocation = YES;
    } else {
        [_locationManager requestWhenInUseAuthorization];
    }
}

- (IBAction)logoutButtonPressed:(id)sender {
    if ([self saveAnnotations]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[FBSDKLoginManager new] logOut];
    }
}

- (IBAction)addAnnotationButtonPressed:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add annotation" message:@"Type name and description for annotation" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_mapView addAnnotation:[[SimplePinAnnotation alloc] initWithCoordinate:_mapView.userLocation.location.coordinate
                                                                           name:alertController.textFields.firstObject.text
                                                                    description:alertController.textFields.lastObject.text]];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter a name";
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter a description";
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSString *identifier = @"SimplePin";
    if ([annotation isKindOfClass:[SimplePinAnnotation class]]) {
        SimplePinAnnotationView *simplePinView = (SimplePinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (simplePinView == nil) {
            simplePinView = [[SimplePinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            simplePinView.annotation = annotation;
        }
        return simplePinView;
    } else if (annotation == mapView.userLocation) {
        return nil;
    }
    return nil;
}

- (void)mapViewRemoveAnnotation:(NSNotification *)notification {
    [_mapView removeAnnotation:[notification.userInfo objectForKey:@"annotation"]];
}

- (void)loadAnnotations {
    NSArray *pinAnnotations = _user.pins.allObjects;
    for (Pin *pin in pinAnnotations) {
        SimplePinAnnotation *simplePinAnnotation = [[SimplePinAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(pin.attitude.doubleValue, pin.longtitude.doubleValue)
                                                                                              name:pin.name
                                                                                       description:pin.info];
        [_mapView addAnnotation:simplePinAnnotation];
    }
}

- (BOOL)saveAnnotations {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSError *error = nil;
    
    NSArray *annotations = _mapView.annotations;
    for (id<MKAnnotation> annotation in annotations) {
        if (annotation == _mapView.userLocation) {
            continue;
        }
        Pin *pin = [Pin getPinByName:[annotation title] description:[annotation subtitle]  user:_user];
        if (![_user.pins containsObject:pin]) {
            pin = [Pin createPinName:[annotation title] description:[annotation subtitle] coordinate:[annotation coordinate]];
            [_user addPinsObject:pin];
        } else {
            [pin updateValues:annotation];
        }
    }
    return [managedObjectContext save:&error];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!self.initialLocation) {
        self.initialLocation = userLocation.location;
        MKCoordinateRegion mapRegion;
        mapRegion.center = mapView.userLocation.coordinate;
        mapRegion.span.latitudeDelta = 0.2;
        mapRegion.span.longitudeDelta = 0.2;
        
        [mapView setRegion:mapRegion animated: YES];
    }
}

- (void)setUser:(User *)user {
    _user = user;
    self.title = [NSString stringWithFormat:@"Welcome, %@", _user.name];
}

@end
