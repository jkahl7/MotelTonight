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
  //instantiates a new Reservation Object inside of the room object which was passed to this VC
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation"
                                                           inManagedObjectContext:self.selectedRoom.managedObjectContext];
  
  reservation.room      = self.selectedRoom;
  reservation.endDate   = self.departureDate.date;
  reservation.startDate = self.arrivalDate.date;

  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest"
                                               inManagedObjectContext:self.selectedRoom.managedObjectContext];
 
  guest.firstName = self.firstName.text;
  guest.lastName  = self.lastName.text;
  
  reservation.guest = guest;
  
  NSLog(@"%lu",(unsigned long)self.selectedRoom.reservation.count);
  
  NSError *saveError;
  [self.selectedRoom.managedObjectContext save:&saveError];
  
  if (saveError)
  {
    NSLog(@"%@",saveError);
  }
  
  AvailabilityViewController *toVC = [[AvailabilityViewController alloc] init];
  
  toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AvailabilityVC"];
  
  [self.navigationController pushViewController:toVC animated:true];
  
}



- (void)viewDidLoad
{
  [super viewDidLoad];
}


@end
