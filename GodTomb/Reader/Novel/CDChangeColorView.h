//
//  CDChangeColorView.h
//  localNotification
//
//  Created by xiangxiong on 2017/4/18.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDChangeColorViewDelegate <NSObject>

@optional
- (void)changeNovelColor:(UIColor *)color;

@end

@interface CDChangeColorView : UIView
- (instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color;
@property id<CDChangeColorViewDelegate>delegate;
@end
