//
//  Pin.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "Pin.h"
#import "User.h"
#import "Appdelegate.h"

@implementation Pin

// Insert code here to add functionality to your managed object subclass
+ (Pin *)createPinName:(NSString *)name description:(NSString *)info coordinate:(CLLocationCoordinate2D)coordinate {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    Pin *pin = [NSEntityDescription insertNewObjectForEntityForName:@"Pin" inManagedObjectContext:managedObjectContext];
    NSError *error = nil;
    
    pin.name = name;
    pin.info = info;
    pin.attitude = @(coordinate.latitude);
    pin.longtitude = @(coordinate.longitude);
    if ([managedObjectContext save:&error]) {
        return pin;
    } else {
        return nil;
    }
}

+ (Pin *)getPinByName:(NSString *)name description:(NSString *)info user:(User *)user {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSFetchRequest *requestForUsers = [[NSFetchRequest alloc] initWithEntityName:@"Pin"];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name = %@ AND info = %@ AND user == %@", name, info, user];
    
    requestForUsers.predicate = namePredicate;
    NSError *error = nil;
    NSArray *pins = [managedObjectContext executeFetchRequest:requestForUsers error:&error];
    return pins.firstObject;
}

- (void)updateValues:(id<MKAnnotation>)annotation {
    self.attitude = @(annotation.coordinate.latitude);
    self.longtitude = @(annotation.coordinate.longitude);
    self.name = annotation.title;
    self.info = annotation.subtitle;
}
@end
