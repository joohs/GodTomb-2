//
//  NSArray+BDNSArray.h
//  BDDeveloperClass
//
//  Created by TTgg on 16/3/24.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BDNSArray)
/*
 将数组中元素按照拼音首字母进行正序排序
 返回key对应的value值的首字母(dic)
 */
-(NSDictionary *)bd_sortedArrayUsingFirstLetterByKeypath:(NSString *)keyPath;
-(NSDictionary *)bd_sortedArrayUsingFirstLetter;
/*
 将给出的数组倒序返回
 */
+(NSArray *)bd_invertedOrderArray:(NSArray *)arr;
@end
