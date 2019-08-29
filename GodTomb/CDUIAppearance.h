//
//  CDUIAppearance.h
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#ifndef CDUIAppearance_h
#define CDUIAppearance_h

//umeng
#define umengKey @"58fd9b2145297d05930003e9"
#define jPushAppKey  @"88462c246e4333ac6d36938e"
#define NOTIFICATIONURL @"http://www.baidu.com"
#define ABOUTSELF @"http://www.baidu.com"
#define APP_ITUNES_URL @"https://itunes.apple.com/cn/app/id1233226227"

//3D touch
#define delegateWindow [UIApplication sharedApplication].delegate.window

#define isSupport3DTouch [delegateWindow respondsToSelector:@selector(traitCollection)] && [delegateWindow.traitCollection respondsToSelector:@selector(forceTouchCapability)] && delegateWindow.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable


//color
#define UIColor_RGB(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#define BDColors_Important_WhiteA      [UIColor colorWithHexString:@"ffffff"]//
#define BDColors_Important_BlueA       [UIColor colorWithHexString:@"0fbbe9"]//
#define BDColors_Important_GrayA       [UIColor colorWithHexString:@"43464f"]//
#define BDColors_Important_GrayB       [UIColor colorWithHexString:@"7a808f"]//
#define BDColors_Important_GrayC       [UIColor colorWithHexString:@"a6acbc"]//
#define BDColors_Important_GrayD       [UIColor colorWithHexString:@"f5f5f5"]//背景色
#define BDColors_Important_GrayE       [UIColor colorWithHexString:@"e3e3e3"]//线条,不可点击按钮背景色

//radius
#define BDViewCornerRadius_Important_2    2
#define BDSpacing_Important_4       4.0f
#define BDSpacing_Important_5       5.0f//1
#define BDSpacing_Important_8       8.0f//
#define BDSpacing_Important_10      10.0f//1
#define BDSpacing_Important_15      15.0f//2
#define BDSpacing_Important_16      16.0f//
#define BDSpacing_Important_18      18.0f//3
#define BDSpacing_Important_12      12.0f//4
#define BDSpacing_Important_20      20.0f//
#define BDSpacing_Important_22      22.0f//
#define BDSpacing_Important_25      25.0f//
#define BDSpacing_Important_30      30.0f//
#define BDSpacing_Important_38      38.0f//
#define BDSpacing_Important_40      40.0f//
#define BDSpacing_Important_44      44.0f//
#define BDSpacing_Important_50      50.0f//
#define BDSpacing_Important_64      64.0f//
#define BDSpacing_Important_75      75.0f//
#define BDSpacing_Important_80      80.0f//
#define BDSpacing_Important_88      88.0f//
#define BDSpacing_Important_100     100.0f//
#define BDSpacing_Important_234     230.0f//

//Font
#define BDFont_Important_Font30    [UIFont systemFontOfSize:30]//
#define BDFont_Important_Font20    [UIFont systemFontOfSize:20]//用于标题栏
#define BDFont_Important_Font18    [UIFont systemFontOfSize:18]//用于标题
#define BDFont_Important_Font16    [UIFont systemFontOfSize:16]//用于标题栏
#define BDFont_Important_Font15    [UIFont systemFontOfSize:15]//用于标题栏
#define BDFont_Important_Font14    [UIFont systemFontOfSize:14]//用于标题栏
#define BDFont_Important_Font13    [UIFont systemFontOfSize:13]//用于标题栏
#define BDFont_Important_Font12    [UIFont systemFontOfSize:12]//用于标题栏
#define BDFont_Important_Font11    [UIFont systemFontOfSize:11]//用于标题栏

//string
#define CDHomeTitle @"辰东作品集"
#define CDHomeRightTitle @"书库"
#define CDHomeLeftTitle @"辰东简介"
#define stackRoomUrl @"http://www.baidu.com"

#define CDBookNameWithBSBM @"不死不灭"
#define CDBookNameWithSM @"神墓"
#define CDBookNameWithCSJ @"长生界"
#define CDBookNameWithZT @"遮天"
#define CDBookNameWithWMSJ @"完美世界"
#define CDBookNameWithSS @"圣墟"

//screen
#define CDStatusBarHeight   [UIApplication sharedApplication].statusBarFrame.size.height
#define CDNavigationBarHeight (44 + CDStatusBarHeight)
#define CDScreenWidth           [UIScreen mainScreen].bounds.size.width
#define CDScreenHeight          [UIScreen mainScreen].bounds.size.height
#define CDHasBang ((CDScreenWidth == 375 && CDScreenHeight == 812) || (CDScreenWidth == 414 && CDScreenHeight == 896))
#define CDScreenHeight_All (CDScreenHeight + (CDHasBang ? 34 : 0))
#define CDScreenHeight_Valid    (CDScreenHeight - (CDHasBang ? 34 : 0))

//计算高度
#define CalculateHeight_LabelFontSize @"fontSize"
#define CalculateHeight_LabelContent @"content"
#define CalculateHeight_LabelWidth @"width"
#define CalculateHeight_LabelLeftContent @"leftContent"
#define CalculateHeight_LabelRightContent @"rightContent"
#define CalculateHeight_LabelLeftWidth @"leftWidth"
#define CalculateHeight_LabelRightWidth @"rightWidth"


#endif /* CDUIAppearance_h */
