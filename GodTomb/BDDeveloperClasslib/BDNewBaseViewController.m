//
//  baseViewController.m
//  test
//
//  Created by TTgg on 16/6/27.
//  Copyright © 2016年 吕文钊. All rights reserved.
//

#import "BDNewBaseViewController.h"

NSString *const BaseRightTopKeyNomer = @"BaseRightTopKeyNomer";
NSString *const BaseRightTopKeySelect = @"BaseRightTopKeySelect";


@interface BDNewBaseViewController ()
{
    NSMutableArray *_rightTopBtns;
    BaseRightTopBtn _baseRightTopBtnBlock;
    
    UIView *_noDataView;
    
    CGFloat _headViewHeight;
    CGFloat _midViewHeight;
    CGFloat _footViewHeight;
}
@end
@implementation BDNewBaseViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (![self.rt_navigationController.rt_viewControllers containsObject:self]) {
        if ([self respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
            [self navigationShouldPopOnBackButton];
        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BDColors_Important_GrayD;
    if ([self getBaseTyper] == baseTypeWithTableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:self.view.frame style:[self getBaseTableViewStyle]];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = BDColors_Important_GrayD;
        if ([self respondsToSelector:@selector(returnHeadView)] ) {
            _headView = [self returnHeadView];
            if (_headView != nil) {
                [self.view addSubview:_headView];
                _headView.frameY = 0;
                _tableView.frameY = _headView.frameBottom;
                _tableView.frameHeight -= _headView.frameHeight;
            }
        }
        if ([self respondsToSelector:@selector(returnFootView)]) {
            _footView = [self returnFootView];
            if (_footView != nil) {
                _tableView.frameHeight -= _footView.frameHeight;
                _footView.frameY = _tableView.frameBottom;
                [self.view addSubview:_footView];
            }
        }
//        if ( _footView != nil||_headView != nil) {
            _tableView.frameHeight -= 64;
            _footView.frameY = _tableView.frameBottom;
//        }
        if ([self isRefresh] == YES) {
            [self refresh];
        }
        if ([self isLoadMore] == YES) {
            [self loadMore];
        }
        [self returnNoDataViewSigle:YES];
        _midViewHeight = _tableView.frameHeight;
    }
    else if ([self getBaseTyper] == baseTypeWithSubController)
    {
        self.automaticallyAdjustsScrollViewInsets = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _subContainer = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _subContainer.delegate = self;
        _subContainer.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_subContainer];
        _subContainer.backgroundColor = BDColors_Important_GrayD;
        _subContainer.pagingEnabled = YES;
        if ([self respondsToSelector:@selector(returnHeadView)]) {
            _headView = [self returnHeadView];
            [self.view addSubview:_headView];
            _headView.frameY = 0;
            _subContainer.frameY = _headView.frameBottom;
            _subContainer.frameHeight -= _headView.frameHeight;
            _subContainer.frameHeight -= 64;
        }
        if ([self respondsToSelector:@selector(returnFootView)]) {
            _footView = [self returnFootView];
            _subContainer.frameHeight -= _footView.frameHeight;
            _footView.frameY = _tableView.frameBottom;
            [self.view addSubview:_footView];
        }
        if ([self respondsToSelector:@selector(getSubControllers)]) {
            NSArray *subArrays = [[NSArray alloc]initWithArray:[self getSubControllers]];
            for (int i = 0; i < subArrays.count ; i ++) {
                UIViewController *controller = subArrays[i];
                [_subContainer addSubview:controller.view];
                controller.view.frameOrigin = CGPointMake(SCREEN_WIDTH * i, 0);
                controller.view.frameSize = CGSizeMake(SCREEN_WIDTH, _subContainer.frameHeight);
                [self resetFrame:(BDNewBaseViewController *)controller];
                [(BDNewBaseViewController *)controller changeSubTableViewHeight:controller.view.frameHeight];
                [self addChildViewController:controller];
            }
            _subContainer.contentSize = CGSizeMake(SCREEN_WIDTH*subArrays.count, _subContainer.frameHeight);
        }
        _midViewHeight = _subContainer.frameHeight;
    }
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BarLeftback"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    self.navigationItem.leftBarButtonItem = btn;
    
    
    
    if (self.headView != nil) {
        [self.headView bd_addViewSigleLineColor:BDColors_Important_GrayD withType:BDViewLineWithPosition_Bottom];
        _headViewHeight = self.headView.frameHeight;
    }
    if (self.footView != nil) {
        [self.footView bd_addViewSigleLineColor:BDColors_Important_GrayD withType:BDViewLineWithPosition_Top];
        _footViewHeight = self.footView.frameHeight;
    }
}
-(void)resetFrame:(BDNewBaseViewController *)vc
{
    if (vc.footView != nil) {
        vc.footView.frameBottom = vc.view.frameHeight;
    }
}


//接口
-(BaseType)getBaseTyper
{
    return baseTypeWithController;
}
-(UITableViewStyle)getBaseTableViewStyle
{
    return UITableViewStylePlain;
}
-(BOOL)isRefresh
{
    return NO;
}
-(BOOL)isLoadMore
{
    return NO;
}
-(void)mjLoad:(BOOL)isRefresh
{
    //refresh and load
}
-(void)changeSubTableViewHeight:(CGFloat)height
{
    if (_tableView) {
        _tableView.frameHeight = self.view.frameHeight - self.headView.frameHeight - self.footView.frameHeight;
        [self returnNoDataViewSigle:NO];
    }
}
-(NSArray *)getSubControllers
{
    return nil;
}
-(UIView *)returnHeadView
{
    return nil;
}
-(UIView *)returnFootView
{
    return nil;
}
- (void)reloadFootView
{
    if ([self respondsToSelector:@selector(returnFootView)]) {
        [_footView removeFromSuperview];
        _footView = [self returnFootView];
        if (_footView != nil) {
            _footView.frameY = _tableView.frameBottom;
            [self.view addSubview:_footView];
        }
    }
}
-(void)scrollForPage:(NSInteger)page
{
}
-(void)subClick:(NSInteger)page
{
    [_subContainer setContentOffset:CGPointMake(page * SCREEN_WIDTH, 0) animated:YES];
}
-(void)reloadTableViewData
{
    _noDataView.hidden = ![self hasNoData];
    [_tableView reloadData];
}
-(BOOL)hasNoData
{
    return YES;
}
-(void)hideFootView:(BOOL)dd withAnimate:(BOOL)Animate
{
    [UIView animateWithDuration:(Animate == YES)?0.3:0 animations:^{
        if (dd == YES) {
            _footView.frameHeight = 0;
            if ([self getBaseTyper] == 1) {
                _tableView.frameHeight = _midViewHeight + _footViewHeight;
            }
            else if ([self getBaseTyper] == 2)
            {
                _subContainer.frameHeight = _midViewHeight + _footViewHeight;
            }
        }
        else
        {
            _footView.frameHeight = _footViewHeight;
            if ([self getBaseTyper] == 1) {
                _tableView.frameHeight = _midViewHeight;
            }
            else if ([self getBaseTyper] == 2)
            {
                _subContainer.frameHeight = _midViewHeight ;
            }
        }
    }];
}

-(void)returnNoDataViewSigle:(BOOL)isSigle
{
    if (_noDataView == nil) {
        _noDataView = [[UIView alloc]initWithFrame:_tableView.bounds];
        UIImage *image = [UIImage imageNamed:@"NoDataNothing"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [imageView sizeToFit];
        [_noDataView addSubview:imageView];
        imageView.frameY = BDSpacing_Important_22 + ((isSigle == YES)?BDSpacing_Important_64:0);
        imageView.centerX = _noDataView.frameWidth/2.0f;
        imageView.userInteractionEnabled = YES;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = BDFont_Important_Font16;
        label.textColor = BDColors_Important_GrayB;
        if ([[self noDataStr] length] > 0) {
            label.text = [self noDataStr];
        }
        else
        {
            label.text = @"暂无数据";
        }
        [label sizeToFit];
        [_noDataView addSubview:label];
        label.frameY = imageView.frameBottom + BDSpacing_Important_10;
        label.centerX = imageView.centerX;
        
        UITapGestureRecognizer *sender = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNoDataView:)];
        [imageView addGestureRecognizer:sender];
        self.tableView.backgroundView = _noDataView;
    }
    _noDataView.frameSize = _tableView.bounds.size;
}

-(void)tapNoDataView:(UIGestureRecognizer *)sender
{
//    _tableView.bounces = NO;
//    [_tableView.mj_header beginRefreshing];
}
-(void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setBase_leftTopBtnsAction:(BaseRightTopBtn)block withTitle:(id )base_leftTopBtn, ...NS_REQUIRES_NIL_TERMINATION
{
    if (_rightTopBtns == nil)
    {
        _rightTopBtns = [[NSMutableArray alloc]init];
    }
    else
    {
        [_rightTopBtns removeAllObjects];
    }
    id otherString;
    va_list args;
    
    if (base_leftTopBtn)
    {
        [_rightTopBtns addObject:base_leftTopBtn];
        va_start(args, base_leftTopBtn);
        while ((otherString = va_arg(args, id)))
        {
            [_rightTopBtns addObject:otherString];
        }
        va_end(args);
    }
    [self creatTopRightBar:block];
}
-(void)creatTopRightBar:(BaseRightTopBtn )block
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_rightTopBtns.count];
    for (int i = 0; i < _rightTopBtns.count; i++) {
        id ob = [_rightTopBtns objectAtIndex:i];
        
        NSString *strNomer;
//        NSString *strSelect;
        UIImage *imageNomer;
//        UIImage *imageSelect;
        UIView *btnView;
        if ([ob isKindOfClass:[NSString class]]) {
            strNomer = [NSString stringWithFormat:@"%@",ob];
        }
        else if ([ob isKindOfClass:[NSDictionary class]])
        {
            if ([[ob objectForKey:BaseRightTopKeyNomer]isKindOfClass:[NSString class]]) {
                strNomer = [NSString stringWithFormat:@"%@",[ob objectForKey:BaseRightTopKeyNomer]];
            }
            else
            {
                imageNomer = ob;
            }
            
//            if ([[ob objectForKey:BaseRightTopKeySelect]isKindOfClass:[NSString class]]) {
//                strSelect = [NSString stringWithFormat:@"%@",[ob objectForKey:BaseRightTopKeySelect]];
//            }
//            else
//            {
//                imageSelect = ob;
//            }
        }
        else if ([ob isKindOfClass:[UIImage class]])
        {
            imageNomer = ob;
        }
        else if ([ob isKindOfClass:[UIView class]])
        {
            btnView = ob;
        }
        UIBarButtonItem *btn;
        if (btnView != nil) {
            btn = [[UIBarButtonItem alloc]initWithCustomView:btnView];
        }
        else
        {
            if (strNomer.length == 0) {
                btn = [[UIBarButtonItem alloc]initWithImage:imageNomer style:UIBarButtonItemStylePlain target:self action:@selector(touchTopBtn:)];
                //            [btn setBackgroundImage:imageSelect forState:UIControlStateSelected style:UIBarButtonItemStylePlain barMetrics:UIBarMetricsDefault];
            }
            else
            {
                btn = [[UIBarButtonItem alloc]initWithTitle:strNomer style:UIBarButtonItemStylePlain target:self action:@selector(touchTopBtn:)];
            }
        }
        btn.tag = i;
        [arr addObject:btn];
    }
    self.navigationItem.rightBarButtonItems = arr;
    _baseRightTopBtnBlock = block;
}
-(void)touchTopBtn:(UIBarButtonItem *)sender
{
    _baseRightTopBtnBlock(sender);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_subContainer]) {
        CGPoint contentOffset = scrollView.contentOffset;
        int index = floor(contentOffset.x / [UIScreen mainScreen].bounds.size.width);
        index = index < 0 ? 0 : index;
        [self scrollForPage:index];
    }
}




-(void)refresh
{
    __weak __typeof(self) weakSelfs = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.tableIsRefresh = YES;
        [weakSelfs mjLoad:YES];
    }];
}
-(void)loadMore
{
    __weak __typeof(self) weakSelfs = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.tableIsRefresh = NO;
        [weakSelfs mjLoad:NO];
    }];
}

-(NSString *)noDataStr
{
    return @"";
}
@end
