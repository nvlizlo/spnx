//
//  Pin+CoreDataProperties.h
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/14/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Pin.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pin (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *attitude;
@property (nullable, nonatomic, retain) NSNumber *longtitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *info;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
