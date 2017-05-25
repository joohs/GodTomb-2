//
//  UIButton+BDButton.h
//  DeveloperTools
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BDButton)
//当控件自适应长宽小于添加间隙后的长宽，会自适应改变控件原有的长宽，如果计算控件size时，先改变内容，之后在取控件size
/*
 上图下文
 */
- (void)bd_CenterImageAndTitle:(float)spacing;
- (void)bd_CenterImageAndTitle;
/*
 上文下字
 */
- (void)bd_CenterImageAndTitleChange:(float)spacing;
/*
左文字右图
 */
- (void)bd_CenterChangeRImage:(float)spacing;

/*
 右文字左图
 */
- (void)bd_CenterChangeLImage:(float)spacing;



@end
