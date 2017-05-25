//
//  CDMobclickEvent.h
//  GodTomb
//
//  Created by xiangxiong on 2017/4/24.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDMobclickEvent : NSObject
/**
 * 详细介绍界面
 */
+ (void)mobClickEventWithHomeDetail:(NSString *)novel;
/**
 * 目录
 */
+ (void)mobClickEventWithMenu;
/**
 * 进度
 */
+ (void)mobClickEventWithProgress;
/**
 * 日夜间
 */
+ (void)mobClickEventWithDayAndNight;
/**
 * 更多
 */
+ (void)mobClickEventWithMore;
/**
 * 屏幕亮度
 */
+ (void)mobClickEventWithScreenBrightness;
/**
 * 字体大小
 */
+ (void)mobClickEventWithFontSize;
/**
 * 自定义颜色
 */
+ (void)mobClickEventWithCustomColor;
/**
 * 自定义背景
 */
+ (void)mobClickEventWithCustomBackGround;
/**
 * 点击更换背景
 */
+ (void)mobClickEventWithReplaceBackGround;
/**
 * 作品的百度百科
 */
+ (void)mobClickEventWithWorksWikipedia:(NSString *)novel;
/**
 * txt转发
 */
+ (void)mobClickEventWithTxtForWarding:(NSString *)novel;
/**
 * 作品的相册
 */
+ (void)mobClickEventWithWorksPhotoAlbum:(NSString *)novel;
/**
 * 作品的贴吧
 */
+ (void)mobClickEventWithWorksWorksTieba:(NSString *)novel;
/**
 * 详情界面的作品点击
 */
+ (void)mobClickEventWithDetailWorksNameTap:(NSString *)novel;
/**
 * 使用目录进行跳转到相应章节
 */
+ (void)mobClickEventWithUseMenuSkipChapter;
/**
 * 进度-上一章
 */
+ (void)mobClickEventWithProgressPreChapter;
/**
 * 进度-下一章
 */
+ (void)mobClickEventWithProgressNextChapter;
/**
 * 作者的百度百科
 */
+ (void)mobClickEventWithAuthorWikipedia;
/**
 * 作者基本信息
 */
+ (void)mobClickEventWithAuthorBaseInfor;
/**
 * 作者的作品
 */
+ (void)mobClickEventWithAuthorWorks;
/**
 * 通过作者的作品点击进行阅读
 */
+ (void)mobClickEventWithThroughAuthorWorksToReader;
/**
 * 作者的新浪微博
 */
+ (void)mobClickEventWithAuthorSinaWeibo;
/**
 * 作者的腾讯微博
 */
+ (void)mobClickEventWithAuthorTencentWeibo;
/**
 * 书库
 */
+ (void)mobClickEventWithLibrary;
@end
