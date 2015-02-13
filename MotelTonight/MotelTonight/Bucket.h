//
//  Bucket.h
//  MotelTonight
//
//  Created by Josh Kahl on 2/12/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bucket : NSObject


@property (strong, nonatomic) Bucket *next;

@property (strong, nonatomic) id data;

@property (strong, nonatomic) NSString *key;


@end
