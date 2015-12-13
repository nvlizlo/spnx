//
//  User.m
//  SimplePins
//
//  Created by Nazariy Vlizlo on 12/12/15.
//  Copyright © 2015 Nazariy Vlizlo. All rights reserved.
//

#import "User.h"
#import "Pin.h"
#import "AppDelegate.h"
#import "Defines.h"
@implementation User

// Insert code here to add functionality to your managed object subclass
+ (User *)createNewUser:(NSString *)name password:(NSString *)password {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    NSError *error = nil;
    
    user.name = name;
    user.password = @([password integerValue]);
    if ([managedObjectContext save:&error]) {
        return user;
    } else {
        return nil;
    }
}

+ (User *)getUserByName:(NSString *)name password:(NSString *)password {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSFetchRequest *requestForUsers = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name = %@ AND password = %@", name, password];
    
    requestForUsers.predicate = namePredicate;
    NSError *error = nil;
    NSArray *users = [managedObjectContext executeFetchRequest:requestForUsers error:&error];
    return users.firstObject;
}

+ (User *)userById:(NSString *)idString {
    User *user;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSString *objectIdUrlString = [[NSUserDefaults standardUserDefaults] objectForKey:idString];
    NSError *error  = nil;
    
    if (objectIdUrlString != nil) {
        NSManagedObjectID *userId = [appDelegate.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:objectIdUrlString]];
        user = [managedObjectContext existingObjectWithID:userId error:&error];
    }
    return user;
}

+ (void)deleteLastObjectId {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:LAST_OBJECT_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
