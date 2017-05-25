//
//  NSObject+BDBDGatherSubView.h
//  pluto
//
//  Created by TTgg on 2016/12/21.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BDBDGatherSubView)
/*
 根据属性名称name，获取当前sender的属性
 */
-(id)bd_returnViewForName:(NSString *)name andSender:(NSObject *)sender;
/*
 判断sender是否存在name属性
 */
-(BOOL)bd_subIsExist:(NSString *)name andSender:(NSObject *)sender;
@end
