//
//  CDAuthorInformationTableViewCell.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/30.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDAuthorInformationTableViewCell.h"
#import "BDLeftRightLabel.h"

@interface CDAuthorInformationTableViewCell ()
@property (nonatomic, strong) BDLeftRightLabel *leftRightBar;
@end

@implementation CDAuthorInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftRightBar = [[BDLeftRightLabel alloc]initWithLeftTextFont:[UIFont systemFontOfSize:16] rightTextFont:[UIFont systemFontOfSize:16] leftTextColor:BDColors_Important_GrayA rightTextColor:BDColors_Important_GrayB];
        [self.contentView addSubview:self.leftRightBar];
    }
    return self;
}

- (CGFloat)updateCellModel:(NSString *)leftString rightString:(NSString *)rightString
{
    CGFloat orginY = 14;
    [self.leftRightBar updateWithLeftPoint:CGPointMake(20, orginY) leftText:leftString rightText:rightString gapWidth:0 maxWidth:CDScreenWidth-40 leftMaxWidth:83];
    return CGRectGetMaxY(self.leftRightBar.frame) + orginY;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
