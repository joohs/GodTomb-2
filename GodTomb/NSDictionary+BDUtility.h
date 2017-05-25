//
//  NSDictionary+BDUtility.h
//  pluto
//
//  Created by Lee on 9/23/15.
//  Copyright (c) 2015 bertadata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BDUtility)
- (id)stringForKey:(NSString *)key;
- (id)arrayForKey:(NSString *)key;
- (id)dictionaryForKey:(NSString *)key;

- (id)stringForKeyCategory:(NSString *)key;
- (id)arrayForKeyCategory:(NSString *)key;
- (id)dictionaryForKeyCategory:(NSString *)key;
@end
