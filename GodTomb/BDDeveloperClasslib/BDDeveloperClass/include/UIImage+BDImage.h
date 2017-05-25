//
//  UIImage+BDImage.h
//  DeveloperTools
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BDImage)
/*
 更改image颜色,适用于不是透明的部分
 */
-(UIImage *)bd_imageWithTintColor:(UIColor *)tintColor;
/*
 更改image大小
 */
+(UIImage *)bd_changeImage:(UIImage *)im withSize:(CGSize )size;
/*
 更改image上传方向
 */
+(UIImage *)bd_fixOrientation:(UIImage *)aImage ;
/*
 用颜色初始图片
 */
+(UIImage *)bd_imageFromColor:(UIColor *)color;
/*
 用于剪切图片
 */
+(UIImage *)bd_cutCenterImage:(UIImage *)image forW:(float)w forH:(float)h forX:(float)x forY:(float)y;
/*
 返回图片大小
 */
+(CGSize)bd_returnImageSize:(UIImage *)image;

/*
 用view做图
 */
+(UIImage *)bd_imageFromView:(UIView *)theView;
+(UIImage *)bd_imageFromScrollerView:(UIScrollView *)scrollView;
+(UIImage *)bd_imageFromScrollerView:(UIScrollView *)scrollView withImageSize:(CGSize)backImageSize;
/*
 用首文字做图(根据文字)
 */
+(UIImage *)bd_creatImageWithTittle:(NSString *)str withAttributesDic:(NSDictionary *)dic withBackColor:(UIColor *)backColor withSize:(CGSize)size;
/*
 添加水印
 @[@{@"image":image,@"pointY":@"111.0"}]
 */
+(UIImage *)bd_waterMarkImage:(UIImage *)backImage withWaterMark:(NSArray *)images;
/*
 获取主色调
 */
+(UIColor*)bd_getMasterColor:(UIImage*)image;
/*
 根据主色调，扩张图片
 color为nil是，根据主色调。
 */
+(UIImage *)bd_allAroundStretch:(CGSize)size andImage:(UIImage *)image andPoint:(CGPoint)point withColor:(UIColor *)color;
@end
