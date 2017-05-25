//
//  CDChangeColorView.m
//  localNotification
//
//  Created by xiangxiong on 2017/4/18.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDChangeColorView.h"

@interface CDChangeColorView ()
{
    float red;
    float green;
    float blue;
    UIView *contentView;
    UIView *bgView;
}
@end

@implementation CDChangeColorView

- (instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        self.frame = frame;
        bgView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:bgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeOurSelf)];
        bgView.userInteractionEnabled = YES;
        [bgView addGestureRecognizer:tap];
        CGFloat contentViewHeight = 132;
        CGFloat bottomHeight = 50;
        CGFloat sliderWidth = [UIScreen mainScreen].bounds.size.width-80;
        contentView = [[UIView alloc]initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height-contentViewHeight-bottomHeight, [UIScreen mainScreen].bounds.size.width-40, contentViewHeight)];
        [self addSubview:contentView];
        contentView.layer.cornerRadius = 4.f;
        contentView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
        contentView.userInteractionEnabled = YES;
        [contentView addGestureRecognizer:tap2];
        contentView.backgroundColor = [UIColor whiteColor];
        NSString *colorHexString = [CDGeneralMethod toHexStringByUIColor:color];
        UISlider *slider1 = [[UISlider alloc]initWithFrame:CGRectMake(20, 0, sliderWidth, 44)];
        [contentView addSubview:slider1];
        slider1.minimumTrackTintColor = [UIColor redColor];
        slider1.value = [[CDGeneralMethod numberHexString:[colorHexString substringWithRange:NSMakeRange(0, 2)]] floatValue]/255.0;
        red = slider1.value;
        slider1.tag = 1;
        [slider1 addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
        UISlider *slider2 = [[UISlider alloc]initWithFrame:CGRectMake(20, 44, sliderWidth, 44)];
        [contentView addSubview:slider2];
        slider2.minimumTrackTintColor = [UIColor greenColor];
        slider2.value = [[CDGeneralMethod numberHexString:[colorHexString substringWithRange:NSMakeRange(2, 2)]] floatValue]/255.0;
        green = slider2.value;
        slider2.tag = 2;
        [slider2 addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
        UISlider *slider3 = [[UISlider alloc]initWithFrame:CGRectMake(20, 88, sliderWidth, 44)];
        [contentView addSubview:slider3];
        slider3.minimumTrackTintColor = [UIColor blueColor];
        slider3.value = [[CDGeneralMethod numberHexString:[colorHexString substringWithRange:NSMakeRange(4, 2)]] floatValue]/255.0;
        slider3.tag = 3;
        blue = slider3.value;
        [slider3 addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

- (void)removeOurSelf
{
    [self removeFromSuperview];
}

- (void)touch
{
    
}

- (void)changeColor:(UISlider *)slider
{
    switch (slider.tag) {
        case 1:
        {
            red = slider.value;
        }
            break;
        case 2:
        {
            green = slider.value;
        }
            break;
        case 3:
        {
            blue = slider.value;
        }
            break;
            
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(changeNovelColor:)]) {
        [self.delegate changeNovelColor:[UIColor colorWithRed:red green:green blue:blue alpha:1]];
    }
}

@end
