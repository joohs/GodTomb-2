//
//  NSObject+BDDes.h
//  DeveloperTools
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <Foundation/Foundation.h>
#define __BASE64( text )        [CommonFunc base64StringFromText:text]
#define __TEXT( base64 )        [CommonFunc textFromBase64String:base64]
@interface NSObject (BDDes)
/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text desEncryptKey:(NSString *)desKey;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64 desDecryptKey:(NSString *)desKey;

/******************************************************************************
 函数名称 : + (NSString *)DESEncrypt:WithKey:
 函数描述 : DES加密
 输入参数 : (NSData *)data 带加密数据
 输出参数 : N/A
 返回参数 : (NSData *)data
 备注信息 :
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;

/******************************************************************************
 函数名称 : + (NSString *)DESDecrypt:WithKey:
 函数描述 : DES加密
 输入参数 : (NSData *)data 带加密数据
 输出参数 : N/A
 返回参数 : (NSData *)data
 备注信息 :
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data;
@end
