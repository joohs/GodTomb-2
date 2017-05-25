//
//  CDChangeBrightnessView.m
//  localNotification
//
//  Created by xiangxiong on 2017/4/18.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDChangeBrightnessView.h"

@interface CDChangeBrightnessView ()
{
    UIView *contentView;
    UIView *bgView;
}
@end

@implementation CDChangeBrightnessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        self.frame = frame;
        bgView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:bgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeOurSelf:)];
        bgView.userInteractionEnabled = YES;
        [bgView addGestureRecognizer:tap];
        CGFloat contentViewHeight = 64;
        CGFloat bottomHeight = 50;
        CGFloat sliderWidth = [UIScreen mainScreen].bounds.size.width-80;
        contentView = [[UIView alloc]initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height-contentViewHeight-bottomHeight, [UIScreen mainScreen].bounds.size.width-40, contentViewHeight)];
        [bgView addSubview:contentView];
        contentView.layer.cornerRadius = 4.f;
        contentView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
        contentView.userInteractionEnabled = YES;
        [contentView addGestureRecognizer:tap2];
        contentView.backgroundColor = [UIColor whiteColor];
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(20, 10, sliderWidth, 44)];
        [contentView addSubview:slider];
        slider.value = [UIScreen mainScreen].brightness;
        [slider addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

- (void)removeOurSelf:(UITapGestureRecognizer *)tap
{
    NSLog(@"%@:%@",tap.view,tap.view.subviews);
    [self removeFromSuperview];
}

- (void)touch
{
    
}

- (void)change:(UISlider *)slider
{
    [[UIScreen mainScreen] setBrightness:slider.value];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
