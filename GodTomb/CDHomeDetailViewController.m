//
//  CDHomeDetailViewController.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDHomeDetailViewController.h"
#import "CDAuthorBaseInforViewController.h"
#import "CDHomeViewController.h"

@interface CDHomeDetailViewController ()<UIDocumentInteractionControllerDelegate, UIViewControllerPreviewingDelegate>
@property UIScrollView *backScrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CDHomeViewModel *model;
@end

@implementation CDHomeDetailViewController
- (instancetype)initWithModel:(CDHomeViewModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.titleName;
    self.view.backgroundColor = BDColors_Important_GrayD;
    // Do any additional setup after loading the view.
    [self createRightBar];
    [self createScrollView];
    [self createHeaderView];
}

- (void)createRightBar
{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"txt转发" style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    UIBarButtonItem *introduceBar = [[UIBarButtonItem alloc]initWithTitle:@"作品介绍" style:UIBarButtonItemStylePlain target:self action:@selector(instroduce:)];
    
    self.navigationItem.rightBarButtonItems = @[introduceBar,rightBar];
}

- (void)instroduce:(id)sender
{
    [CDMobclickEvent mobClickEventWithWorksWikipedia:self.model.titleName];
    [self toWebPage:self.model.introduceUrl];
}
- (void)share:(id)sender
{
    [CDMobclickEvent mobClickEventWithTxtForWarding:self.model.titleName];
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:self.model.titleName withExtension:@"txt"];
    UIDocumentInteractionController *controll = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    controll.delegate = self;
    controll.UTI = @"text/plain";
    [controll presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
}


- (void)createScrollView
{
    self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CDScreenWidth, CDScreenHeight)];
    [self.view addSubview:self.backScrollView];
}
- (void)createHeaderView
{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CDScreenWidth, 120)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:self.headerView];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 96, 128)];
    imageView.image = [UIImage imageNamed:self.model.imageName];
    [self.headerView addSubview:imageView];
    CGFloat imageLabelGap = 15;
    CGFloat labelLabelGap = 10;
    CGFloat maxLabelWidth = CDScreenWidth-20-20-CGRectGetWidth(imageView.frame)-imageLabelGap;
    
    UILabel *bookNameLabel = [BDAllocNewLabel allocNewLabelFontSize:18 textColor:BDColors_Important_BlueA];
    bookNameLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+imageLabelGap, CGRectGetMinY(imageView.frame), maxLabelWidth, 20);
    bookNameLabel.text = self.model.titleName;
    [bookNameLabel sizeToFit];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toBookController)];
    bookNameLabel.userInteractionEnabled = YES;
    [bookNameLabel addGestureRecognizer:tap];
    [self.headerView addSubview:bookNameLabel];
    
    UILabel *statusLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayA];
    statusLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+imageLabelGap, CGRectGetMaxY(bookNameLabel.frame)+labelLabelGap, maxLabelWidth, 10);
    statusLabel.text = [NSString stringWithFormat:@"状态：%@",self.model.status];
    [statusLabel sizeToFit];
    [self.headerView addSubview:statusLabel];
    
    UILabel *chapterLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayA];
    chapterLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+imageLabelGap, CGRectGetMaxY(statusLabel.frame)+labelLabelGap, maxLabelWidth, 10);
    chapterLabel.text = [NSString stringWithFormat:@"章节数：%@",self.model.chapterCount];
    [chapterLabel sizeToFit];
    [self.headerView addSubview:chapterLabel];
    
    UILabel *numberLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayA];
    numberLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+imageLabelGap, CGRectGetMaxY(chapterLabel.frame)+labelLabelGap, maxLabelWidth, 10);
    numberLabel.text = [NSString stringWithFormat:@"总字数：%@ 字",self.model.numberOfWords];
    [numberLabel sizeToFit];
    [self.headerView addSubview:numberLabel];
    
    UILabel *completeTimeLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayA];
    completeTimeLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+imageLabelGap, CGRectGetMaxY(numberLabel.frame)+labelLabelGap, maxLabelWidth, 10);
    completeTimeLabel.text = [NSString stringWithFormat:@"完结时间：%@",self.model.completeTime];
    [completeTimeLabel sizeToFit];
    [self.headerView addSubview:completeTimeLabel];
    
    UILabel *pictureLabel = [BDAllocNewLabel allocNewLabelFontSize:18 textColor:BDColors_Important_BlueA];
    pictureLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+imageLabelGap, CGRectGetMaxY(completeTimeLabel.frame)+labelLabelGap+10, maxLabelWidth, 10);
    pictureLabel.text = [NSString stringWithFormat:@"图册"];
    [pictureLabel sizeToFit];
    [self.headerView addSubview:pictureLabel];
    UITapGestureRecognizer *tapPicture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toPicture:)];
    [pictureLabel addGestureRecognizer:tapPicture];
    pictureLabel.userInteractionEnabled = YES;
    
    UILabel *tiebaLabel = [BDAllocNewLabel allocNewLabelFontSize:18 textColor:BDColors_Important_BlueA];
    tiebaLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+imageLabelGap, CGRectGetMaxY(pictureLabel.frame)+labelLabelGap+10, maxLabelWidth, 10);
    tiebaLabel.text = [NSString stringWithFormat:@"贴吧"];
    [tiebaLabel sizeToFit];
    [self.headerView addSubview:tiebaLabel];
    UITapGestureRecognizer *tapTieba = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toTieba:)];
    [tiebaLabel addGestureRecognizer:tapTieba];
    tiebaLabel.userInteractionEnabled = YES;
    
    CGRect oldRect = self.headerView.frame;
    oldRect.size.height = CGRectGetMaxY(tiebaLabel.frame)+labelLabelGap;
    self.headerView.frame = oldRect;
    
    
    UILabel *briefDefaultLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayA];
    briefDefaultLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerView.frame)+labelLabelGap, CDScreenWidth-40, 10);
    briefDefaultLabel.text = @"简介：";
    [briefDefaultLabel sizeToFit];
    [self.backScrollView addSubview:briefDefaultLabel];
    
    
    UILabel *briefLabel = [BDAllocNewLabel allocNewLabelFontSize:14 textColor:BDColors_Important_GrayA];
    briefLabel.frame = CGRectMake(20+10, CGRectGetMaxY(briefDefaultLabel.frame)+labelLabelGap, CDScreenWidth-50, 10);
    briefLabel.text = self.model.breif;
    [briefLabel sizeToFit];
    [self.backScrollView addSubview:briefLabel];
    
    if (CGRectGetMaxY(briefLabel.frame)+30 > CDScreenHeight) {
        self.backScrollView.contentSize = CGSizeMake(CDScreenWidth, CGRectGetMaxY(briefLabel.frame)+labelLabelGap);
    }
}

- (void)toPicture:(id)sender
{
    [CDMobclickEvent mobClickEventWithWorksPhotoAlbum:self.model.titleName];
    [self toWebPage:self.model.pictureUrl];
}

- (void)toTieba:(id)sender
{
    [CDMobclickEvent mobClickEventWithWorksWorksTieba:self.model.titleName];
    NSString *title = self.model.titleName;
    if ([title isEqualToString:@"完美世界"]) {
        title = @"完美世界小说";
    }
    NSString *url = [NSString stringWithFormat:@"http://tieba.baidu.com/f?kw=%@&fr=ala0&loc=rec",title];
    [self toWebPage:url];
}

- (void)toWebPage:(NSString *)url
{
    CDWebViewController *web = [[CDWebViewController alloc]initWithUrl:url];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)toBookController
{
    [CDMobclickEvent mobClickEventWithDetailWorksNameTap:self.model.titleName];
    [CDHomeViewModel bookDataController:self book:self.model.book];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"图册" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self toPicture:nil];
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"贴吧" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self toTieba:nil];
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"开始阅读" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self toBookController];
    }];
    
    return @[action1, action2, action3];
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
