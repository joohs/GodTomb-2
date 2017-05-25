//
//  baseViewController.h
//  test
//
//  Created by TTgg on 16/6/27.
//  Copyright © 2016年 吕文钊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+BDNSString.h"
#import "UIView+BDLayer.h"
//#import "UIViewController+BDBackButtonHandler.h"
typedef NS_ENUM(NSInteger, BaseType)
{
    baseTypeWithController = 0,
    baseTypeWithTableView  = 1,
    baseTypeWithSubController  = 2
};
typedef void (^BaseRightTopBtn)(id sender) ;
UIKIT_EXTERN NSString * const BaseRightTopKeyNomer;
UIKIT_EXTERN NSString * const BaseRightTopKeySelect;

@interface BDNewBaseViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) UIScrollView *subContainer;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, assign) BOOL tableIsRefresh;
-(BaseType)getBaseTyper;//type
-(UITableViewStyle)getBaseTableViewStyle;//BaseType == 1,tabletype
-(BOOL)isRefresh;//BaseType == 1,headerRefresh
-(BOOL)isLoadMore;//BaseType == 1,FootLoadMore
-(void)mjLoad:(BOOL)isRefresh;//BaseType == 1,do
-(void)reloadTableViewData;
-(BOOL)hasNoData;
-(void)changeSubTableViewHeight:(CGFloat)height;
-(NSArray *)getSubControllers;//BaseType == 2,Controllers
-(void)scrollForPage:(NSInteger)page;//BaseType == 2,scroll to page
-(void)subClick:(NSInteger)page;//BaseType == 2,sub clicked

-(NSString *)noDataStr;

-(UIView *)returnFootView;//viewFoot
-(UIView *)returnHeadView;//viewHead
- (void)reloadFootView;
-(void)hideFootView:(BOOL)dd withAnimate:(BOOL)Animate;

-(void)setBase_leftTopBtnsAction:(BaseRightTopBtn)block withTitle:(id )base_leftTopBtn, ...;
- (BOOL)navigationShouldPopOnBackButton;

@end
