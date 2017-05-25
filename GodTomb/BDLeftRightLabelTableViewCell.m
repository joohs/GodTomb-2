//
//  BDLeftRightLabelTableViewCell.m
//  pluto
//
//  Created by xiangxiong on 2017/4/18.
//  Copyright © 2017年 bertadata. All rights reserved.
//

#import "BDLeftRightLabelTableViewCell.h"
#import "BDLabel.h"

@interface BDLeftRightLabelTableViewCell ()

@end

@implementation BDLeftRightLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayA];
        [self.contentView addSubview:self.leftLabel];
        
        self.rightLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayB];
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

//单独修改颜色
- (void)changeLeftColor:(UIColor *)color
{
    self.leftLabel.textColor = color;
}

- (void)changeRightColor:(UIColor *)color
{
    self.rightLabel.textColor = color;
}

#pragma mark - 左右形式
//默认
- (CGFloat )updateCellWithLeft:(NSString *)left right:(NSString *)right
{
    CGFloat maxWidth = CDScreenWidth-30;
    self.leftLabel.frame = CGRectMake(15, 15, maxWidth, 10);
    self.leftLabel.text = left;
    [self.leftLabel sizeToFit];
    
    self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 15, maxWidth-CGRectGetWidth(self.leftLabel.frame), 10);
    self.rightLabel.text = right;
    [self.rightLabel sizeToFit];
    
    return MAX(CGRectGetMaxY(self.rightLabel.frame), CGRectGetMaxY(self.leftLabel.frame))+15;
}
//自定义字体大小
- (CGFloat)customLeftFontSize:(NSInteger)leftFontSize rightFontSize:(NSInteger)rightFontSize left:(NSString *)left right:(NSString *)right
{
    self.leftLabel.font = [UIFont systemFontOfSize:leftFontSize];
    self.rightLabel.font = [UIFont systemFontOfSize:rightFontSize];
    return [self updateCellWithLeft:left right:right];
}
//自定义颜色和字体大小
- (CGFloat)customLeftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor leftFontSize:(NSInteger)leftFontSize rightFontSize:(NSInteger)rightFontSize left:(NSString *)left right:(NSString *)right
{
    self.leftLabel.textColor = leftColor;
    self.rightLabel.textColor = rightColor;
    return [self customLeftFontSize:leftFontSize rightFontSize:rightFontSize left:left right:right];
}

#pragma mark - 上下形式
//默认
- (CGFloat )updateCellWithTop:(NSString *)top bottom:(NSString *)bottom
{
    CGFloat maxWidth = CDScreenWidth-30;
    self.leftLabel.frame = CGRectMake(15, 15, maxWidth, 10);
    self.leftLabel.text = top;
    [self.leftLabel sizeToFit];
    
    self.rightLabel.frame = CGRectMake(15, CGRectGetMaxY(self.leftLabel.frame)+10, maxWidth, 10);
    self.rightLabel.text = bottom;
    [self.rightLabel sizeToFit];
    
    return CGRectGetMaxY(self.rightLabel.frame)+15;
}

#pragma mark - 最左最右形式
//默认
- (CGFloat)updateCellWithLeftMost:(NSString *)leftMost rightMost:(NSString *)rightMost accessoryTypeIsNone:(BOOL)accessoryTypeIsNone
{
    CGFloat maxWidth = CDScreenWidth - 30;
    CGFloat leftRightGap = 30;
    self.leftLabel.frame = CGRectMake(15, 15, maxWidth, 10);
    self.leftLabel.text = leftMost;
    [self.leftLabel sizeToFit];
    
    CGFloat maxRightWidth = maxWidth - CGRectGetWidth(self.leftLabel.frame) - leftRightGap - ((accessoryTypeIsNone == YES)?20:0);
    self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame)+leftRightGap, 15, maxRightWidth, 10);
    self.rightLabel.text = rightMost;
    [self.rightLabel sizeToFit];
    if (CGRectGetWidth(self.rightLabel.frame)<=maxRightWidth) {
        CGRect rect = self.rightLabel.frame;
        rect.origin.x += (maxRightWidth-CGRectGetWidth(self.rightLabel.frame));
        self.rightLabel.frame = rect;
    }
    return MAX(CGRectGetMaxY(self.leftLabel.frame), CGRectGetMaxY(self.rightLabel.frame))+15;
}

- (void)addRightTarget:(id)target tag:(NSInteger)tag sel:(SEL)sel
{
    self.rightLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:sel];
    [self.rightLabel addGestureRecognizer:tap];
    self.rightLabel.tag =tag;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
