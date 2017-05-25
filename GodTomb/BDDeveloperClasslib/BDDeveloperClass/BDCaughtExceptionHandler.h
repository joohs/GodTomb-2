//
//  BDCaughtExceptionHandler.h
//  BDDeveloperClass
//
//  Created by 吕文钊 on 16/3/31.
//  Copyright © 2016年 吕文钊. All rights reserved.
//
#ifdef __cplusplus
extern "C"
{
#endif
    //    swrve_currency_given(parameter1, parameter2, parameter3);// a c function
    
#ifdef __cplusplus
}
#endif

#import <Foundation/Foundation.h>

@interface BDCaughtExceptionHandler : NSObject
+ (void)bd_setDefaultHandler;
+ (NSUncaughtExceptionHandler *)bd_getHandler;
+ (void)bd_TakeException:(NSException *)exception;
+ (NSString *)bd_returnTXTPath;
+ (BOOL)bd_deletTXT;
@end
