//
//  CDChangeFontSizeView.m
//  localNotification
//
//  Created by xiangxiong on 2017/4/18.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDChangeFontSizeView.h"

@interface CDChangeFontSizeView ()
{
    UIView *bgView;
    UIView *contentView;
    UILabel *fontSizeLabel;
    NSInteger _fontSize;
}
@end

@implementation CDChangeFontSizeView

- (instancetype)initWithFrame:(CGRect)frame fontSize:(NSInteger)fontSize
{
    self = [super initWithFrame:frame];
    if (self) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        self.frame = frame;
        _fontSize = fontSize;
        bgView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:bgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeOurSelf:)];
        bgView.userInteractionEnabled = YES;
        [bgView addGestureRecognizer:tap];
        CGFloat contentViewHeight = 64;
        CGFloat bottomHeight = 50;
        contentView = [[UIView alloc]initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height-contentViewHeight-bottomHeight, [UIScreen mainScreen].bounds.size.width-40, contentViewHeight)];
        [bgView addSubview:contentView];
        contentView.layer.cornerRadius = 4.f;
        contentView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
        contentView.userInteractionEnabled = YES;
        [contentView addGestureRecognizer:tap2];
        contentView.backgroundColor = [UIColor whiteColor];
        
        UIButton *plusBtn = [[UIButton alloc]initWithFrame:CGRectMake(contentView.frame.size.width-40-10, 10, 40, 44)];
        [plusBtn setBackgroundColor:[UIColor blackColor]];
        [plusBtn setTitle:@"+" forState:UIControlStateNormal];
        [contentView addSubview:plusBtn];
        [plusBtn addTarget:self action:@selector(plusFontSize) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *substBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 44)];
        [contentView addSubview:substBtn];
        [substBtn setTitle:@"-" forState:UIControlStateNormal];
        [substBtn setBackgroundColor:[UIColor blackColor]];
        [substBtn addTarget:self action:@selector(substFontSize) forControlEvents:UIControlEventTouchUpInside];
        
        fontSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
        fontSizeLabel.font = [UIFont systemFontOfSize:18];
        [contentView addSubview:fontSizeLabel];
        fontSizeLabel.text = [NSString stringWithFormat:@"字体大小：%ld",(long)fontSize];
        [fontSizeLabel sizeToFit];
        fontSizeLabel.center = CGPointMake(contentView.frame.size.width/2, contentView.frame.size.height/2);
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

- (void)plusFontSize
{
    if (_fontSize > 20) {
        return ;
    }
    _fontSize ++;
    [self updateFontSize];
}

- (void)substFontSize
{
    if (_fontSize < 10) {
        return ;
    }
    _fontSize --;
    [self updateFontSize];
}

- (void)updateFontSize
{
    fontSizeLabel.text = [NSString stringWithFormat:@"字体大小：%ld",(long)_fontSize];
    [fontSizeLabel sizeToFit];
    fontSizeLabel.center = CGPointMake(contentView.frame.size.width/2, contentView.frame.size.height/2);
    if ([self.delegate respondsToSelector:@selector(changeFontSize:)]) {
        [self.delegate changeFontSize:_fontSize];
    }
}
@end
