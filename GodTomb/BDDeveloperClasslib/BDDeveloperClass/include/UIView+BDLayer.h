//
//  UIView+BDLayer.h
//  pluto
//
//  Created by TTgg on 16/6/28.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,BDLineType) {
    BDViewLineWithPosition_Top = 0,
    BDViewLineWithPosition_Bottom = 1,
    BDViewLineWithPosition_All = 2,
    BDViewLineWithPosition_Null = 3
};
typedef NS_ENUM(NSInteger,BDCornerType) {
    BDViewCornerType_TopLeft = 0,
    BDViewCornerType_TopRight = 1,
    BDViewCornerType_Top = 2,
    
    BDViewCornerType_BottomLeft = 3,
    BDViewCornerType_BottomRight = 4,
    BDViewCornerType_Bottom = 5,
    
    
    BDViewCornerType_NoTopLeft = 6,
    BDViewCornerType_NoTopRight = 7,
    
    BDViewCornerType_NoBottomLeft = 8,
    BDViewCornerType_NoBottomRight = 9,
    BDViewCornerType_Left = 10,
    BDViewCornerType_Right = 11,
    
    BDViewCornerType_AllCorners = 12
};
@interface UIView (BDLayer)
//加线
-(void)bd_addViewLineColor:(UIColor *)color;
-(void)bd_addViewSigleLineColor:(UIColor *)color withType:(BDLineType)type;
-(void)bd_addViewSigleLineColor:(UIColor *)color withType:(BDLineType)type withEdgeInsets:(UIEdgeInsets)edg;

-(void)bd_changeCornerWithType:(BDCornerType)type withAngle:(CGSize)angle withLineColor:(UIColor *)color withLineType:(BDLineType)linetype withEdgeInsets:(UIEdgeInsets)edg;
@end
