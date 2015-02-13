//
//  HashTable.h
//  MotelTonight
//
//  Created by Josh Kahl on 2/12/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject
//TODO: figure out why this wont work!
//@property (strong, nonatomic) struct bucket;

- (void)setObject:(id)object forKey:(NSString *)key;

- (void)removeObjectWithKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;

- (instancetype)initWithSize:(NSInteger)size;


@end
