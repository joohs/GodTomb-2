//
//  BDLabel.m
//  pluto
//
//  Created by xiangxiong on 16/10/8.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import "BDLabel.h"

@interface BDLabel ()
@property (nonatomic, strong) UIColor *defColor;
@end

@implementation BDLabel

@synthesize verticalAlignment = verticalAlignment_;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = VerticalAlignmentMiddle;
        self.canCopy = NO;
        [self attachTapHandler];
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

-(BOOL)canBecomeFirstResponder
{
    
    return YES;
    
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action==@selector(copys:))
    {
        return YES;
    }
    
    return NO;
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
    touch.minimumPressDuration = 0.5;
    [self addGestureRecognizer:touch];
}

//同上
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.canCopy = NO;
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
    if (!self.canCopy) {
        return ; 
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

        if (self.userInteractionEnabled) {
            [[UIMenuController sharedMenuController] setMenuItems:arr];
            [[UIMenuController sharedMenuController] setTargetRect:self.frame inView :self.superview];
            [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
            
            self.userInteractionEnabled=NO;
            
        }
    }
}

@end
