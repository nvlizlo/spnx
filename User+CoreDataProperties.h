//
//  User+CoreDataProperties.h
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Pin *> *pins;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPinsObject:(Pin *)value;
- (void)removePinsObject:(Pin *)value;
- (void)addPins:(NSSet<Pin *> *)values;
- (void)removePins:(NSSet<Pin *> *)values;

@end

NS_ASSUME_NONNULL_END
