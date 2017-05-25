//
//  CDAuthorBreifTopTableViewCell.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/29.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDAuthorBreifTopTableViewCell.h"
#import "CDAuthorBreifModel.h"

@interface CDAuthorBreifTopTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *breifLabel;
@end

@implementation CDAuthorBreifTopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [BDAllocNewLabel allocNewLabelFontSize:25 textColor:BDColors_Important_GrayA];
        self.breifLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayA];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.breifLabel];
    }
    return self;
}

- (void)updateCellModelWith:(CDAuthorBreifModel *)model
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
