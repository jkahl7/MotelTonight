//
//  HotelServiceTests.m
//  MotelTonight
//
//  Created by Josh Kahl on 2/11/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "HotelService.h"
#import "Hotel.h"
#import "Room.h"
#import "Guest.h"


@interface HotelServiceTests : XCTestCase

@property (strong, nonatomic) HotelService *hotelService;
@property (strong, nonatomic) Hotel *hotel;
@property (strong, nonatomic) Room *room;
@property (strong, nonatomic) Guest *guest;

@end

@implementation HotelServiceTests

- (void)setUp
{
  [super setUp];
  
  self.hotelService = [[HotelService alloc] initForTesting];
  
  NSManagedObjectContext *context = self.hotelService.coreDataStack.managedObjectContext;
  
  self.hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel"
                                             inManagedObjectContext:context];
  self.hotel.name     = @"Marvin Gardens";
  self.hotel.location = @"Yellow Property";
  self.hotel.rating   = @3;
  
  self.room = [NSEntityDescription insertNewObjectForEntityForName:@"Room"
                                            inManagedObjectContext:context];
  self.room.number = @420;
  self.room.rate   = @3;
  self.room.beds   = @2;
  self.room.hotel  = self.hotel;
  
  self.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest"
                                             inManagedObjectContext:context];
  self.guest.firstName = @"Thimble";
  self.guest.lastName  = @"BootDog";
}


- (void)tearDown
{
  self.guest        = nil;
  self.room         = nil;
  self.hotel        = nil;
  self.hotelService = nil;
  
  [super tearDown];
}

- (void)testBookReservation
{
  NSDate *arrivalDate = [NSDate date];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
  dateComponents.day = 2;
  
  NSDate *departureDate = [calendar dateByAddingComponents:dateComponents toDate:arrivalDate options:0];
  
  Reservation *reservation = [self.hotelService bookReservationForGuest:self.guest
                                                                ForRoom:self.room
                                                            arrivalDate:arrivalDate
                                                          departureDate:departureDate];
  //assert that the result of the above method is ! nil
  XCTAssertNotNil(reservation, @"reservation should not be nil for valid dates");
}


- (void)testExample
{
  XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample
{
  [self measureBlock:^
  {
  }];
}

@end
