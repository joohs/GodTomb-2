
//
//  BDMakeImageBig.m
//  pluto
//
//  Created by TEST on 15/8/13.
//  Copyright (c) 2015年 bertadata. All rights reserved.
//

#import "BDMakeImageBig.h"

static CGRect oldframe;
@implementation BDMakeImageBig
+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;

    
    //创建一个全屏视图
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //获取原先图片的frame
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    //背景视图的一些操作
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0.5;
    //新建一个视图，大小是原先图片的frame
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    //将imageview添加到背景图中，在将背景图添加到window中。
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    //隐藏图片
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
@end
