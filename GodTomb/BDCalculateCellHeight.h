//
//  BDCalculateCellHeight.h
//  localNotification
//
//  Created by xiangxiong on 17/1/18.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BDCalculateCellHeight : NSObject

+ (CGFloat)calculateCellHeight:(NSArray *)modelArray andDefaultHeight:(CGFloat)defaultHeight;

+ (CGFloat)leftRightCalculateCellHeight:(NSArray *)modelArray andDefaultHeight:(CGFloat)defaultHeight;
/**
 *  计算固定的宽度
 */
+ (CGFloat)fixWidth:(NSString *)string fontSize:(CGFloat )fontSize;
/**
 *  计算高度
 */
+ (CGFloat)fixHeight:(NSString *)string fontSize:(CGFloat )fontSize width:(CGFloat)width;
@end
