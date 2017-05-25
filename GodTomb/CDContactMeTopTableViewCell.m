//
//  CDContactMeTopTableViewCell.m
//  GodTomb
//
//  Created by xiangxiong on 2017/4/25.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDContactMeTopTableViewCell.h"
#import "BDAllocNewLabel.h"

@interface CDContactMeTopTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@end

@implementation CDContactMeTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.iconImage.image = [UIImage imageNamed:@"AppIcon"];
        [self.contentView addSubview:self.iconImage];
        self.iconImage.center = CGPointMake(CDScreenWidth/2, 30+self.iconImage.frame.size.height/2);
        
        self.nameLabel = [BDAllocNewLabel allocNewLabelFontSize:16 textColor:BDColors_Important_GrayA];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.text = CDHomeTitle;
        [self.nameLabel sizeToFit];
        self.nameLabel.center = CGPointMake(CDScreenWidth/2, CGRectGetMaxY(self.iconImage.frame)+15);
        
        self.versionLabel = [BDAllocNewLabel allocNewLabelFontSize:13 textColor:BDColors_Important_GrayC];
        [self.contentView addSubview:self.versionLabel];
        self.versionLabel.text = [NSString stringWithFormat:@"v %@",[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]];
        [self.versionLabel sizeToFit];
        self.versionLabel.center = CGPointMake(CDScreenWidth/2, CGRectGetMaxY(self.nameLabel.frame)+15);
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
