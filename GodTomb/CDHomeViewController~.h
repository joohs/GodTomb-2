//
//  CDHomeViewController.h
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CDHomeViewController : UIViewController
- (instancetype)initWithNoLeftRightBar;
- (void)authorBreif:(id)sender;
- (void)contactAuthor:(id)sender;
- (void)sportLightDidSelectBook:(NSInteger)row;
@end
