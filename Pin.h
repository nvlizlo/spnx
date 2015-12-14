//
//  Pin.h
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class User;

NS_ASSUME_NONNULL_BEGIN

@interface Pin : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(Pin *)createPinName:(NSString *)name description:(NSString *)info coordinate:(CLLocationCoordinate2D)coordinate;
+(Pin *)getPinByName:(NSString *)name description:(NSString *)info user:(User *)user;
- (void)updateValues:(id<MKAnnotation>)annotation;

@end

NS_ASSUME_NONNULL_END

#import "Pin+CoreDataProperties.h"
