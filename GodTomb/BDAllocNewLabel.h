//
//  BDAllocNewLabel.h
//  pluto
//
//  Created by xiangxiong on 16/7/19.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDLabel.h"
#import "UICopyLabel.h"

@interface BDAllocNewLabel : NSObject
+ (UILabel *)allocNewLabel;
+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize;
+ (UILabel *)allocNewLabelTextColor:(UIColor *)textColor;
+ (UILabel *)allocNewNormalLabelFontSize:(NSInteger )fontSize textColor:(UIColor *)textColor;
//可复制，可以选择title在label中的位置
+ (BDLabel *)allocNewLabelFontSize:(NSInteger )fontSize textColor:(UIColor *)textColor;
+ (UICopyLabel *)allocNewCopyLabelFontSize:(NSInteger )fontSize textColor:(UIColor *)textColor;
+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize numberLine:(NSInteger )numberLine;
+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize textAlignment:(NSTextAlignment )textAlignment;
+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize numberLine:(NSInteger )numberLine textColor:(UIColor *)textColor;
+ (UILabel *)allocNewLabelFontSize:(NSInteger )fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment )textAlignment;
@end
