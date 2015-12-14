//
//  SimplePinAnnotation.h
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/14/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SimplePinAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)location name:(NSString *)name description: (NSString *)description;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
