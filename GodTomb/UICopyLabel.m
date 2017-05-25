//
//  UICopyLabel.m
//  constraints
//
//  Created by TEST on 15/9/22.
//  Copyright (c) 2015年 Oubo. All rights reserved.
//

#import "UICopyLabel.h"


@implementation UICopyLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BOOL)canBecomeFirstResponder
{
    
    return YES;
    
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action==@selector(copys:) || action==@selector(share:))
    {
        return YES;
    }

    return NO;
}

//针对于响应方法的实现
-(void)share:(id)sender
{
    NSLog(@"dayin self   %ld",(long)self.tag);  
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(void)copys:(id)sender
{

    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
    
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler
{

    self.userInteractionEnabled = YES;  //用户交互的总开关

    UILongPressGestureRecognizer *touch=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
    
    
}

//绑定事件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _enableCopy = YES;
        [self attachTapHandler];
        
    }
    return self;
}
//同上
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.enableCopy = YES;
    [self attachTapHandler];
}
-(void)menuWillHide:(NSNotification *)notification
{
    self.backgroundColor=_defColor;
//    self.textColor=_titleColor;
    self.userInteractionEnabled=YES;
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerDidHideMenuNotification
                                                  object:nil];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer
{
    if (self.enableCopy == NO)
    {
        return;
    }
    [self becomeFirstResponder];
    if (recognizer.state==UIGestureRecognizerStateBegan) {
        _defColor=self.backgroundColor;
//        _titleColor=self.textColor;
        self.backgroundColor=BDColors_Important_GrayE;
//        self.textColor=[UIColor whiteColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillHide:) name:UIMenuControllerWillHideMenuNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillHide:) name:UIMenuControllerDidHideMenuNotification object:nil];
        UIMenuItem *copy=[[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copys:)];
        NSArray *arr = @[copy];
        if (_isOnlyCopy) {
            arr = @[copy];
        }
        
        if (self.userInteractionEnabled) {
            [[UIMenuController sharedMenuController] setMenuItems:arr];
            [[UIMenuController sharedMenuController] setTargetRect:self.frame inView :self.superview];
            [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];

            self.userInteractionEnabled=NO;

        }
    }
}

@end

