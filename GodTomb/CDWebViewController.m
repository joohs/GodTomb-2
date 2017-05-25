//
//  CDWebViewController.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDWebViewController.h"
#import <WebKit/WebKit.h>

@interface CDWebViewController ()<UIWebViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation CDWebViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
}

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[CDGeneralMethod returnUrlString:self.url]]];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%ld",(long)error.code);
    if (error.code == -1009) {
        [SVProgressHUD dismiss];
        if (!self.isFirst) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"没有网络连接" message:@"是否前往设置查看网络是否连接" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往设置", nil];
            [alert show];
        }
        self.isFirst = YES;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadNetWork)
                                                     name:UIApplicationDidBecomeActiveNotification object:nil];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)reloadNetWork
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[CDGeneralMethod returnUrlString:self.url]]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
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
