//
//  CDBaseViewController.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/29.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDBaseViewController.h"


@interface CDBaseViewController ()

@end

@implementation CDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BDColors_Important_GrayD;
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BarLeftback"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem = backItem;
}

- (void) back:(id) sender
{
    if ([[self.navigationController viewControllers] count] == 1)
    {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
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
