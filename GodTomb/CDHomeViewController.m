//
//  CDHomeViewController.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDHomeViewController.h"
#import "CDWebViewController.h"
#import "CDHomeTableViewCell.h"
#import "CDHomeViewModel.h"
#import "CDHomeDetailViewController.h"
#import "CDAuthorBaseInforViewController.h"
#import "CDContactMeViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CDHomeWarningTableViewCell.h"

NSString *const kCDHomeWarningTableViewCell = @"CDHomeWarningTableViewCell";
NSString *const kCDHomeTableViewCell = @"CDHomeTableViewCell";

@interface CDHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) CDHomeViewModel *previewModel;
@property (nonatomic, assign) BOOL noBar;
@property (nonatomic, assign) BOOL hideWarning;
@end

@implementation CDHomeViewController

- (instancetype)initWithNoLeftRightBar
{
    self = [super init];
    if (self) {
        self.noBar = YES;
        self.hideWarning = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CDHomeTitle;
    [self initData];
    if (!self.noBar) {
        [self createLeftBar];
        [self createRightBar];
    }
    [self createTableView];
    [self supportSpotLightSearch];
}

- (void)initData
{
    NSMutableArray *mArray = [CDHomeViewModel bookData];
    if (!self.hideWarning) {
        [mArray addObject:@{}];
    }
    self.dataArray = (NSArray *)mArray;
}

- (void)createLeftBar
{
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithTitle:CDHomeLeftTitle style:UIBarButtonItemStylePlain target:self action:@selector(authorBreif:)];
    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)authorBreif:(id)sender
{
    CDAuthorBaseInforViewController *breif = [[CDAuthorBaseInforViewController alloc]init];
    [self.navigationController pushViewController:breif animated:YES];
}

- (void)contactAuthor:(id)sender
{
    CDContactMeViewController *contact = [[CDContactMeViewController alloc]init];
    [self.navigationController pushViewController:contact animated:YES];
}

- (void)createRightBar
{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:CDHomeRightTitle style:UIBarButtonItemStylePlain target:self action:@selector(toWebView:)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)toWebView:(id)sender
{
    [self toWebPage:stackRoomUrl];
}

- (void)toUpdateApp:(id)sender
{
    if ([sender isEqualToString:@"appStore"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_ITUNES_URL]];
    }else{
        [self toWebPage:NOTIFICATIONURL];
    }
}

- (void)toWebPage:(NSString *)urlString
{
    CDWebViewController *web = [[CDWebViewController alloc]initWithUrl:urlString];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)createTableView
{
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CDScreenWidth, CDScreenHeight) style:UITableViewStyleGrouped];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.view addSubview:self.listTableView];
    [self.listTableView registerClass:[CDHomeTableViewCell class] forCellReuseIdentifier:kCDHomeTableViewCell];
    [self.listTableView registerClass:[CDHomeWarningTableViewCell class] forCellReuseIdentifier:kCDHomeWarningTableViewCell];
    self.listTableView.tableFooterView = [[UIView alloc]init];
    [self.listTableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        return 116;
    }
    return 148;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        CDHomeWarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCDHomeWarningTableViewCell forIndexPath:indexPath];
        [cell updateCellWithTitle:@"注意事项" subTitleString:@"使用过程中可能存在的一些问题" imageName:@"Icon-60"];
        return cell;
    }else{
        CDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCDHomeTableViewCell forIndexPath:indexPath];
        [cell updateCellModel:[self.dataArray objectAtIndex:indexPath.row]];
        [cell addTarget:self tag:indexPath.row sel:@selector(bookInformation:)];
        return cell;
    }
}

- (void)bookInformation:(UITapGestureRecognizer *)tap
{
    CDHomeDetailViewController *detail = [self toDetailController:[self.dataArray objectAtIndex:tap.view.tag]];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 6) {
        [self toWebPage:ABOUTSELF];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        CDHomeViewModel *model = self.dataArray[indexPath.row];
        [CDHomeViewModel bookDataController:self book:model.book];
    }
}

- (CDHomeDetailViewController *)toDetailController:(CDHomeViewModel *)model
{
    [CDMobclickEvent mobClickEventWithHomeDetail:model.titleName];
    CDHomeDetailViewController *detail = [[CDHomeDetailViewController alloc]initWithModel:model];
    return detail;
}

//SportLight
- (void)supportSpotLightSearch
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        @try {
            NSArray *arr = [CDAuthorBreifModel spotLightArray];;
            NSMutableArray *searchItems = [[NSMutableArray alloc]initWithCapacity:arr.count];
            for (int i = 0; i < arr.count; i++) {
                CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc]initWithItemContentType:(NSString *)kUTTypeImage];
                attributeSet.title = arr[i];
                attributeSet.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"%d",(i+1)]]);
                CSSearchableItem *item = [[CSSearchableItem alloc]initWithUniqueIdentifier:arr[i] domainIdentifier:@"CD.SpotLight" attributeSet:attributeSet];
                [searchItems addObject:item];
            }
            [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchItems completionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"%@",[error localizedDescription]);
                }
            }];
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
        } @finally {
            
        }
    });
}

- (void)sportLightDidSelectBook:(NSInteger)row
{
    CDHomeDetailViewController *detail = [self toDetailController:[self.dataArray objectAtIndex:row]];
    [self.navigationController pushViewController:detail animated:YES];
}

//3D Touch
- (void)check3DTouch
{
    if (isSupport3DTouch) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self check3DTouch];
}

-(nullable UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    if ([self.presentedViewController isKindOfClass:[CDHomeDetailViewController class]]) {
        return nil;
    }
    CGPoint point = [self.listTableView convertPoint:location fromView:self.view];
    NSIndexPath *index = [self.listTableView indexPathForRowAtPoint:point];
    if (index) {
        UITableViewCell *cell = [self.listTableView cellForRowAtIndexPath:index];
        CDHomeViewModel *model = [self.dataArray objectAtIndex:index.row];
        self.previewModel = model;
        previewingContext.sourceRect = [self.view convertRect:cell.frame fromView:self.listTableView];
        return [self toDetailController:model];
    }
    return nil;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:[self toDetailController:self.previewModel] sender:self];
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
