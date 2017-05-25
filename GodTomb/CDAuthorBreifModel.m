//
//  CDAuthorBreifModel.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/29.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDAuthorBreifModel.h"

@implementation CDAuthorBreifModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.name = [CDGeneralMethod stringForKey:@"name" withDiction:dic];
        self.breif = [CDGeneralMethod stringForKey:@"breif" withDiction:dic];
    }
    return self;
}

+ (NSArray *)spotLightArray
{
    return @[CDBookNameWithBSBM,CDBookNameWithSM,CDBookNameWithCSJ,CDBookNameWithZT,CDBookNameWithWMSJ,CDBookNameWithSS];
}

+ (CDAuthorBreifModel *)authorData
{
    CDAuthorBreifModel *model = [[CDAuthorBreifModel alloc]init];
    model.name = @"辰东";
    model.breif = @"辰东，本名杨振东，北京人。起点中文网白金作者，中国作协成员。崛起于网络文学青铜时代，是当前网络小说界最具影响力和代表性的写手之一，其代表作有 《圣墟》，《完美世界》，《遮天》，《长生界》，《神墓》，《不死不灭》等";
    model.baseInforArray = @[@"中文名：杨振东",@"别    名：辰东",@"国    籍：中华人民共和国 ",@"民    族：汉 ",
                             @"出生地：北京",@"职    业：作家 ",@"毕业院校：中国石油大学",
                             @"主要成就：荣登2013第八届中国作家富豪榜 \n荣登2014第九届中国作家富豪榜 \n荣登2012第七届中国作家富豪榜",@"代表作品：《完美世界》《神墓》《遮天》",@"签约网站：起点中文网 "];
    model.otherInforArray = @[@{@"key":@"人物简介",@"value":@"辰东，著名网络写手，起点白金作者。崛起于网络文学青铜时代，在首届网文之王评选中位列五大至尊之一和十二主神之一，被书友称为坑神。三部作品《神墓》、《遮天》、《完美世界》都曾登顶百度小说风云榜，其中《神墓》、《完美世界》更长期占据第一，为作品登顶百度小说风云榜次数最多的网络写手之一，原著小说曾蝉联中国大型文学网“起点中文网”榜首数年，其作品相继被改编为网游和手游，实体书深受两岸三地读者喜爱与欢迎。"},
                              @{@"key":@"人物特点",@"value":@"辰东以《神墓》一文扬名立万，开创了太古战争流和玄幻悬念流，也成就了其“坑神”的名头。 \n\n辰东想象力超绝，行文如天马行空，超脱不羁，能最大程度调动读者的代入感和心理欲求，其亦庄亦谐，纤秾合度的笔法也使读者们欲罢不能；此外，辰东的巅峰作品《神墓》在热血中暗藏人性的挣扎，世情的悲凉，在看似欢喜的结局中潜藏对社会的隐忧，已是超出了一般网文的境界，在网文领域中可以精品名之。"},
                              @{@"key":@"人物作品",@"value":@""}];
    return model;
}
@end
