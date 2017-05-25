//
//  NSDictionary+BDUtility.m
//  pluto
//
//  Created by Lee on 9/23/15.
//  Copyright (c) 2015 bertadata. All rights reserved.
//

#import "NSDictionary+BDUtility.h"

@implementation NSDictionary (BDUtility)
- (id)stringForKey:(NSString *)key
{
    return [self bd_stringForKey:key];
}

- (NSString *)bd_stringForKey:(NSString *)key
{
    if (key == nil||key.length == 0||[key isEqualToString:@"<null>"]||[key isEqualToString:@"(null)"]) {
        return @"";
    }
    else
    {
        return [self valueForKey:key];
    }
}

- (id)arrayForKey:(NSString *)key
{
    if ([[self valueForKey:key] isKindOfClass:[NSNull class]])
        return @[];
    else
        return [self valueForKey:key];
}
- (id)dictionaryForKey:(NSString *)key
{
    if ([[self valueForKey:key] isKindOfClass:[NSNull class]])
        return @{};
    else
        return [self valueForKey:key];
}

- (id)stringForKeyCategory:(NSString *)key
{
    if (![key isKindOfClass:[NSString class]] || [key isEqualToString:@""] || ![self isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    NSString *valueString = [self stringForKey:key];
    return valueString;
}

- (id)arrayForKeyCategory:(NSString *)key
{
    if (![key isKindOfClass:[NSString class]] || [key isEqualToString:@""] || ![self isKindOfClass:[NSDictionary class]]) {
        return @[];
    }
    if ([[self valueForKey:key] isKindOfClass:[NSNull class]])
        return @[];
    else
        return [self valueForKey:key];
}
- (id)dictionaryForKeyCategory:(NSString *)key
{
    if (![key isKindOfClass:[NSString class]] || [key isEqualToString:@""] || ![self isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    if ([[self valueForKey:key] isKindOfClass:[NSNull class]])
        return @{};
    else
        return [self valueForKey:key];
}
@end
