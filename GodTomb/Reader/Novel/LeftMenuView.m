//
//  LeftMenuView.m
//  GodTomb
//
//  Created by xiangxiong on 2017/4/5.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "LeftMenuView.h"


@interface LeftMenuView ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isHidden;
    UIView *headerView;
    NSInteger index;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) Catalog *selectcCatalog;
@end

@implementation LeftMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = frame;
        rect.origin.y = 64;
        rect.size.height -= 64;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.image = [UIImage imageNamed:@"paper"];
        [self addSubview:imageView];
        self.tableView = [[UITableView alloc]initWithFrame:rect];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.clipsToBounds = YES;
        [self addSubview:self.tableView];
        self.dataArray = [NSArray array];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self createHeaderView];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)createHeaderView
{
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CDScreenWidth, 64)];
    headerView.backgroundColor = [UIColor clearColor];
    UIButton* leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"BarLeftback"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToBookShelf) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:leftBtn];
    [self addSubview:headerView];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
    titleLabel.text = @"目录";
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(CDScreenWidth/2, 20+22);
    [self addSubview:titleLabel];
}

- (void)updateTableView:(NSMutableArray *)arr selectIndex:(NSInteger )selectIndex
{
    index = selectIndex;
    self.dataArray = [NSMutableArray arrayWithArray:arr];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Catalog *log = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = log.name;
    cell.textLabel.textColor = BDColors_Important_GrayA;
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.borderWidth = 0.0;
    cell.layer.borderColor = [UIColor clearColor].CGColor;
    if (index == indexPath.row) {
        cell.layer.borderColor = BDColors_Important_BlueA.CGColor;
        cell.layer.borderWidth = 0.5;
        cell.textLabel.textColor = BDColors_Important_BlueA;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Catalog *log = [self.dataArray objectAtIndex:indexPath.row];
    self.didSelectBlock(log);
}

- (void)backToBookShelf
{
    [self hiddingWithAnim:YES];
}

-(void) showingWithAnim:(BOOL)anim{
  
    [UIView beginAnimations:@"showingAnim_titlebar" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.frame = CGRectMake(0 ,0 ,CDScreenWidth ,CDScreenHeight);
//    self.tableView.frame = self.frame;
    [UIView commitAnimations];
    _isHidden = NO;
}

-(void) hiddingWithAnim:(BOOL)anim{
  
    [self setHidden:NO];
    [UIView beginAnimations:@"hiddingAnim_titlebar" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.frame = CGRectMake(0, 0, 0, self.frame.size.height);
//    self.tableView.frame = self.frame;
    [UIView commitAnimations];
    _isHidden = YES;
}

-(BOOL) isHidden{
    return _isHidden;
}

@end
