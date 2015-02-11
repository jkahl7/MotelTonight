//
//  NetworkController.m
//  MotelTonight
//
//  Created by Josh Kahl on 2/9/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "NetworkController.h"

@implementation NetworkController

@synthesize property;

+(instancetype)sharedManager
{
  // *sharedNetController is initilized only once
  static NetworkController *sharedNetController = nil;
  static dispatch_once_t onceTokehn; // ensures that the sharedNetController is only created once
  dispatch_once(&onceTokehn, ^{
    sharedNetController = [[self alloc] init];
  });
  return sharedNetController;
}

-(instancetype)init
{
  if (self = [super init])
  {
    property = @"default property value";
    userTwitterAccount = [[ACAccount alloc] init];
    imageQueue = [[NSOperationQueue alloc] init];
  }
  return self;
}
/*
-(void)fetchLocalMotels: (void (^)(NSArray *motels, NSString *errorString))completionHandler
{
  ACAccountStore *accountStore = [[ACAccountStore alloc] init];
  ACAccountType *accountType = [[ACAccountType alloc] init];
 // accountType = [accountStore accountWithIdentifier:ACAccountTypeIdentifierTwitter];
}

*/


@end
