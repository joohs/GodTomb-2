//
//  CDCustomBgImageCollectionViewCell.h
//  localNotification
//
//  Created by xiangxiong on 2017/4/7.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCustomBgImageCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;

- (void)updateCellModel:(UIImage *)image;
- (void)addTarget:(id)target sel:(SEL)sel tag:(NSInteger)tag;
- (void)addDeleteTarget:(id)target sel:(SEL)sel tag:(NSInteger)tag;
- (void)addSettingTarget:(id)target sel:(SEL)sel tag:(NSInteger)tag;
- (void)showDeleteItem:(BOOL)show;
@end
