//
//  AvailabilityViewController.m
//  MotelTonight
//
//  Created by Josh Kahl on 2/10/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"

@interface AvailabilityViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *arrivalDate;

@property (weak, nonatomic) IBOutlet UIDatePicker *departureDate;

@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSegment;

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation AvailabilityViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
}


- (IBAction)findReservations:(UIButton *)sender
{
  // describes search criteria used to retrieve data from a persistent store
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  //gets the selected segments name as an NSString
  NSString *selectedHotel = [self.hotelSegment titleForSegmentAtIndex:self.hotelSegment.selectedSegmentIndex];
  NSLog(@"%@",selectedHotel);
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.hotel.name MATCHES %@", selectedHotel];
  
  fetchRequest.predicate = predicate;
  
  
  //makes a fetch against the reservation entity / criteria used to retrieve data from a persistent store.
  NSFetchRequest *fetchReservation = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
  //used to define logical conditions used to constrain a search either for a fetch or for in-memory filtering
  NSPredicate *reservationPredicate = [NSPredicate predicateWithFormat:@"room.hotel.name MATCHES %@ && startDate >= %@ || endDate <= %@", selectedHotel, self.arrivalDate.date, self.departureDate.date];
  
  fetchReservation.predicate = reservationPredicate;
  
  NSError *fetchError;
  
  NSArray *results = [self.context executeFetchRequest:fetchReservation error:&fetchError];
  
  
  NSMutableArray *rooms = [[NSMutableArray alloc] init];
  
  for (Reservation *reservation in results)
  {
    [rooms addObject:reservation.room];
  }
  
  
  
  NSFetchRequest *fetchSpecific = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  //searches within the selectedHotel for rooms that are not in our rooms array (above)
  NSPredicate *roomsPredicate = [NSPredicate predicateWithFormat:@"hotel.name MATCHES %@ AND NOT (self IN %@)", selectedHotel, rooms];
  
  fetchSpecific.predicate = roomsPredicate;
  
  NSError *specificError;
  
  NSArray *specificResults = [self.context executeFetchRequest:fetchSpecific error:&specificError];
  
  if (specificError)
  {
    NSLog(@"%@",specificError.localizedDescription);
  }
  
  NSLog(@"results : %lu", (unsigned long)specificResults.count);
  
}



@end
