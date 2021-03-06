//
//  User.h
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pin;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (User *)createNewUser:(NSString *)name password:(NSString *)password;
+ (User *)getUserByName:(NSString *)name password:(NSString *)password;
+ (User *)userById:(NSString *)idString;
+ (void)deleteLastObjectId;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
