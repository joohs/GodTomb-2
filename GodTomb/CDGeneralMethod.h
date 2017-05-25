//
//  CDGeneralMethod.h
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    leftImageRightTitle = 0,//default
    leftTitleRightImage = 1,
    topImageBottomTitle = 2,
    topTitleBottomImage = 3
}titleAndImagePosition;

@interface CDGeneralMethod : NSObject
+ (NSString *)stringForKey:(NSString *)key withDiction:(NSDictionary *)diction;
+ (NSString *)returnNullStr:(NSString *)str;
+ (NSArray *)arrayForKey:(NSString *)key withDiction:(NSDictionary *)diction;
+ (NSDictionary *)dictionaryForKey:(NSString *)key withDiction:(NSDictionary *)diction;
+ (NSURL *)returnUrlString:(NSString *)urlString;
+ (UIButton *)returnPositionButton:(UIButton *)btn contentPosition:(titleAndImagePosition )contentPosition  gap:(CGFloat )gap;
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;
#pragma mark - make HexString to DecimalString
+ (UIColor *) colorWithHexString: (NSString *)color;
//将颜色转化为16进制 注意转换出来的字符串不带＃号
+ (NSString *)toHexStringByUIColor:(UIColor*)color;
//将颜色转化为16进制，有＃号
+ (NSString *)toHexStringByUIColorExistSymbol:(UIColor *)color;
// 16进制转10进制
+ (NSNumber *) numberHexString:(NSString *)aHexString;
@end
