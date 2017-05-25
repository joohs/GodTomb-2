//
//  BDAllocNewLabel.m
//  pluto
//
//  Created by xiangxiong on 16/7/19.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import "BDAllocNewLabel.h"

@implementation BDAllocNewLabel
+ (UILabel *)allocNewLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = BDColors_Important_GrayA;
    return label;
}

+ (UILabel *)allocNewLabelTextColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = textColor;
    return label;
}

+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = BDColors_Important_GrayA;
    return label;
}

+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize textAlignment:(NSTextAlignment )textAlignment
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = textAlignment;
    label.textColor = BDColors_Important_GrayA;
    return label;
}

+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize numberLine:(NSInteger )numberLine
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = numberLine;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = BDColors_Important_GrayA;
    return label;
}

+ (BDLabel *)allocNewLabelFontSize:(NSInteger )fontSize textColor:(UIColor *)textColor
{
    BDLabel *label = [[BDLabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    return label;
}

+ (UILabel *)allocNewNormalLabelFontSize:(NSInteger )fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    return label;
}

+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment )textAlignment
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.textAlignment = textAlignment;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    return label;
}

+ (UICopyLabel *)allocNewCopyLabelFontSize:(NSInteger )fontSize textColor:(UIColor *)textColor
{
    UICopyLabel *label = [[UICopyLabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    return label;
}

+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize numberLine:(NSInteger )numberLine textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = numberLine;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    return label;
}
@end
