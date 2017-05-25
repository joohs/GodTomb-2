//
//  CDChangeFontSizeView.h
//  localNotification
//
//  Created by xiangxiong on 2017/4/18.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDChangeFontSizeViewDelegate <NSObject>

- (void)changeFontSize:(NSInteger)fontSize;

@end

@interface CDChangeFontSizeView : UIView
@property id<CDChangeFontSizeViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame fontSize:(NSInteger)fontSize;

@end
