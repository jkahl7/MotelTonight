//
//  HotelService.h
//  MotelTonight
//
//  Created by Josh Kahl on 2/11/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Hotel.h"
#import "Guest.h"

@interface HotelService : NSObject

@property (strong, nonatomic) CoreDataStack *coreDataStack;

+ (instancetype)sharedService;

- (instancetype)initForTesting;

- (Reservation *)bookReservationForGuest:(Guest *)guest
                                 ForRoom:(Room *)room
                             arrivalDate:(NSDate *)arrival
                           departureDate:(NSDate *)departure;


@end
