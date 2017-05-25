//
//  BDCalculateCellHeight.m
//  localNotification
//
//  Created by xiangxiong on 17/1/18.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "BDCalculateCellHeight.h"
#import "BDAllocNewLabel.h"

@implementation BDCalculateCellHeight

+ (CGFloat)calculateCellHeight:(NSArray *)modelArray andDefaultHeight:(CGFloat)defaultHeight
{
    CGFloat calculateHeight = 0;
    for (NSDictionary *dic in modelArray) {
#ifdef DEBUG
//        if ([[dic valueForKey:LabelWidth] integerValue] == 0) {
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken,^{
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"使用的是默认宽度" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
//                [alert show];
//            });
//        }
#endif
        NSInteger fontSize = [[CDGeneralMethod stringForKey:CalculateHeight_LabelFontSize withDiction:dic] integerValue];
        if (fontSize == 0) {
            fontSize = 14;
        }
        CGFloat width = [[CDGeneralMethod stringForKey:CalculateHeight_LabelWidth withDiction:dic] floatValue];
        if (width == 0) {
            width = CDScreenWidth - 15 - 15;
        }
        UILabel *label = [BDAllocNewLabel allocNewLabelFontSize:fontSize];
        label.frame = CGRectMake(0, 0, width, 0);
        label.text = [self returnNotNullString:dic];
        [label sizeToFit];
        calculateHeight += CGRectGetHeight(label.frame);
    }
    return defaultHeight + calculateHeight;
}
/**
 *  NSArray *leftRightArray = @[@{CalculateHeight_LabelLeftContent:@"xx",
 *                                CalculateHeight_LabelLeftWidth:[NSNumber numberWithFloat:100],
 *                                CalculateHeight_LabelRightContent:@"yy",
 *                                CalculateHeight_LabelRightWidth:[NSNumber numberWithFloat:100]
 *                               }];
 */

+ (CGFloat)leftRightCalculateCellHeight:(NSArray *)modelArray andDefaultHeight:(CGFloat)defaultHeight
{
    CGFloat calculateHeight = 0;
    for (NSDictionary *dic in modelArray) {
#ifdef DEBUG
//        if ([[dic valueForKey:LeftLabelWidth] integerValue] == 0 && [[dic valueForKey:RightLabelWidth] integerValue] == 0) {
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken,^{
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"使用的是默认宽度" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
//                [alert show];
//            });
//        }
        for (NSString *string in [dic allKeys]) {
            if ([string isEqualToString:CalculateHeight_LabelWidth] || [string isEqualToString:CalculateHeight_LabelContent]) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken,^{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"使用的key不对" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                    [alert show];
                });
            }
        }
#endif
        
        NSInteger fontSize = [[CDGeneralMethod stringForKey:CalculateHeight_LabelFontSize withDiction:dic] integerValue];
        if (fontSize == 0) {
            fontSize = 14;
        }
        CGFloat leftWidth = [[CDGeneralMethod stringForKey:CalculateHeight_LabelLeftWidth withDiction:dic] floatValue];
        if (leftWidth == 0) {
            leftWidth = CDScreenWidth/2 - 15 - 15;
        }
        UILabel *leftLabel = [BDAllocNewLabel allocNewLabelFontSize:fontSize];
        leftLabel.frame = CGRectMake(0, 0, leftWidth, 0);
        leftLabel.text = [self leftReturnNotNullString:dic];
        [leftLabel sizeToFit];
        
        CGFloat rightWidth = [[CDGeneralMethod stringForKey:CalculateHeight_LabelRightWidth withDiction:dic] floatValue];
        if (rightWidth == 0) {
            rightWidth = CDScreenWidth/2 - 15 - 15;
        }
        UILabel *rightLabel = [BDAllocNewLabel allocNewLabelFontSize:fontSize];
        rightLabel.frame = CGRectMake(0, 0, rightWidth, 0);
        rightLabel.text = [self rightReturnNotNullString:dic];
        [rightLabel sizeToFit];
        calculateHeight += MAX(CGRectGetHeight(leftLabel.frame), CGRectGetHeight(rightLabel.frame));
    }
    return defaultHeight + calculateHeight;
}

+ (NSString *)returnNotNullString:(NSDictionary *)dic
{
    NSString *string = [CDGeneralMethod stringForKey:CalculateHeight_LabelContent withDiction:dic];
    if (![string isKindOfClass:[NSString class]] || [string isEqualToString:@""]) {
        return @".";//防止计算高度的时候为0
    }
    return string;
}

+ (NSString *)leftReturnNotNullString:(NSDictionary *)dic
{
    NSString *string = [CDGeneralMethod stringForKey:CalculateHeight_LabelLeftContent withDiction:dic];
    if (![string isKindOfClass:[NSString class]] || [string isEqualToString:@""]) {
        return @".";
    }
    return string;
}

+ (NSString *)rightReturnNotNullString:(NSDictionary *)dic
{
    NSString *string = [CDGeneralMethod stringForKey:CalculateHeight_LabelRightContent withDiction:dic];
    if (![string isKindOfClass:[NSString class]] || [string isEqualToString:@""]) {
        return @".";
    }
    return string;
}

+ (CGFloat)fixWidth:(NSString *)string fontSize:(CGFloat )fontSize
{
    UILabel *object = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MAXFLOAT, 10)];
    object.numberOfLines = 0;
    object.font = [UIFont systemFontOfSize:fontSize];
    object.text = string;
    [object sizeToFit];
    return CGRectGetWidth(object.frame);
}

+ (CGFloat)fixHeight:(NSString *)string fontSize:(CGFloat )fontSize width:(CGFloat)width
{
    UILabel *object = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    object.numberOfLines = 0;
    object.font = [UIFont systemFontOfSize:fontSize];
    object.text = string;
    CGSize deSize = [object sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    return deSize.height;
}
@end
