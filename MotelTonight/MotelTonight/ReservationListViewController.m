//
//  ReservationListViewController.m
//  MotelTonight
//
//  Created by Josh Kahl on 2/11/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "ReservationListViewController.h"
#import "HotelService.h"
#import "ReservationViewController.h"
#import "AvailabilityViewController.h"

@interface ReservationListViewController () <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (IBAction)addReservation:(UIBarButtonItem *)sender;

@end

@implementation ReservationListViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
 
  self.tableView.dataSource              = self;
  self.tableView.delegate                = self;
  self.fetchedResultsController.delegate = self;
  
  NSPredicate *predicate           = [NSPredicate predicateWithFormat:@"room == %@", self.selectedRoom];
  NSFetchRequest *fetchRequest     = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
  NSManagedObjectContext *context  = [[HotelService sharedService] coreDataStack].managedObjectContext;
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate"
                                                                   ascending:true];
  fetchRequest.predicate       = predicate;
  fetchRequest.sortDescriptors = @[sortDescriptor];
  
  self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                      managedObjectContext:context
                                                                        sectionNameKeyPath:nil
                                                                                 cacheName:nil];
  NSError *fetchError;
  
  [self.fetchedResultsController performFetch:&fetchError];
  
  if (fetchError)
  {
    NSLog(@"%@", fetchError.localizedDescription);
  }
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
  [self.tableView beginUpdates];
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
  [self.tableView endUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
  switch (type)
  {
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
    case NSFetchedResultsChangeInsert:
      [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                            withRowAnimation:UITableViewRowAnimationLeft];
      break;
    case NSFetchedResultsChangeMove:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                            withRowAnimation:UITableViewRowAnimationLeft];
      [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                            withRowAnimation:UITableViewRowAnimationLeft];
      break;
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                            withRowAnimation:UITableViewRowAnimationLeft];
      break;
    default:
      NSLog(@"default case reached in controller:didChangeObject");
      break;
  }
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  Reservation *reservation = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@"room: %@", reservation.room.number];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  NSLog(@"#sections in tv: %lu",(unsigned long)[[self.fetchedResultsController sections] count]);

  return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSArray *sections = [self.fetchedResultsController sections];
  id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"
                                                          forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  
  return cell;
}


#pragma Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  AvailabilityViewController *toVC = [[AvailabilityViewController alloc] init];
 
  toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AvailabilityVC"];
  
  NSArray *guestFinder = [self.selectedRoom.reservation allObjects];
  
  NSLog(@"%@", guestFinder);
  
  toVC.selectedRoom = self.selectedRoom;
  
  [self.navigationController pushViewController:toVC animated:true];
}


- (IBAction)addReservation:(UIBarButtonItem *)sender
{
  ReservationViewController *toVC = [[ReservationViewController alloc] init];
  
  toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReservationVC"];
  
  toVC.selectedRoom = self.selectedRoom;
  
  [self.navigationController pushViewController:toVC animated:true];
}

@end
