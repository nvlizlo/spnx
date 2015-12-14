//
//  MapViewController.h
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User+CoreDataProperties.h"
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (nonatomic, strong) User *user;

- (void)mapViewRemoveAnnotation:(id<MKAnnotation>)annotation;

@end
