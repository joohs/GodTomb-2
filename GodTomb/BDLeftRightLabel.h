//
//  DBDetailedLabel.h
//  TestDetailLabel
//
//  Created by Nero on 11/19/15.
//  Copyright © 2015 IntSig Information Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICopyLabel.h"

@interface BDLeftRightLabel : UIView

- (instancetype) initWithFont:(UIFont *) font;

- (instancetype) initWithFont:(UIFont *) font
                    textColor:(UIColor *) textColor;

- (instancetype) initWithFont:(UIFont *) font
            leftTextAlignment:(NSTextAlignment) leftTextAlignment
          rightTextAlignement:(NSTextAlignment) rightTextAlignment;

- (instancetype) initWithFont:(UIFont *) font
                    textColor:(UIColor *) textColor
            leftTextAlignment:(NSTextAlignment) leftTextAlignment
          rightTextAlignement:(NSTextAlignment) rightTextAlignment;

- (instancetype) initWithLeftTextFont:(UIFont *) leftTextFont
                        rightTextFont:(UIFont *) rightTextFont
                        leftTextColor:(UIColor *) leftTextColor
                       rightTextColor:(UIColor *) rightTextColor;

- (instancetype) initWithLeftTextFont:(UIFont *) leftTextFont
                        rightTextFont:(UIFont *) rightTextFont
                        leftTextColor:(UIColor *) leftTextColor
                       rightTextColor:(UIColor *) rightTextColor
                    leftTextAlignment:(NSTextAlignment) leftTextAlignment
                   rightTextAlignment:(NSTextAlignment) rightTextAlignment;

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText
                     rightText:(NSString *) rightText
                      gapWidth:(CGFloat) gapWidth
                      maxWidth:(CGFloat) maxWidth
                  leftMaxWidth:(CGFloat) leftMaxWidth;

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText
                     rightText:(NSString *) rightText
           enableLeftLabelCopy:(BOOL) enableLeftLabelCopy
          enableRightLableCopy:(BOOL) enableRightLableCopy
                      gapWidth:(CGFloat) gapWidth
                      maxWidth:(CGFloat) maxWidth
                  leftMaxWidth:(CGFloat) leftMaxWidth;

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText
                     rightText:(NSString *) rightText
            leftAttributedText:(NSMutableAttributedString *) leftText
           rightAttributedText:(NSMutableAttributedString *) rightText
           enableLeftLabelCopy:(BOOL) enableLeftLabelCopy
          enableRightLableCopy:(BOOL) enableRightLableCopy
                      gapWidth:(CGFloat) gapWidth
                      maxWidth:(CGFloat) maxWidth
                  leftMaxWidth:(CGFloat) leftMaxWidth;

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText;

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText
                      maxWidth:(CGFloat) maxWidth
                    needResize:(BOOL) needResize;



@property (nonatomic, strong) UICopyLabel *leftLabel;
@property (nonatomic, strong) UICopyLabel *rightLabel;

@end
