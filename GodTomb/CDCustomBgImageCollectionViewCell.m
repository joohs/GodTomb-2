//
//  CDCustomBgImageCollectionViewCell.m
//  localNotification
//
//  Created by xiangxiong on 2017/4/7.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDCustomBgImageCollectionViewCell.h"

@interface CDCustomBgImageCollectionViewCell ()

@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *settingButton;
@end

@implementation CDCustomBgImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 80, 120)];
        [self.contentView addSubview:self.imageView];
        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 0, 40, 40)];
        self.deleteButton.backgroundColor = [UIColor blackColor];
        [self.deleteButton setImage:[UIImage imageNamed:@"discoverInterestingDelete"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteButton];
        
        self.settingButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+5, CGRectGetWidth(self.imageView.frame), 24)];
        [self.settingButton setBackgroundColor:[UIColor blueColor]];
        [self.settingButton setTitle:@"设为背景" forState:UIControlStateNormal];
        [self.contentView addSubview:self.settingButton];
    }
    return self;
}

- (void)showDeleteItem:(BOOL)show
{
    self.deleteButton.hidden = !show;
}

- (void)updateCellModel:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)addTarget:(id)target sel:(SEL)sel tag:(NSInteger)tag
{
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:target action:sel];
    self.imageView.userInteractionEnabled = YES;
    gesture.minimumPressDuration = 1.f;
    self.imageView.tag = tag;
    [self.imageView addGestureRecognizer:gesture];
}

- (void)addDeleteTarget:(id)target sel:(SEL)sel tag:(NSInteger)tag
{
    [self.deleteButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    self.deleteButton.tag = tag;
}

- (void)addSettingTarget:(id)target sel:(SEL)sel tag:(NSInteger)tag
{
    [self.settingButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    self.settingButton.tag = tag;
}
@end
