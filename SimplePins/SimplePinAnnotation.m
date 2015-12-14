//
//  SimplePinAnnotation.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/14/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "SimplePinAnnotation.h"

@implementation SimplePinAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)location name:(NSString *)name description:(NSString *)description {
    self = [super init];
    if (self != nil) {
        _coordinate = location;
        _title = name;
        _subtitle = description;
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

@end
