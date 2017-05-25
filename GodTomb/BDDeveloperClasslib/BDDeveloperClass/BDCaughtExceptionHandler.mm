//
//  BDCaughtExceptionHandler.m
//  BDDeveloperClass
//
//  Created by 吕文钊 on 16/3/31.
//  Copyright © 2016年 吕文钊. All rights reserved.
//




#import "BDCaughtExceptionHandler.h"

NSString * applicationDocumentsDirectory()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

void UncaughtExceptionHandler(NSException * exception)
{
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason];
    NSString * name = [exception name];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"BDException.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@implementation BDCaughtExceptionHandler

-(NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void)bd_setDefaultHandler
{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}
+ (BOOL)bd_deletTXT
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *FileDir = [self bd_returnTXTPath];
    BOOL bRet = [fileMgr fileExistsAtPath:FileDir];
    
    if (bRet) {
        NSError *err;
        return [fileMgr removeItemAtPath:FileDir error:&err];
    }
    return NO;
    
}
+ (NSUncaughtExceptionHandler *)bd_getHandler
{
    return NSGetUncaughtExceptionHandler();
}

+ (NSString *)bd_returnTXTPath
{
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"BDException.txt"];
    return path;
}
+ (void)bd_TakeException:(NSException *)exception
{
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason];
    NSString * name = [exception name];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"BDException.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%s:%d %@", __FUNCTION__, __LINE__, url);
}
@end
