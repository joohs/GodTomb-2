//
//  CDAuthorInformationViewController.m
//  localNotification
//
//  Created by xiangxiong on 2017/3/30.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDAuthorInformationViewController.h"
#import "BDCalculateCellHeight.h"
#import "CDAuthorInformationTableViewCell.h"

NSString *const kCDAuthorInformationTableViewCell = @"CDAuthorInformationTableViewCell";

@interface CDAuthorInformationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CDAuthorInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基本信息";
    [self initArray];
    [self createTableView];
    
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CDScreenWidth, CDScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CDAuthorInformationTableViewCell class] forCellReuseIdentifier:kCDAuthorInformationTableViewCell];
}

- (void)initArray
{
    self.mArray = [NSMutableArray array];
    [self.mArray addObject:@{@"left":@"中文名：",@"right":@"杨振东 "}];
    [self.mArray addObject:@{@"left":@"别名：",@"right":@"辰东"}];
    [self.mArray addObject:@{@"left":@"国籍：",@"right":@"中华人民共和国"}];
    [self.mArray addObject:@{@"left":@"民族：",@"right":@"汉"}];
    [self.mArray addObject:@{@"left":@"出生地：",@"right":@"北京"}];
    [self.mArray addObject:@{@"left":@"出生日期：",@"right":@"1982年6月7日"}];
    [self.mArray addObject:@{@"left":@"职业：",@"right":@"作家"}];
    [self.mArray addObject:@{@"left":@"毕业院校：",@"right":@"中国石油大学"}];
    [self.mArray addObject:@{@"left":@"主要成就：",@"right":@"荣登2014第八届中国作家富豪榜 \n荣登2013第九届中国作家富豪榜  \n荣登2012第七届中国作家富豪榜"}];
    [self.mArray addObject:@{@"left":@"代表作品：",@"right":@"《完美世界》《神墓》《遮天》"}];
    [self.mArray addObject:@{@"left":@"签约网站：",@"right":@"起点中文网"}];
    [self.mArray addObject:@{@"left":@"作者特点：",@"right":@"辰东以《神墓》一文扬名立万，开创了太古战争流和玄幻悬念流，在日渐泛白化的网文中绽放出一抹亮色，也成就了其“坑神”的名头。又因其毕业于北京的名校，被某些书迷赞为“燕京才子”。\n辰东想象力超绝，行文如天马行空，超脱不羁，能最大程度调动读者的代入感和心理欲求，其亦庄亦谐，纤秾合度的笔法也使读者们欲罢不能；此外，辰东的巅峰作品在热血中暗藏人性的挣扎，世情的悲凉，在看似欢喜的结局中潜藏对社会的隐忧，已是超出了一般网文的境界，在网文领域中可以精品名之。"}];
    [self.mArray addObject:@{@"left":@"人物简介：",@"right":@"著名网络写手，起点中文网白金作者，崛起于网络文学青铜时代，在首届网文之王评选中位列五大至尊之一和十二主神之一，被书友称为坑神，有燕京才子之名。三部作品《神墓》、《遮天》、《完美世界》都曾登顶百度小说风云榜，其中《神墓》、《完美世界》更长期占据第一，为作品登顶百度小说风云榜次数最多的网络写手之一。\n援助小说曾蝉联中国大型文学网“起点中文网”榜首数年，其作品相继被改编为网游和手游，实体书深受两岸三地读者喜爱与欢迎。"}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *contentArray = @[@{CalculateHeight_LabelFontSize:@"16",CalculateHeight_LabelContent:[self.mArray[indexPath.row] valueForKey:@"right"],CalculateHeight_LabelWidth:[NSNumber numberWithFloat:CDScreenWidth-40-83]}];
    return [BDCalculateCellHeight calculateCellHeight:contentArray andDefaultHeight:26];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDAuthorInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCDAuthorInformationTableViewCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.mArray[indexPath.row];
    [cell updateCellModel:dic[@"left"] rightString:dic[@"right"]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
