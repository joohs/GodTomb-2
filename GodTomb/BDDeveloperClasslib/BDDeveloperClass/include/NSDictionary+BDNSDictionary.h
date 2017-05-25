//
//  NSDictionary+BDNSDictionary.h
//  BDDeveloperClass
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BDNSDictionary)
/*
 提供相应的key值   返回字典中对应的value 
 当dic=nil时，返回@“(null)”，先判断dic是否为nil。
 当key不存在时，返回空的 @“”，@[],@{}
 */
-(id)bd_stringForKey:(NSString *)key;
-(id)bd_arrayForKey:(NSString *)key;
-(id)bd_dictionaryForKey:(NSString *)key;
@end
