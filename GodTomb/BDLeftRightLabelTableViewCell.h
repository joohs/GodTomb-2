//
//  BDLeftRightLabelTableViewCell.h
//  pluto
//
//  Created by xiangxiong on 2017/4/18.
//  Copyright © 2017年 bertadata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDLeftRightLabelTableViewCell : UITableViewCell
@property (nonatomic, strong) BDLabel *leftLabel;
@property (nonatomic, strong) BDLabel *rightLabel;


//单独修改颜色
- (void)changeLeftColor:(UIColor *)color;
- (void)changeRightColor:(UIColor *)color;
#pragma mark - 左右形式
//默认
- (CGFloat )updateCellWithLeft:(NSString *)left right:(NSString *)right;
//自定义字体大小
- (CGFloat)customLeftFontSize:(NSInteger)leftFontSize rightFontSize:(NSInteger)rightFontSize left:(NSString *)left right:(NSString *)right;
//自定义颜色和字体大小
- (CGFloat)customLeftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor leftFontSize:(NSInteger)leftFontSize rightFontSize:(NSInteger)rightFontSize left:(NSString *)left right:(NSString *)right;
#pragma mark - 上下形式
//默认
- (CGFloat )updateCellWithTop:(NSString *)top bottom:(NSString *)bottom;

- (void)addRightTarget:(id)target tag:(NSInteger)tag sel:(SEL)sel;
#pragma mark - 最左最右形式
//默认
- (CGFloat)updateCellWithLeftMost:(NSString *)leftMost rightMost:(NSString *)rightMost accessoryTypeIsNone:(BOOL)accessoryTypeIsNone;
@end
