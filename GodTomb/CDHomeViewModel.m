//
//  CDHomeViewModel.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDHomeViewModel.h"
#import "PaperController.h"

@implementation CDHomeViewModel
- (instancetype)initWithDiction:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.imageName = [CDGeneralMethod stringForKey:@"imageName" withDiction:dic];
        self.titleName = [CDGeneralMethod stringForKey:@"titleName" withDiction:dic];
        self.chapterCount = [CDGeneralMethod stringForKey:@"chapterCount" withDiction:dic];
        self.completeTime = [CDGeneralMethod stringForKey:@"completeTime" withDiction:dic];
        self.breif = [CDGeneralMethod stringForKey:@"breif" withDiction:dic];
        self.status = [CDGeneralMethod stringForKey:@"status" withDiction:dic];
        self.introduceUrl = [CDGeneralMethod stringForKey:@"introduceUrl" withDiction:dic];
        self.numberOfWords = [CDGeneralMethod stringForKey:@"numberOfWords" withDiction:dic];
        self.pictureUrl = [CDGeneralMethod stringForKey:@"pictureUrl" withDiction:dic];
        self.originalUrl = [CDGeneralMethod stringForKey:@"originalUrl" withDiction:dic];
        self.book = [Book forName:[NSString stringWithFormat:@"%@%@",self.titleName,@".txt"]];
    }
    return self;
}

+ (instancetype)getModelWithDiction:(NSDictionary *)dic
{
    return [[CDHomeViewModel alloc]initWithDiction:dic];
}

+ (NSString *)introduce:(NSString *)string
{
    return [NSString stringWithFormat:@"https://baike.baidu.com/item/%@",string];
}

+ (NSMutableArray *)bookData
{
    NSMutableArray *modelMarr = [NSMutableArray array];
    NSMutableArray *mArr = [NSMutableArray array];
    [mArr addObject:@{@"imageName":@"6",
                      @"titleName":@"圣墟",
                      @"chapterCount":@"已有1420",
                      @"completeTime":@"2016-11-01上传起点",
                      @"breif":@"在破败中崛起，在寂灭中复苏。\n沧海成尘，雷电枯竭，那一缕幽雾又一次临近大地，世间的枷锁被打开了，一个全新的世界就此揭开神秘的一角……",
                      @"status":@"连载",
                      @"content":@"",
                      @"numberOfWords":@"",
                      @"originalUrl":@"",
                      @"introduceUrl":[self introduce:@"圣墟"],
                      @"pictureUrl":@"https://baike.baidu.com/pic/圣墟/20177753/0/ac6eddc451da81cb3b9f78a45b66d01609243159?fr=lemma&ct=single#aid=0&pic=ac6eddc451da81cb3b9f78a45b66d01609243159"}];
    
    [mArr addObject:@{@"imageName":@"5",
                      @"titleName":@"完美世界",
                      @"chapterCount":@"2082",
                      @"completeTime":@"2016-08-09",
                      @"breif":@"一粒尘可填海，一根草斩尽日月星辰，弹指间天翻地覆。\n群雄并起，万族林立，诸圣争霸，乱天动地；问苍茫大地，谁主沉浮？\n一个少年从大荒中走出，一切从这里开始",
                      @"status":@"完结",
                      @"content":@"",
                      @"numberOfWords":@"658.72万",
                      @"originalUrl":@"",
                      @"introduceUrl":[self introduce:@"完美世界/9446056"],
                      @"pictureUrl":@"https://baike.baidu.com/pic/完美世界/9446056/0/4034970a304e251f96757afdae86c9177f3e5330?fr=lemma&ct=single#aid=0&pic=4034970a304e251f96757afdae86c9177f3e5330"}];
    
    [mArr addObject:@{@"imageName":@"4",
                      @"titleName":@"遮天",
                      @"chapterCount":@"1822",
                      @"completeTime":@"2013-05-21",
                      @"breif":@"冰冷与黑暗并存的宇宙深处，九具庞大的龙尸拉着一口青铜古棺，亘古长存。\n这是太空探测器在枯寂的宇宙中捕捉到的一幅极其震撼的画面。\n九龙拉棺，究竟是回到了上古，还是来到了星空的彼岸？\n一个浩大的仙侠世界，光怪陆离，神秘无尽。热血似火山沸腾，激情若瀚海汹涌，欲望如深渊无止境……\n登天路，踏歌行，弹指遮天。",
                      @"status":@"完结",
                      @"numberOfWords":@"6359089",
                      @"originalUrl":@"",
                      @"introduceUrl":[self introduce:@"遮天"],
                      @"pictureUrl":@"https://baike.baidu.com/pic/遮天/7572/0/0824ab18972bd407b427bbb178899e510eb3099d?fr=lemma&ct=single#aid=0&pic=0824ab18972bd407b427bbb178899e510eb3099d"}];
    
    [mArr addObject:@{@"imageName":@"3",
                      @"titleName":@"长生界",
                      @"chapterCount":@"688",
                      @"completeTime":@"2012-09-20",
                      @"breif":@"世上谁人能不死？\n任你风华绝代，艳冠天下，到头来也是红粉骷髅；任你一代天骄，坐拥万里江山，到头来也终将化成一抔黄土。\n不过，关于长生不死的传说却始终流传于世。\n故老相传，超脱于人世间之外，有一个浩大的长生界，那里百族林立，有实力堪比神灵的古老战族，有身体内封印着上古不灭兽魂的强大蛮族，还有风姿绝世的丽人族……更有真正的神祗！　　传说，已经获得永生的千古人杰：达摩、独孤求败、西门吹雪、师妃暄、婠婠、浪翻云……都已经进入那个世界。　　在不死传说沉寂无尽岁月后，一代天骄神女武破虚空……而萧晨也被卷入漫天神光中，在万众顶礼膜拜中踏破虚空而去。　　热血澎湃的战斗，激情与欲望的诱惑……萧晨追寻着长生不死者的足迹，将慢慢揭开一个被尘封了无尽岁月的上古神话世界的面纱。",
                      @"status":@"完结",
                      @"content":@"",
                      @"numberOfWords":@"2957727",
                      @"originalUrl":@"",
                      @"introduceUrl":[self introduce:@"长生界/6551163"],
                      @"pictureUrl":@"https://baike.baidu.com/pic/长生界/6551163/0/f703738da97739123c10c66bfb198618367ae282?fr=lemma&ct=single#aid=0&pic=f703738da97739123c10c66bfb198618367ae282"}];
    
    [mArr addObject:@{@"imageName":@"2",
                      @"titleName":@"神墓",
                      @"chapterCount":@"788",
                      @"completeTime":@"2008-11-24",
                      @"breif":@"“神死了……魔灭了……我还活着……为什么？为何让我从远古神墓中复出，我将何去何从？”\n神魔陵园除了安葬着人类历代的最强者、异类中的顶级修炼者外，其余每一座坟墓都埋葬着一位远古的神或魔，这是一片属于神魔的安息之地。 一个平凡的青年死去万载岁月之后，从远古神墓中复活而出，如林的神魔墓碑令青年感到异常震撼。\n悠悠万载，沧海桑田。\n原本有一海峡之隔的仙幻大陆和魔幻大陆相连在了一起，道法与魔法并存，真气与斗气同在，东方神龙与西方巨龙共舞……\n绝代佳人，缠绵的爱情；恐怖绝地，玄异的惊险之旅；远古遗闻，失落的传说；众神之秘，不灭的神之遗迹……\n神秘的东方修道者、奇诡的西方魔法师、无敌的东方武者、至强的西方龙战士，演绎出一曲惊心动魄的传奇…….",
                      @"status":@"完结",
                      @"content":@"",
                      @"numberOfWords":@"3002416",
                      @"originalUrl":@"",
                      @"introduceUrl":[self introduce:@"神墓"],
                      @"pictureUrl":@"https://baike.baidu.com/pic/神墓/9947627/0/dc54564e9258d1099ea9eec5d758ccbf6c814d7a?fr=lemma&ct=single#aid=0&pic=dc54564e9258d1099ea9eec5d758ccbf6c814d7a"}];
    
    [mArr addObject:@{@"imageName":@"1",
                      @"titleName":@"不死不灭",
                      @"chapterCount":@"246",
                      @"completeTime":@"2006-08-14",
                      @"breif":@"“历千劫万险，纵使魂飞魄散，我灵识依在，战百世轮回，纵使六道无常，我依然永生！天道！天道！天已失道，何需奉天，道既死，魔应生！”\n一个被称为魔的人，为了生存而苦苦挣扎，最后走上了一条抗天之路……",
                      @"status":@"完结",
                      @"content":@"",
                      @"numberOfWords":@"782206",
                      @"originalUrl":@"",
                      @"introduceUrl":[self introduce:@"不死不灭"],
                      @"pictureUrl":@"https://baike.baidu.com/pic/不死不灭/5388297/0/8718367adab44aedd2a39985b21c8701a08bfbe6?fr=lemma&ct=single#aid=0&pic=8718367adab44aedd2a39985b21c8701a08bfbe6"}];
    
    for (NSDictionary *dic in mArr) {
        [modelMarr addObject:[CDHomeViewModel getModelWithDiction:dic]];
    }
    return modelMarr;
}

+ (void)bookDataController:(UIViewController *)controller book:(Book *)book
{
    PaperController *_paperController = [[PaperController alloc] init];
    [_paperController.view setFrame:CGRectMake(0, 0, CDScreenWidth, CDScreenHeight_All)];
    [_paperController bindBook:book];
    [controller presentViewController:_paperController animated:YES completion:^{
    }];
}
@end
