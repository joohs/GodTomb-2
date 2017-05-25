//
//  CDCustomBgImageViewController.h
//  localNotification
//
//  Created by xiangxiong on 2017/4/6.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDCustomBgImageViewControllerDelegate <NSObject>

- (void)settingBgImage:(UIImage *)image;

@end

@interface CDCustomBgImageViewController : UIViewController
@property id<CDCustomBgImageViewControllerDelegate>delegate;
@end
