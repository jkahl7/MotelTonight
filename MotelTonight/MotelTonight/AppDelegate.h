//
//  AppDelegate.h
//  MotelTonight
//
//  Created by Josh Kahl on 2/9/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//represents a single “object space” or scratch pad in an application. Its primary responsibility is to manage a collection of managed objects.
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//describes a schema—a collection of entities (data models) that you use in your application.
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

//associate persistent stores (by type) with a model (or more accurately, a configuration of a model) and serve to mediate between the persistent store or stores and the managed object context or contexts.
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

