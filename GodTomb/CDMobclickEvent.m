//
//  CDMobclickEvent.m
//  GodTomb
//
//  Created by xiangxiong on 2017/4/24.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDMobclickEvent.h"

NSString *const CDHomeDetail = @"CDHomeDetail";
NSString *const CDMenu = @"CDMenu";
NSString *const CDProgress = @"CDProgress";
NSString *const CDDayAndNight = @"CDDayAndNight";
NSString *const CDMore = @"CDMore";
NSString *const CDScreenBrightness = @"CDScreenBrightness";
NSString *const CDFontSize = @"CDFontSize";
NSString *const CDCustomColor = @"CDCustomColor";
NSString *const CDCustomBackGround = @"CDCustomBackGround";
NSString *const CDReplaceBackGround = @"CDReplaceBackGround";
NSString *const CDWorksWikipedia = @"CDWorksWikipedia";
NSString *const CDTxtForWarding = @"CDTxtForWarding";
NSString *const CDWorksPhotoAlbum = @"CDWorksPhotoAlbum";
NSString *const CDWorksTieba = @"CDWorksTieba";
NSString *const CDDetailWorksNameTap = @"CDDetailWorksNameTap";
NSString *const CDUseMenuSkipChapter = @"CDUseMenuSkipChapter";
NSString *const CDProgressPreChapter = @"CDProgressPreChapter";
NSString *const CDProgressNextChapter = @"CDProgressNextChapter";
NSString *const CDAuthorWikipedia = @"CDAuthorWikipedia";
NSString *const CDAuthorBaseInfor = @"CDAuthorBaseInfor";
NSString *const CDAuthorWorks = @"CDAuthorWorks";
NSString *const CDThroughAuthorWorksToReader = @"CDThroughAuthorWorksToReader";
NSString *const CDAuthorSinaWeibo = @"CDAuthorSinaWeibo";
NSString *const CDAuthorTencentWeibo = @"CDAuthorTencentWeibo";
NSString *const CDLibrary = @"CDLibrary";

@implementation CDMobclickEvent
/**
 * 详细介绍界面
 */
+ (void)mobClickEventWithHomeDetail:(NSString *)novel
{
    [MobClick event:CDHomeDetail attributes:@{@"name":[CDGeneralMethod returnNullStr:novel]}];
}
/**
 * 目录
 */
+ (void)mobClickEventWithMenu
{
    [MobClick event:CDMenu];
}
/**
 * 进度
 */
+ (void)mobClickEventWithProgress
{
    [MobClick event:CDProgress];
}
/**
 * 日夜间
 */
+ (void)mobClickEventWithDayAndNight
{
    [MobClick event:CDDayAndNight];
}
/**
 * 更多
 */
+ (void)mobClickEventWithMore
{
    [MobClick event:CDMore];
}
/**
 * 屏幕亮度
 */
+ (void)mobClickEventWithScreenBrightness
{
    [MobClick event:CDScreenBrightness];
}
/**
 * 字体大小
 */
+ (void)mobClickEventWithFontSize
{
    [MobClick event:CDFontSize];
}
/**
 * 自定义颜色
 */
+ (void)mobClickEventWithCustomColor
{
    [MobClick event:CDCustomColor];
}
/**
 * 自定义背景
 */
+ (void)mobClickEventWithCustomBackGround
{
    [MobClick event:CDCustomBackGround];
}
/**
 * 点击更换背景
 */
+ (void)mobClickEventWithReplaceBackGround
{
    [MobClick event:CDReplaceBackGround];
}
/**
 * 作品的百度百科
 */
+ (void)mobClickEventWithWorksWikipedia:(NSString *)novel
{
    [MobClick event:CDWorksWikipedia attributes:@{@"name":[CDGeneralMethod returnNullStr:novel]}];
}
/**
 * txt转发
 */
+ (void)mobClickEventWithTxtForWarding:(NSString *)novel
{
    [MobClick event:CDTxtForWarding attributes:@{@"name":[CDGeneralMethod returnNullStr:novel]}];
}
/**
 * 作品的相册
 */
+ (void)mobClickEventWithWorksPhotoAlbum:(NSString *)novel
{
    [MobClick event:CDWorksPhotoAlbum attributes:@{@"name":[CDGeneralMethod returnNullStr:novel]}];
}
/**
 * 作品的贴吧
 */
+ (void)mobClickEventWithWorksWorksTieba:(NSString *)novel
{
    [MobClick event:CDWorksTieba attributes:@{@"name":[CDGeneralMethod returnNullStr:novel]}];
}
/**
 * 详情界面的作品点击
 */
+ (void)mobClickEventWithDetailWorksNameTap:(NSString *)novel
{
    [MobClick event:CDDetailWorksNameTap attributes:@{@"name":[CDGeneralMethod returnNullStr:novel]}];
}
/**
 * 使用目录进行跳转到相应章节
 */
+ (void)mobClickEventWithUseMenuSkipChapter
{
    [MobClick event:CDUseMenuSkipChapter];
}
/**
 * 进度-上一章
 */
+ (void)mobClickEventWithProgressPreChapter
{
    [MobClick event:CDProgressPreChapter];
}
/**
 * 进度-下一章
 */
+ (void)mobClickEventWithProgressNextChapter
{
    [MobClick event:CDProgressNextChapter];
}
/**
 * 作者的百度百科
 */
+ (void)mobClickEventWithAuthorWikipedia
{
    [MobClick event:CDAuthorWikipedia];
}
/**
 * 作者基本信息
 */
+ (void)mobClickEventWithAuthorBaseInfor
{
    [MobClick event:CDAuthorBaseInfor];
}
/**
 * 作者的作品
 */
+ (void)mobClickEventWithAuthorWorks
{
    [MobClick event:CDAuthorWorks];
}
/**
 * 通过作者的作品点击进行阅读
 */
+ (void)mobClickEventWithThroughAuthorWorksToReader
{
    [MobClick event:CDThroughAuthorWorksToReader];
}
/**
 * 作者的新浪微博
 */
+ (void)mobClickEventWithAuthorSinaWeibo
{
    [MobClick event:CDAuthorSinaWeibo];
}
/**
 * 作者的腾讯微博
 */
+ (void)mobClickEventWithAuthorTencentWeibo
{
    [MobClick event:CDAuthorTencentWeibo];
}
/**
 * 书库
 */
+ (void)mobClickEventWithLibrary
{
    [MobClick event:CDLibrary];
}
@end
