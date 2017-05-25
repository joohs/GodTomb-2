//
//  CDCustomBgImageViewController.m
//  localNotification
//
//  Created by xiangxiong on 2017/4/6.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDCustomBgImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CDCustomBgImageCollectionViewCell.h"
#import "BDMakeImageBig.h"

static NSString *const key = @"CDCustomBgImageViewController";
static NSString *const cellKey = @"CDCustomBgImageCollectionViewCell";
static CGFloat   const cellHeight = 164;

@interface CDCustomBgImageViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UIImagePickerController *imagePickerController;
    BOOL isDeleteStatu;
    NSUserDefaults *userDefault;
}
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSMutableArray *imageMarray;
@property (nonatomic, strong) NSMutableArray *imageStringMarray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CDCustomBgImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择背景图";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    userDefault = [NSUserDefaults standardUserDefaults];
    self.imageStringMarray = [userDefault objectForKey:key];
    self.imageStringMarray = [NSMutableArray arrayWithArray:self.imageStringMarray];
    if (self.imageStringMarray == nil) {
        self.imageStringMarray = [NSMutableArray array];
    }
    
    self.imageMarray = [NSMutableArray array];
    for (NSString *string in self.imageStringMarray) {
        NSString *imageString = [NSString stringWithFormat:@"%@%@",[self pathOfAvatar:@"image"],string];
        [self.imageMarray addObject:[UIImage imageWithContentsOfFile:imageString]];
    }
    [self createLeftBar];
    [self createRightBar];
    [self createCollectionView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [userDefault setObject:self.imageStringMarray forKey:key];
    [userDefault synchronize];
}

- (void)createLeftBar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BarLeftback"] style:UIBarButtonItemStyleDone target:self action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD dismiss];
    }];
}

- (void)createRightBar
{
    NSString *title = @"添加";
    if (isDeleteStatu && [self.imageStringMarray count]) {
        title = @"完成";
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(openPhoto)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(80, cellHeight);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CDCustomBgImageCollectionViewCell class] forCellWithReuseIdentifier:cellKey];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self showBackTitle];
}

- (void)showBackTitle
{
    if (self.label == nil) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width-40, 10)];
        self.label.numberOfLines = 0;
        self.label.textColor = BDColors_Important_GrayA;
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.text = @"添加图片作为背景图片\n长按进行删除操作";
        [self.label sizeToFit];
        self.label.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, ([UIScreen mainScreen].bounds.size.height-64)/2);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openPhoto)];
        self.label.userInteractionEnabled = YES;
        [self.label addGestureRecognizer:tap];
        [self.view addSubview:self.label];
    }
    if ([self.imageStringMarray count]) {
        [self.label removeFromSuperview];
        self.label = nil;
    }
}

- (void)openPhoto
{
    if (isDeleteStatu && [self.imageStringMarray count]) {
        isDeleteStatu = NO;
        [self createRightBar];
        [self.collectionView reloadData];
        return ;
    }
    isDeleteStatu = NO;
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if(author == ALAuthorizationStatusDenied || author == ALAuthorizationStatusRestricted){
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"相册权限" message:@"前往设置界面打开相册授权" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往设置", nil];
        [alter show];
        return;
    }
    // 跳转到相机或相册页面
    if (imagePickerController == nil) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
    }
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
    }];
    
    id  viewcont = self;
    
    while (viewcont != nil) {
        viewcont = [viewcont parentViewController];
        NSLog(@"========%@========\n",viewcont);
    }
}

#pragma Delegate method UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *data;
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1);
    }
    //保存
    
    [self performSelectorInBackground:@selector(storeFile:) withObject:data];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)storeFile:(NSData *)data
{
    NSFileManager *fmr = [NSFileManager defaultManager];

    NSString *imageString = [NSString stringWithFormat:@"%@%lu",[self pathOfAvatar:@"image"],(unsigned long)[self.imageStringMarray count]];
    
    [fmr createFileAtPath:imageString contents:data attributes:nil];
    
    NSString *string = [NSString stringWithFormat:@"%lu",(unsigned long)[self.imageStringMarray count]];
    [self.imageStringMarray addObject:string];
    [self.imageMarray addObject:[UIImage imageWithData:data]];
    [self showBackTitle];
    [self.collectionView reloadData];
}

- (NSString *)pathOfAvatar:(NSString *)userId
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path =  [path stringByAppendingPathComponent:@"avatar" ];
    if (![fileMgr fileExistsAtPath:path]) {
        [fileMgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    path =  [path stringByAppendingString:  [NSString stringWithFormat:@"/%@", userId]];
    return path;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageMarray count];
}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, cellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDCustomBgImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellKey forIndexPath:indexPath];
    [cell updateCellModel:[self.imageMarray objectAtIndex:indexPath.row]];
    [cell showDeleteItem:isDeleteStatu];
    [cell addTarget:self sel:@selector(willDeleteItem:) tag:indexPath.row];
    [cell addDeleteTarget:self sel:@selector(deleteItem:) tag:indexPath.row];
    [cell addSettingTarget:self sel:@selector(showSelectImage:) tag:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDCustomBgImageCollectionViewCell *cell = (CDCustomBgImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [BDMakeImageBig showImage:cell.imageView];
}

- (void)willDeleteItem:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        isDeleteStatu = !isDeleteStatu;
        [self createRightBar];
        [self.collectionView reloadData];
    }
}

- (void)deleteItem:(UIButton *)btn
{
    [self.imageMarray removeObjectAtIndex:btn.tag];
    [self.imageStringMarray removeObjectAtIndex:btn.tag];
    [self showBackTitle];
    [self createRightBar];
    [self.collectionView reloadData];
}

- (void)showSelectImage:(UIButton *)btn
{
    UIImage *image = [self.imageMarray objectAtIndex:btn.tag];
    if ([self.delegate respondsToSelector:@selector(settingBgImage:)]) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [SVProgressHUD show];
            [self.delegate settingBgImage:image];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissController];
            });
        });
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
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
