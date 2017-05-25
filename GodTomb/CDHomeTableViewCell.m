//
//  CDHomeTableViewCell.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDHomeTableViewCell.h"
#import "CDHomeViewModel.h"

@interface CDHomeTableViewCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel     *titleNameLabel;
@property (nonatomic, strong) UILabel     *chapterCountLabel;
@property (nonatomic, strong) UILabel     *completeTimeLabel;
@property (nonatomic, strong) UILabel     *breifLabel;
@end

@implementation CDHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.coverImageView];
        self.titleNameLabel = [BDAllocNewLabel allocNewLabelFontSize:18 numberLine:1 textColor:BDColors_Important_BlueA];
        self.titleNameLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:self.titleNameLabel];
        self.chapterCountLabel = [BDAllocNewLabel allocNewLabelFontSize:14 numberLine:1 textColor:BDColors_Important_GrayB];
        [self.contentView addSubview:self.chapterCountLabel];
        self.completeTimeLabel = [BDAllocNewLabel allocNewLabelFontSize:14 numberLine:1 textColor:BDColors_Important_GrayB];
        [self.contentView addSubview:self.completeTimeLabel];
        self.breifLabel = [BDAllocNewLabel allocNewLabelFontSize:14 numberLine:2 textColor:BDColors_Important_GrayB];
        [self.contentView addSubview:self.breifLabel];
    }
    return self;
}

- (void)updateCellModel:(CDHomeViewModel *)model
{
    self.coverImageView.frame = CGRectMake([self viewEdge].right, [self viewEdge].top, 96, 128);
    self.coverImageView.image = [UIImage imageNamed:model.imageName];
    CGFloat imageLabelGap = 15;
    CGFloat labelLabelGap = 10;
    CGFloat maxLabelWidth = CDScreenWidth-CGRectGetWidth(self.coverImageView.frame)-[self viewEdge].right-[self viewEdge].left-imageLabelGap;
    
    self.titleNameLabel.frame = CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+imageLabelGap, [self viewEdge].top, maxLabelWidth, 10);
    self.titleNameLabel.text = model.titleName;
    [self.titleNameLabel sizeToFit];
    self.titleNameLabel.frame = CGRectMake(self.titleNameLabel.frame.origin.x, self.titleNameLabel.frame.origin.y, maxLabelWidth, self.titleNameLabel.frame.size.height);
    
    self.chapterCountLabel.frame = CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+imageLabelGap, CGRectGetMaxY(self.titleNameLabel.frame)+labelLabelGap*2, maxLabelWidth, 10);
    self.chapterCountLabel.text = [NSString stringWithFormat:@"章节数：%@章",model.chapterCount];
    [self.chapterCountLabel sizeToFit];
    self.chapterCountLabel.frame = CGRectMake(self.chapterCountLabel.frame.origin.x, self.chapterCountLabel.frame.origin.y, maxLabelWidth, self.chapterCountLabel.frame.size.height);
    
    self.completeTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+imageLabelGap, CGRectGetMaxY(self.chapterCountLabel.frame)+labelLabelGap, maxLabelWidth, 10);
    self.completeTimeLabel.text = [NSString stringWithFormat:@"完成时间：%@",model.completeTime];
    [self.completeTimeLabel sizeToFit];
    self.completeTimeLabel.frame = CGRectMake(self.completeTimeLabel.frame.origin.x, self.completeTimeLabel.frame.origin.y, maxLabelWidth, self.completeTimeLabel.frame.size.height);
    
    self.breifLabel.frame = CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+imageLabelGap, CGRectGetMaxY(self.completeTimeLabel.frame)+labelLabelGap, maxLabelWidth, 10);
    self.breifLabel.text = [NSString stringWithFormat:@"%@",model.breif];
    [self.breifLabel sizeToFit];
    
}

- (UIEdgeInsets)viewEdge
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)addTarget:(id)target tag:(NSInteger)tag sel:(SEL)sel
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:sel];
    [self.titleNameLabel addGestureRecognizer:tap];
    self.titleNameLabel.tag = tag;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
