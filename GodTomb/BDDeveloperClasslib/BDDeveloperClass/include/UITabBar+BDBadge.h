//
//  UITabBar+BDBadge.h
//  BDDeveloperClass
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (BDBadge)
- (void)showBadgeOnItemIndex:(NSInteger)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index; //隐藏小红点
@end
