//
//  PaperController.m
//  BReader
//
//  Created by ruikye on 14-4-2.
//
//

#import "PaperController.h"
#import "BookUtils.h"
#import "PageView.h"
#import "TypeSetter.h"
#import "ViewHelper.h"
#import "Resource.h"
#import "TitleBar.h"
#import "ToolBarView.h"
#import "ProgressSettingsView.h"
#import "CommonSettingsiew.h"
#import "LeftMenuView.h"
#import "CDCustomBgImageViewController.h"
#import "CDChangeFontSizeView.h"
#import "CDChangeColorView.h"
#import "CDChangeBrightnessView.h"

static CGRect MENU_RECT;
static bool insideMenuRect(float x, float y){
    return x>MENU_RECT.origin.x&&x<MENU_RECT.origin.x+MENU_RECT.size.width&&y>MENU_RECT.origin.y&&y<MENU_RECT.origin.y+MENU_RECT.size.height;
}

static float FONT_LEVEL[] = {10.0f, 12.0f, 14.0f, 16.0, 18.f};

static bool insideNextRect(float x, float y){
    return !(x<MENU_RECT.origin.x||(x>MENU_RECT.origin.x&&x<(MENU_RECT.origin.x+MENU_RECT.size.width)&&y<MENU_RECT.origin.y));
}

typedef enum {
    TOUCH_MENU,
    TOUCH_NEXT,
    TOUCH_PREV
}TOUCH_OPT;

@interface PaperController ()<CDCustomBgImageViewControllerDelegate, CDChangeColorViewDelegate, CDChangeFontSizeViewDelegate>
{
    PageView*               pageView;
    TypeSetter*             typeSetter;
    Book*                   book;
    int                     yOffset;
    CGRect                  mainRect;
    CGRect                  paperFrame;
    TOUCH_OPT               touchOperation;
    BookLoader*             loader;
    TitleBar*               titleBar;
    LeftMenuView*           menuView;
    ToolBarView*            toolBarView;
    ProgressSettingsView*   progSatusView;
    CommonSettingsiew*      settingsView;

    int                     status_font_level; //{0,1,2,3,4}
    CDUserDefaults*         userDefaults;
    
    BOOL                    isLoadingComplete;
}
@end

@implementation PaperController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        status_font_level = 2;
    }
    return self;
}

-(void) bindBook:(Book *)_book{
    book = _book;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    userDefaults = [CDUserDefaults shareInstance];
    int width       = self.view.frame.size.width;
    int height      = self.view.frame.size.height;

    MENU_RECT       = CGRectMake(width/3.0f, height/3.0f, width/3.0f, height/3.0f);
    mainRect        = [[UIScreen mainScreen] bounds];
    typeSetter      = [TypeSetter shareInstance];

    [typeSetter setFontColor:kUIColorFromRGB(userDefaults.isNight?0x777777:0x000000, 0.7)];
    [typeSetter setLineSpace:4.0f];
    [typeSetter setFontSize:FONT_LEVEL[status_font_level]];
    [typeSetter setMargin:MakeMargin(16, 8, 16, 8)];
    paperFrame  = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height);
    yOffset = 0;
    
    pageView = [[PageView alloc] initWithFrame:paperFrame];
    if (userDefaults.isChoiceCustom) {
        [self settingBgImage:userDefaults.selectBGImage];
    }else{
        [self changeBGImage];
    }
    [typeSetter setFontColor:[CDGeneralMethod colorWithHexString:([userDefaults.customColorString isKindOfClass:[NSString class]]?userDefaults.customColorString:@"0x303030")]];
    [typeSetter setFontSize:(userDefaults.fontSize == 0)?14:userDefaults.fontSize];

    [self.view addSubview:pageView];

    titleBar = [[TitleBar alloc] initWithFrame:CGRectMake(0, yOffset, self.view.frame.size.width, CDNavigationBarHeight)];
//    titleBar.layer.shadowOpacity    = 1;
//    titleBar.layer.shadowOffset     = CGSizeMake(0, 2);
//    titleBar.layer.shadowRadius     = 2;
//    titleBar.layer.shadowColor      = [UIColor blackColor].CGColor;

    UIButton* leftBtn = [[UIButton alloc] init];
    [leftBtn setImage:[UIImage imageNamed:@"BarLeftback"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn setTitle:@"  " forState:UIControlStateNormal];
    [leftBtn setTitleColor:kUIColorFromRGB(0xcccccc, 0.9) forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToBookShelf) forControlEvents:UIControlEventTouchUpInside];

    [titleBar addLeftOperationButton:leftBtn];
    [titleBar setBackgroundColor:kUIColorFromRGB(0x000000, 0.90)];
    [self.view addSubview:titleBar];
    [titleBar hiddingWithAnim:YES];

    toolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, paperFrame.size.height - 48 + yOffset - (CDHasBang ? 34 : 0), self.view.frame.size.width, 48 + (CDHasBang ? 34 : 0))];
    [toolBarView setBackgroundColor:kUIColorFromRGB(0x000000, 0.90)];
    [toolBarView setTarget:self
                   catalog:@selector(openCatalog)
              jumpProfress:@selector(jumpProgress)
                 nightMode:@selector(setNightMode)
                  settings:@selector(openSettings)];
    [self.view addSubview:toolBarView];
    [toolBarView hiddingWithAnim:YES];
    
    menuView = [[LeftMenuView alloc]initWithFrame:self.view.bounds];
    __weak typeof(self) weaklf = self;
    menuView.didSelectBlock = ^(Catalog *log){
        
        [weaklf jumpToTheCorrespondingInterface:log];
    };
    [self.view addSubview:menuView];
    [menuView hiddingWithAnim:YES];

    progSatusView   = [[ProgressSettingsView alloc] initWithFrame:CGRectMake(0, paperFrame.size.height+yOffset, self.view.frame.size.width, 72)];
    [progSatusView prevChapter:self sel:@selector(prevChapter:)];
    [progSatusView nextChapter:self sel:@selector(nextChapter:)];
    progSatusView.hidden = YES;
    [progSatusView setBackgroundColor:[UIColor blackColor]];

    settingsView    = [[CommonSettingsiew alloc] initWithFrame:CGRectMake(0, paperFrame.size.height + yOffset - 48 - (CDHasBang ? 34 : 0), self.view.frame.size.width, 48 + (CDHasBang ? 34 : 0))];
    settingsView.hidden = YES;
    [settingsView setBackgroundColor:[UIColor blackColor]];
    [settingsView setTarget:self customBgImage:@selector(customBgimage) changLight:@selector(changeLight) changeFontSize:@selector(changeFontSize) changeColor:@selector(changeColor)];
    // 加载书籍内容
    [self loadBookContent:nil];
    
}
//更新标题
- (void)updateBookTitle
{
    [progSatusView updateTitle:[loader catalogInfo].name];
    [titleBar setTitle:[loader catalogInfo].name];
}
//上一章
- (void)prevChapter:(UIButton *)btn
{
    [CDMobclickEvent mobClickEventWithProgressPreChapter];
    [pageView showPage:[loader prevChapter]];
    [self updateBookTitle];
}
//下一章
- (void)nextChapter:(UIButton *)btn
{
    [CDMobclickEvent mobClickEventWithProgressNextChapter];
    [pageView showPage:[loader nextChapter]];
    [self updateBookTitle];
}

// 加载书籍内容
-(void) loadBookContent:(Page *)page{
    [ViewHelper showProgress:self.view];
    isLoadingComplete = NO;
    CGRect rect = CGRectMake(0, CDStatusBarHeight + 10, CDScreenWidth, CDScreenHeight_Valid - CDStatusBarHeight);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [book readBookMark];
        loader = [[BookLoader alloc] initWithBook:book bookMark:book.mark];
        [loader buildCache:rect];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([page isKindOfClass:[Page class]]) {
                [pageView showPage:page];
            }else{
                [pageView showPage:[loader currPage]];
            }
            [ViewHelper hideProgress];
            isLoadingComplete = YES;
            [self updateBookTitle];
        });
    });
}

// 跳转到相对应的界面
-(void) jumpToTheCorrespondingInterface:(Catalog *)log{
    [CDMobclickEvent mobClickEventWithUseMenuSkipChapter];
    [self hideMenuBars];
    [pageView showPage:[loader jumpTo:log.position]];
}

// 显示指定的二级菜单
-(void) showSubSettingsView:(UIView*) view{
    [self.view addSubview:view];
    view.hidden = NO;
    int height = view.frame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0;
        view.frame = CGRectMake(0, paperFrame.size.height - height + yOffset, self.view.frame.size.width, height);
        view.alpha = 1;
    }completion:^(BOOL finished){
    }];
}

// 隐藏二级菜单
-(BOOL) hideAllSubSettingsViews{
    BOOL needHide = !progSatusView.hidden||!settingsView.hidden;

    if (needHide) {
        [UIView animateWithDuration:0.3 animations:^{
            if (!progSatusView.hidden) {
                progSatusView.alpha = 1;
                progSatusView.frame = CGRectMake(0, paperFrame.size.height+yOffset, self.view.frame.size.width, 64);
                progSatusView.alpha = 0;
            }

            if (!settingsView.hidden) {
                settingsView.alpha = 1;
                settingsView.frame = CGRectMake(0, paperFrame.size.height+yOffset, self.view.frame.size.width, 48);
                settingsView.alpha = 0;
            }
        } completion:^(BOOL finished){
            progSatusView.hidden = YES;
            settingsView.hidden = YES;
            [progSatusView removeFromSuperview];
            [settingsView removeFromSuperview];
        }];
    }

    return !needHide;
}

// 隐藏一级菜单
-(void) hideMenuBars{
    [titleBar hiddingWithAnim:YES];
    [toolBarView hiddingWithAnim:YES];
    [menuView hiddingWithAnim:YES];
}

// 显示一级菜单
-(void) showMenuBars{
    [titleBar showingWithAnim:YES];
    [toolBarView showingWithAnim:YES];
}

// 打开目录
-(void) openCatalog{
    [CDMobclickEvent mobClickEventWithMenu];
    NSMutableArray *mArr = [NSMutableArray array];
    NSInteger selectIndex = 0;
    int i = 0;
    for (Catalog *log in book.catalog) {
        [mArr addObject:log];
        if ([log isEqual:[loader catalogInfo]]) {
            selectIndex = i;
        }
        i++;
    }
    [menuView updateTableView:mArr selectIndex:selectIndex];
    [menuView showingWithAnim:YES];
}

// 跳转进度
-(void) jumpProgress{
    [CDMobclickEvent mobClickEventWithProgress];
    [self hideMenuBars];
    [self showSubSettingsView:progSatusView];
    [self updateBookTitle];
}

// 日·夜间模式设定
-(void) setNightMode{
    [CDMobclickEvent mobClickEventWithDayAndNight];
    userDefaults.isChoiceCustom = NO;
    userDefaults.isNight = !userDefaults.isNight;
    [self changeBGImage];
    userDefaults.customColorString = [CDGeneralMethod toHexStringByUIColorExistSymbol:[typeSetter getFontColor]];
    [self hideMenuBars];
}
- (void)changeBGImage
{
    if (userDefaults.isNight) {
        [typeSetter setFontColor:kUIColorFromRGB(0x777777, 0.7)];
        [pageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_night"]]];
    } else {
        [typeSetter setFontColor:kUIColorFromRGB(0x000000, 0.7)];
        [pageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"paper"]]];
    }
}
//自定义更换背景图片
- (void)settingBgImage:(UIImage *)image
{
    [CDMobclickEvent mobClickEventWithReplaceBackGround];
    userDefaults.selectBGImage = image;
    if (![image isKindOfClass:[UIImage class]]) {
        image = [UIImage imageNamed:@"paper"];
    }
    userDefaults.isChoiceCustom = YES;
    image = [CDGeneralMethod image:image byScalingToSize:pageView.frame.size];
    [pageView setBackgroundColor:[UIColor colorWithPatternImage:image]];
}

// 所有设置
-(void) openSettings{
    [CDMobclickEvent mobClickEventWithMore];
    [self hideMenuBars];
    [self showSubSettingsView:settingsView];
}
//自定义背景图片
- (void)customBgimage
{
    [CDMobclickEvent mobClickEventWithCustomBackGround];
    CDCustomBgImageViewController *bg = [[CDCustomBgImageViewController alloc]init];
    bg.delegate = self;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:bg];
    [self presentViewController:navi animated:YES completion:^{
        [self hideAllSubSettingsViews];
    }];
}
//自定义字体大小
- (void)changeFontSize
{
    [CDMobclickEvent mobClickEventWithFontSize];
    CDChangeFontSizeView *view = [[CDChangeFontSizeView alloc]initWithFrame:self.view.bounds fontSize:[typeSetter getFontSize]];
    view.delegate = self;
    [self.view addSubview:view];
    [self hideAllSubSettingsViews];
}

- (void)changeFontSize:(NSInteger)fontSize
{
    if (isLoadingComplete) {
        userDefaults.fontSize = fontSize;
        [typeSetter setFontSize:fontSize];
        [self loadBookContent:[loader currPage]];
    }
}
//调整屏幕亮度
- (void)changeLight
{
    [CDMobclickEvent mobClickEventWithScreenBrightness];
    CDChangeBrightnessView *view = [[CDChangeBrightnessView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    [self hideAllSubSettingsViews];
}
//改变字体颜色
- (void)changeColor
{
    [CDMobclickEvent mobClickEventWithCustomColor];
    CDChangeColorView *view = [[CDChangeColorView alloc]initWithFrame:self.view.bounds andColor:[typeSetter getFontColor]];
    view.delegate = self;
    [self.view addSubview:view];
    [self hideAllSubSettingsViews];
}

- (void)changeNovelColor:(UIColor *)color
{
    userDefaults.customColorString = [CDGeneralMethod toHexStringByUIColor:color];
    [typeSetter setFontColor:color];
    [pageView setNeedsDisplay];
}
// 回到书架
-(void) backToBookShelf{
    if ([self.navigationController.viewControllers count] == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        return ;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 自动保存书签
-(void) viewDidDisappear:(BOOL)animated{
    book.mark = [loader getBookMark];
    [book saveBookMark];
    // Sava status
    [super viewDidAppear:animated];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch previousLocationInView:self.view];

    if (insideMenuRect(loc.x, loc.y)) {
        touchOperation = TOUCH_MENU;
    } else if(insideNextRect(loc.x, loc.y)){
        touchOperation = TOUCH_NEXT;
    } else {
        touchOperation = TOUCH_PREV;
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL isHidden = titleBar.hidden;
    switch (touchOperation) {
        case TOUCH_MENU:{
            if ([self hideAllSubSettingsViews]) {
                if (isHidden) {
                    [self showMenuBars];
                } else{
                    [self hideMenuBars];
                }
            }

            break;
        }
        case TOUCH_NEXT:
            if ([self hideAllSubSettingsViews]) {
                if (!isHidden) {
                    [self hideMenuBars];
                } else {
                    [pageView showPage:[loader nextPage]];
                    [self updateBookTitle];
                }
            }
            break;
        case TOUCH_PREV:
            if ([self hideAllSubSettingsViews]) {
                if (!isHidden) {
                    [self hideMenuBars];
                } else {
                    [pageView showPage:[loader prevPage]];
                    [self updateBookTitle];
                }
            }
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
