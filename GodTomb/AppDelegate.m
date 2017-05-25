//
//  AppDelegate.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "AppDelegate.h"
#import "CDHomeViewController.h"
#import "CDContactMeViewController.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUIAppearance];
    [self setUmeng];
    [self setJpush:launchOptions];
    [NSThread sleepForTimeInterval:0.5];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//SportLight
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    NSString *idetifier = userActivity.userInfo[@"kCSSearchableItemActivityIdentifier"];
    NSLog(@"%@",idetifier);
    if ([idetifier isEqualToString:CDBookNameWithSS]) {
        [[self getHome] sportLightDidSelectBook:0];
    }
    if ([idetifier isEqualToString:CDBookNameWithWMSJ]) {
        [[self getHome] sportLightDidSelectBook:1];
    }
    if ([idetifier isEqualToString:CDBookNameWithZT]) {
        [[self getHome] sportLightDidSelectBook:2];
    }
    if ([idetifier isEqualToString:CDBookNameWithCSJ]) {
        [[self getHome] sportLightDidSelectBook:3];
    }
    if ([idetifier isEqualToString:CDBookNameWithSM]) {
        [[self getHome] sportLightDidSelectBook:4];
    }
    if ([idetifier isEqualToString:CDBookNameWithBSBM]) {
        [[self getHome] sportLightDidSelectBook:5];
    }
    return YES;
}

//3D Touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"CD.Breif"]) {
        [self showPersonBreif];
    }else if ([shortcutItem.type isEqualToString:@"CD.ContactMe"]){
        [self contactAuthor];
    }
}

- (void)showPersonBreif
{
    [[self getHome] authorBreif:nil];
}

- (CDHomeViewController *)getHome
{
    CDNavigationViewController *nav = (CDNavigationViewController *)self.window.rootViewController;
    [nav popToRootViewControllerAnimated:NO]; //需要将pop移除，不然返回的时候还可能是上一个界面
    [nav dismissViewControllerAnimated:NO completion:^{}];
    CDHomeViewController *home = (CDHomeViewController *)nav.topViewController;
    return home;
}

- (void)contactAuthor
{
    [[self getHome] contactAuthor:nil];
}

- (void)setUIAppearance
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [[UINavigationBar appearance] setBarTintColor:BDColors_Important_WhiteA];
    [[UINavigationBar appearance] setTintColor:BDColors_Important_GrayA];
    [[UINavigationBar appearance]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             BDColors_Important_GrayA,
                             NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:17.f],
                             NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance]
     setBackgroundImage:[UIImage imageWithColor:BDColors_Important_WhiteA]
     forBarPosition:UIBarPositionAny
     barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance]
     setShadowImage:[UIImage
                     imageWithColor:[UIColor colorWithRed:0.90
                                                    green:0.90
                                                     blue:0.90
                                                    alpha:1.00]
                     size:CGSizeMake(CDScreenWidth, 0.5f)]];
    
    [[UIBarButtonItem appearance] setTintColor:BDColors_Important_GrayA];
    [[UIBarButtonItem appearance]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             BDColors_Important_GrayA,
                             NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:15.f],
                             NSFontAttributeName, nil]
     forState:UIControlStateNormal];
    
    [[UITabBar appearance]
     setShadowImage:[UIImage
                     imageWithColor:[UIColor colorWithRed:0.90
                                                    green:0.90
                                                     blue:0.90
                                                    alpha:1.00]
                     size:CGSizeMake(CDScreenWidth, 0.5f)]];
}

//umeng
- (void)setUmeng
{
    UMConfigInstance.appKey = umengKey;
    [MobClick startWithConfigure:UMConfigInstance];
}

//Jpush
- (void)setJpush:(NSDictionary *)launchOptions
{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        
        }
        else {
            NSSet<UIUserNotificationCategory *> *categories;
            entity.categories = categories;
        }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:jPushAppKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
   
    completionHandler(UIBackgroundFetchResultNewData);
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
       
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
        // 判断为本地通知

    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
/**
 *  如果categoryidentifier是appStore的话，那么跳转到appstore升级
 */
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [[self getHome] toUpdateApp:content.categoryIdentifier];
        
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}

#endif
@end
