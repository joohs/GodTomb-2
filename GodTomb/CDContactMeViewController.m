//
//  CDContactMeViewController.m
//  GodTomb
//
//  Created by xiangxiong on 2017/4/25.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDContactMeViewController.h"
#import "CDContactMeTopTableViewCell.h"
#import "BDLeftRightLabelTableViewCell.h"
#import <MessageUI/MessageUI.h>

NSString *const kAuthorEmail = @"635731832@qq.com";
NSString *const kAuthorQQ = @"635731832";
NSString *const kAuthorWeb = @"http://www.xinxinsun.cn";
NSString *const kAuthorWeixin = @"xxxiangxiong";

NSString *const kCDContactMeTopTableViewCell = @"CDContactMeTopTableViewCell";
NSString *const kCDTableViewDefaultCell = @"BDLeftRightLabelTableViewCell";

@interface CDContactMeViewController ()<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UITableView *contactTableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation CDContactMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    // Do any additional setup after loading the view.
    self.contactTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CDScreenWidth, CDScreenHeight) style:UITableViewStyleGrouped];
    self.contactTableView.delegate = self;
    self.contactTableView.dataSource = self;
    [self.view addSubview:self.contactTableView];
    [self.contactTableView registerClass:[CDContactMeTopTableViewCell class] forCellReuseIdentifier:kCDContactMeTopTableViewCell];
    [self.contactTableView registerClass:[BDLeftRightLabelTableViewCell class] forCellReuseIdentifier:kCDTableViewDefaultCell];
    self.dataArray = @[@{@"left":@"",@"right":@""}, @{@"left":@"发送邮件",@"right":kAuthorEmail,@"accessoryType":@"1"}, @{@"left":@"发送QQ消息",@"right":kAuthorQQ,@"accessoryType":@"1"}, @{@"left":@"微信号",@"right":kAuthorWeixin,@"accessoryType":@"0"}, @{@"left":@"打开网页",@"right":kAuthorWeb,@"accessoryType":@"1"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CDContactMeTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCDContactMeTopTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    BDLeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCDTableViewDefaultCell forIndexPath:indexPath];
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[dic objectForKey:@"accessoryType"] boolValue]) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.rightLabel.canCopy = YES;
    [cell updateCellWithLeftMost:dic[@"left"] rightMost:dic[@"right"] accessoryTypeIsNone:[[dic objectForKey:@"accessoryType"] boolValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = nil;
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    if ([[dic objectForKey:@"accessoryType"] boolValue]) {
        switch (indexPath.row) {
            case 1:
            {
                if ([MFMailComposeViewController canSendMail])
                {
                    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                    mail.navigationBar.tintColor = [UIColor whiteColor];
                    [mail setToRecipients:[NSArray arrayWithObjects:dic[@"right"],nil]];
                    [mail setSubject:@""];
                    [mail setMessageBody:@"" isHTML:NO];
                    mail.mailComposeDelegate = self;
                    [self presentViewController:mail animated:YES completion:^{}];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"请配置邮箱信息!"];
                }
            }
                break;
            case 2:
            {
                NSString *sche = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",[dic valueForKey:@"right"]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sche]];
            }
                break;
            case 4:
            {
                viewController = [[CDWebViewController alloc]initWithUrl:dic[@"right"]];
            }
                break;
            default:
                break;
        }
    }
    if ([viewController isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
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
