//
//  DBDetailedLabel.m
//  TestDetailLabel
//
//  Created by Nero on 11/19/15.
//  Copyright © 2015 IntSig Information Co., Ltd. All rights reserved.
//

#import "BDLeftRightLabel.h"

@interface BDLeftRightLabel()
@end

@implementation BDLeftRightLabel

- (instancetype) initWithFont:(UIFont *) font
{
    return [self initWithFont:font leftTextAlignment:NSTextAlignmentLeft rightTextAlignement:NSTextAlignmentLeft];
}

- (instancetype) initWithFont:(UIFont *) font
                    textColor:(UIColor *) textColor
{
    return [self initWithFont:font textColor:textColor leftTextAlignment:NSTextAlignmentLeft rightTextAlignement:NSTextAlignmentLeft];
}

- (instancetype) initWithFont:(UIFont *) font
            leftTextAlignment:(NSTextAlignment) leftTextAlignment
          rightTextAlignement:(NSTextAlignment) rightTextAlignment
{
    return [self initWithFont:font textColor:BDColors_Important_GrayA leftTextAlignment:leftTextAlignment rightTextAlignement:rightTextAlignment];
}

- (instancetype) initWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
            leftTextAlignment:(NSTextAlignment)leftTextAlignment
          rightTextAlignement:(NSTextAlignment)rightTextAlignment
{
    return [self initWithLeftTextFont:font rightTextFont:font leftTextColor:textColor rightTextColor:textColor leftTextAlignment:leftTextAlignment rightTextAlignment:rightTextAlignment];
}

- (instancetype) initWithLeftTextFont:(UIFont *) leftTextFont
                        rightTextFont:(UIFont *) rightTextFont
                        leftTextColor:(UIColor *) leftTextColor
                       rightTextColor:(UIColor *) rightTextColor
{
    return [self initWithLeftTextFont:leftTextFont rightTextFont:rightTextFont leftTextColor:leftTextColor rightTextColor:rightTextColor leftTextAlignment:NSTextAlignmentLeft rightTextAlignment:NSTextAlignmentLeft];
}

- (instancetype) initWithLeftTextFont:(UIFont *) leftTextFont
                        rightTextFont:(UIFont *) rightTextFont
                        leftTextColor:(UIColor *) leftTextColor
                       rightTextColor:(UIColor *) rightTextColor
                    leftTextAlignment:(NSTextAlignment) leftTextAlignment
                   rightTextAlignment:(NSTextAlignment) rightTextAlignment;
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        _leftLabel = [[UICopyLabel alloc] initWithFrame:CGRectZero];
        _leftLabel.enableCopy = YES;
        _leftLabel.font = leftTextFont;
        _leftLabel.textColor = leftTextColor;
        _leftLabel.numberOfLines = 0;
        _leftLabel.textAlignment = leftTextAlignment;
        
        _rightLabel = [[UICopyLabel alloc] initWithFrame:CGRectZero];
        _leftLabel.enableCopy = YES;
        _rightLabel.font = rightTextFont;
        _rightLabel.textColor = rightTextColor;
        _rightLabel.numberOfLines = 0;
        _rightLabel.textAlignment = rightTextAlignment;
        //_rightLabel.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        
        //self.backgroundColor = [UIColor grayColor];
        
    }
    return self;

}

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText
                     rightText:(NSString *) rightText
                      gapWidth:(CGFloat) gapWidth
                      maxWidth:(CGFloat) maxWidth
                  leftMaxWidth:(CGFloat) leftMaxWidth
{
    return [self updateWithLeftPoint:topLeft leftText:leftText rightText:rightText enableLeftLabelCopy:NO enableRightLableCopy:NO gapWidth:gapWidth maxWidth:maxWidth leftMaxWidth:leftMaxWidth];
}

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                    leftText:(NSString *) leftText
                   rightText:(NSString *) rightText
           enableLeftLabelCopy:(BOOL) enableLeftLabelCopy
          enableRightLableCopy:(BOOL) enableRightLableCopy
                    gapWidth:(CGFloat) gapWidth
                    maxWidth:(CGFloat) maxWidth
                leftMaxWidth:(CGFloat) leftMaxWidth
{
    self.leftLabel.enableCopy = enableLeftLabelCopy;
    self.rightLabel.enableCopy = enableRightLableCopy;
    if (![rightText isKindOfClass:[NSString class]]) {
        rightText = @"";
    }
    if (![leftText isKindOfClass:[NSString class]]) {
        leftText = @"";
    }
    CGRect leftLabelFrame;
    if (leftMaxWidth < 0)
    {
        leftLabelFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10);
    }
    else
    {
        leftLabelFrame = CGRectMake(0, 0, leftMaxWidth, 10);
    }
   
    _leftLabel.frame = leftLabelFrame;
    
    _leftLabel.text = leftText;
    CGSize leftSize;
    if (leftMaxWidth < 0)
    {
        [_leftLabel sizeToFit];
        leftSize = _leftLabel.frame.size;
        leftMaxWidth = leftSize.width;
    }
    else
    {
        leftSize = [_leftLabel sizeThatFits:CGSizeMake(leftLabelFrame.size.width, CGFLOAT_MAX)];
    }
    leftLabelFrame.size.height = leftSize.height;
    leftLabelFrame.size.width = leftSize.width;
    _leftLabel.frame = leftLabelFrame;
    CGFloat height;
    if (rightText.length > 0)
    {
        CGFloat rightWidth = maxWidth - gapWidth - leftMaxWidth;
        CGRect rightLabelFrame = CGRectMake(leftMaxWidth + gapWidth, 0, rightWidth, 10);
        _rightLabel.frame = rightLabelFrame;
        _rightLabel.text = rightText;
        CGSize rightSize = [_rightLabel sizeThatFits:CGSizeMake(rightLabelFrame.size.width, CGFLOAT_MAX)];
        if (rightSize.width < rightWidth)
        {
            rightWidth = rightSize.width;
        }
        rightLabelFrame.size.height = rightSize.height;
        rightLabelFrame.size.width = rightWidth;
        
        if (_rightLabel.textAlignment == NSTextAlignmentRight)
        {
            rightLabelFrame.origin.x = maxWidth - rightWidth;
        }
        _rightLabel.frame = rightLabelFrame;
        height =  MAX(leftSize.height, rightSize.height);
    }
    else
    {
        leftLabelFrame.size.width = leftMaxWidth;
        _leftLabel.frame = leftLabelFrame;
        height = leftSize.height;
    }
    
    self.frame = CGRectMake(topLeft.x, topLeft.y, maxWidth, height);
//    self.backgroundColor = [UIColor greenColor];
//    self.leftLabel.backgroundColor = [UIColor redColor];
//    self.rightLabel.backgroundColor = [UIColor blueColor];
    return self.frame;
}

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText
                     rightText:(NSString *) rightText
            leftAttributedText:(NSMutableAttributedString *) leftAttributedText
           rightAttributedText:(NSMutableAttributedString *) rightAttributedText
           enableLeftLabelCopy:(BOOL) enableLeftLabelCopy
          enableRightLableCopy:(BOOL) enableRightLableCopy
                      gapWidth:(CGFloat) gapWidth
                      maxWidth:(CGFloat) maxWidth
                  leftMaxWidth:(CGFloat) leftMaxWidth
{
    self.leftLabel.enableCopy = enableLeftLabelCopy;
    self.rightLabel.enableCopy = enableRightLableCopy;
    
    CGRect leftLabelFrame;
    if (leftMaxWidth < 0)
    {
        leftLabelFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10);
    }
    else
    {
        leftLabelFrame = CGRectMake(0, 0, leftMaxWidth, 10);
    }
    
    _leftLabel.frame = leftLabelFrame;
    
    if (leftAttributedText.length > 0) {
        _leftLabel.attributedText= leftAttributedText;
    }
    else
    {
        _leftLabel.text = leftText;
    }
    CGSize leftSize;
    if (leftMaxWidth < 0)
    {
        [_leftLabel sizeToFit];
        leftSize = _leftLabel.frame.size;
        leftMaxWidth = leftSize.width;
    }
    else
    {
        leftSize = [_leftLabel sizeThatFits:CGSizeMake(leftLabelFrame.size.width, CGFLOAT_MAX)];
    }
    leftLabelFrame.size.height = leftSize.height;
    leftLabelFrame.size.width = leftSize.width;
    _leftLabel.frame = leftLabelFrame;
    
    CGFloat rightWidth = maxWidth - gapWidth - leftMaxWidth;
    CGRect rightLabelFrame = CGRectMake(leftMaxWidth + gapWidth, 0, rightWidth, 10);
    _rightLabel.frame = rightLabelFrame;
    
    if (rightAttributedText.length > 0) {
        _rightLabel.attributedText = rightAttributedText;
    }
    else
    {
        _rightLabel.text = rightText;
    }
    CGSize rightSize = [_rightLabel sizeThatFits:CGSizeMake(rightLabelFrame.size.width, CGFLOAT_MAX)];
    if (rightSize.width < rightWidth)
    {
        rightWidth = rightSize.width;
    }
    rightLabelFrame.size.height = rightSize.height;
    rightLabelFrame.size.width = rightWidth;
    
    if (_rightLabel.textAlignment == NSTextAlignmentRight)
    {
        rightLabelFrame.origin.x = maxWidth - rightWidth;
    }
    _rightLabel.frame = rightLabelFrame;
    
    CGFloat height =  MAX(leftSize.height, rightSize.height);
    self.frame = CGRectMake(topLeft.x, topLeft.y, maxWidth, height);
    return self.frame;
}

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText
{
    return [self updateWithLeftPoint:topLeft leftText:leftText maxWidth:CDScreenWidth needResize:YES];
}

- (CGRect) updateWithLeftPoint:(CGPoint) topLeft
                      leftText:(NSString *) leftText
                      maxWidth:(CGFloat) maxWidth
                    needResize:(BOOL) needResize
{
    self.leftLabel.enableCopy = NO;
    self.rightLabel.enableCopy = NO;
    
    if (maxWidth == -1)
    {
        maxWidth = CDScreenWidth;
    }
    
    _leftLabel.text = leftText;
    
    CGSize leftSize = [_leftLabel sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    self.leftLabel.frame = CGRectMake(0, 0, leftSize.width, leftSize.height);
    CGFloat frameWidth = maxWidth;
    if (leftSize.width < maxWidth && needResize)
    {
        frameWidth = leftSize.width;
    }
    self.frame = CGRectMake(topLeft.x, topLeft.y, frameWidth, leftSize.height);
    _rightLabel.text = nil;
    return self.frame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
