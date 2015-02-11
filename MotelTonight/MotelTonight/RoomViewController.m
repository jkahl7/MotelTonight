//
//  RoomViewController.m
//  MotelTonight
//
//  Created by Josh Kahl on 2/9/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "RoomViewController.h"
#import "Room.h"
//#import "AppDelegate.h"
#import "ReservationViewController.h"


@interface RoomViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RoomViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate   = self;
  
  [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.rooms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
  Room *room = self.rooms[indexPath.row];
    
  cell.textLabel.text = [NSString stringWithFormat:@"%@", room.number];
  
  return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ReservationViewController *toVC = [[ReservationViewController alloc] init];
  
  toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReservationVC"];
  
  toVC.selectedRoom = self.rooms[indexPath.row];
  
  [self.navigationController pushViewController:toVC animated:true]; 
}


@end
