//
//  BDAlertView.h
//  pluto
//
//  Created by TTgg on 2016/11/7.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDAlertView;
@protocol BDAlertViewDelegate <NSObject>

@optional
-(void)bdAlertView:(BDAlertView *)alert itemTouch:(NSInteger)tag;
@end

typedef NS_ENUM(NSUInteger, BDAlertViewShowType)
{
    BDAlertViewShowType_String = 0,//
    BDAlertViewShowType_Custom = 1,//
    BDAlertViewShowType_Addition = 2,//
};
typedef void (^BDAlertViewSender)(NSInteger tag) ;
@interface BDAlertView : UIView
@property (nonatomic, weak) id<BDAlertViewDelegate>delegate;
@property (strong, nonatomic) BDAlertViewSender theSender;
-(instancetype)initWithTitle:(NSString *)str message:(NSAttributedString *)message delegate:(id)delegate othereButtons:(NSString *)buttons, ...;
-(instancetype)initWithTitle:(NSString *)str message:(NSAttributedString *)message delegate:(id)delegate singleButtons:(NSString *)buttons, ...;
-(instancetype)initWithTitle:(NSString *)str message:(NSAttributedString *)message delegate:(id)delegate allButtons:(NSString *)buttons, ...;

-(instancetype)initWithTitle:(NSString *)str customView:(UIView *)custom customFram:(CGRect)frame delegate:(id)delegate otherButtons:(NSString *)buttons, ...;
-(instancetype)initWithTitle:(NSString *)str customView:(UIView *)custom customFram:(CGRect)frame delegate:(id)delegate singleButtons:(NSString *)buttons, ...;
-(instancetype)initWithAddtionTitle:(NSString *)str customView:(UIView *)custom customFram:(CGRect)frame addtionView:(UIView *)addtionView addtionFrame:(CGRect )addtionFrame delegate:(id)delegate otherButtons:(NSString *)buttons, ...;
-(instancetype)initWithTitle:(NSString *)str customView:(UIView *)custom customFram:(CGRect)frame delegate:(id)delegate allButtons:(UIButton *)buttons, ...;
-(void)buttonsWithBlock:(BDAlertViewSender)sender;

-(void)customCancel:(NSString *)str withColor:(UIColor *)color;
-(void)customCertain:(NSString *)str withColor:(UIColor *)color;
-(void)show;
-(void)removeView;
-(void)customImageView;
@end
