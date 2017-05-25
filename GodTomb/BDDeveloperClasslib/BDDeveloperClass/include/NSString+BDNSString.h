//
//  NSString+BDNSString.h
//  DeveloperTools
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (BDNSString)
/*
 unicode编码
 */
+(NSString *)bd_replaceUnicode:(NSString *)unicodeStr;
/*
 高度,宽度
 */
+(float)bd_heightForStringInLabel:(NSString *)value font:(UIFont *)font andWidth:(float)width withLineNumber:(NSInteger )number;
+(float)bd_widthForStringInLabel:(NSString *)value font:(UIFont *)font andHeigh:(float)heigh withLineNumber:(NSInteger )number;
+(float)bd_heightForStringInTextView:(NSString *)value font:(UIFont *)font andWidth:(float)width;
+(float)bd_widthForStringInTextView:(NSString *)value font:(UIFont *)font andHeigh:(float)heigh;
/*
 Attributes高度,宽度
 */
+(CGSize)bd_getAttributesSize:(NSString *)str withAttributes:(NSDictionary *)dic andWidth:(CGFloat)width withLines:(NSInteger )number;
+(CGSize)bd_getAttributesSize:(NSString *)str withAttributes:(NSDictionary *)dic andHeight:(CGFloat)height withLines:(NSInteger )number;
+(CGSize)bd_getAttributesSize:(NSString *)str withAttributes:(NSDictionary *)dic andWidth:(CGFloat)width andHeight:(CGFloat)height withLines:(NSInteger )number;

/*
 返回空字符
 */
+(NSString *)bd_returnNullStr:(NSString *)str;
/*
 传入汉子，返回拼音，大部分够用
 */
+(NSString *)bd_returnChineseStr:(NSString *)str;


/*
 md5加密
 */
+(NSString *)bd_md5Str:(NSString *)inPutText;
/*
 json字符串，
 传入dic，arr,string
 */
+(NSString *)bd_dictionaryToString:(id)object;

/*
 判断是否是身份证号
 */
+(BOOL)bd_isPersonNumber:(NSString *)number;
/*
 简易判断手机号
 */
+(BOOL)bd_checkMobilePhone:(NSString *)mobileNum ;
/*
 简易判断邮箱号
 */
+(BOOL)bd_checkEmail:(NSString *)email;

@end
