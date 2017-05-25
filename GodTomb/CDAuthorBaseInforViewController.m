//
//  CDAuthorBaseInforViewController.m
//  localNotification
//
//  Created by xiangxiong on 2017/3/30.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDAuthorBaseInforViewController.h"
#import "CDAuthorInformationViewController.h"
#import "CDHomeViewController.h"

@interface CDAuthorBaseInforViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mArray;
@end

@implementation CDAuthorBaseInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    [self initArray];
    [self createTableView];
    [self createRightBar];
}

- (void)createRightBar
{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"百科介绍" style:UIBarButtonItemStylePlain target:self action:@selector(toWebView:)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)toWebView:(id)sender
{
    [CDMobclickEvent mobClickEventWithAuthorWikipedia];
    CDWebViewController *web = [[CDWebViewController alloc]initWithUrl:@"https://baike.baidu.com/link?url=fTCRG0FLiI9SF6nlO6or7okzMUY6QEnk4EchWIzKKMf7ZtrnUfEOyODSmyfmDUWAVMlMnLiMFrd0YiRltRgdnEuoIOZ9g1DGvVxBJujl-fW"];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)initArray
{
    self.mArray = [NSMutableArray array];
    [self.mArray addObject:@"基本信息"];
    [self.mArray addObject:@"作品"];
    [self.mArray addObject:@"新浪微博"];
    [self.mArray addObject:@"腾讯微博"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BDLabel *label = [[BDLabel alloc]initWithFrame:CGRectMake(20, 13, 320, 10)];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = BDColors_Important_GrayA;
    label.text = self.mArray[indexPath.row];
    [label sizeToFit];
    [cell addSubview:label];
    label.canCopy = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *detail = nil;
    switch (indexPath.row) {
        case 0:
        {
            [CDMobclickEvent mobClickEventWithAuthorBaseInfor];
            detail = [[CDAuthorInformationViewController alloc]init];
        }
            break;
        case 1:
        {
            [CDMobclickEvent mobClickEventWithAuthorWorks];
            detail = [[CDHomeViewController alloc]initWithNoLeftRightBar];
        }
            break;
        case 2:
        {
            [CDMobclickEvent mobClickEventWithAuthorSinaWeibo];
            detail = [[CDWebViewController alloc]initWithUrl:@"https://weibo.com/u/1743854141?from=profile&wvr=5&loc=infdomain"];
        }
            break;
            case 3:
        {
            [CDMobclickEvent mobClickEventWithAuthorTencentWeibo];
            detail = [[CDWebViewController alloc]initWithUrl:@"http://t.qq.com/zhendong"];
        }
            break;
        default:
            break;
    }
    if (detail) {
        [self.navigationController pushViewController:detail animated:YES];
    }
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
