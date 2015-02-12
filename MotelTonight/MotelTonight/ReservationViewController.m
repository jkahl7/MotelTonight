//
//  ReservationViewController.m
//  MotelTonight
//
//  Created by Josh Kahl on 2/10/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "ReservationViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "HotelService.h"
#import "AvailabilityViewController.h"


@interface ReservationViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *arrivalDate;

@property (weak, nonatomic) IBOutlet UIDatePicker *departureDate;

@property (weak, nonatomic) IBOutlet UITextField *firstName;

@property (weak, nonatomic) IBOutlet UITextField *lastName;

@end

@implementation ReservationViewController


- (IBAction)bookDates:(UIButton *)sender
{
  //TODO: somehow I need to add a reservation here - or confirm that it is being done
  NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;
  
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest"
                                               inManagedObjectContext:context];
  guest.firstName = self.firstName.text;
  guest.lastName  = self.lastName.text;
  
  
  [[HotelService sharedService] bookReservationForGuest:guest
                                                ForRoom:self.selectedRoom
                                            arrivalDate:self.arrivalDate.date
                                          departureDate:self.departureDate.date];
  
  
  [self.navigationController dismissViewControllerAnimated:false completion:nil];
  NSLog(@"first hit");
  [self dismissViewControllerAnimated:false completion:nil];
  NSLog(@"second hit");
  [[self presentingViewController] dismissViewControllerAnimated:false completion:nil];
  
}


- (void)viewDidLoad
{
  [super viewDidLoad];
}


@end
