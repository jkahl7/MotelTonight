//
//  HotelService.m
//  MotelTonight
//
//  Created by Josh Kahl on 2/11/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "HotelService.h"

@implementation HotelService

//TODO: may need to change this to id also check .h file
+ (instancetype)sharedService
{
  static HotelService *sharedHotelService = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^
  {
    sharedHotelService = [[self alloc] init];
  });
  return sharedHotelService;
}


-(instancetype)init
{
  self = [super init];
  if (self)
  {
    self.coreDataStack = [[CoreDataStack alloc] init];
  }
  return self;
}


#pragma initForTesting
-(instancetype)initForTesting
{
  self = [super init];
  if (self)
  {
    self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  }
  return self;
}


- (Reservation *)bookReservationForGuest:(Guest *)guest
                                 ForRoom:(Room *)room
                             arrivalDate:(NSDate *)arrival
                           departureDate:(NSDate *)departure
{
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation"
                                                           inManagedObjectContext:self.coreDataStack.managedObjectContext];
  reservation.room      = room;
  reservation.guest     = guest;
  reservation.startDate = arrival;
  reservation.endDate   = departure;

  NSError *saveError;
  
  [self.coreDataStack.managedObjectContext save:&saveError];
  
  if (!saveError)
  {
    return reservation;
  } else {
    NSLog(@"saveError in bookReservationForGuest: %@", saveError.localizedDescription);
    return nil;
  }
}

@end
