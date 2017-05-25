//
//  CDHomeWarningTableViewCell.m
//  GodTomb
//
//  Created by xiangxiong on 2017/5/25.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDHomeWarningTableViewCell.h"

@interface CDHomeWarningTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@end

@implementation CDHomeWarningTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 96, 96)];
        [self.contentView addSubview:self.iconImageView];
        self.titleLabel = [BDAllocNewLabel allocNewLabelFontSize:18 textColor:BDColors_Important_GrayA];
        [self.contentView addSubview:self.titleLabel];
        self.subTitleLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayB];
        [self.contentView addSubview:self.subTitleLabel];
    }
    return self;
}

- (CGFloat)updateCellWithTitle:(NSString *)titleString subTitleString:(NSString *)subTitleString imageName:(NSString *)imageName
{
    self.iconImageView.image = [UIImage imageNamed:imageName];
    CGFloat labelAndImage = 15;
    CGFloat labelAndLabel = 10;
    CGFloat maxWidht = CDScreenWidth-CGRectGetMaxX(self.iconImageView.frame)-labelAndImage*2;
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+labelAndImage, labelAndLabel, maxWidht, 10);
    self.titleLabel.text = titleString;
    [self.titleLabel sizeToFit];
    
    self.subTitleLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame)+labelAndLabel, maxWidht, 10);
    self.subTitleLabel.text = subTitleString;
    [self.subTitleLabel sizeToFit];
    
    return CGRectGetMaxY(self.subTitleLabel.frame)+labelAndLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
