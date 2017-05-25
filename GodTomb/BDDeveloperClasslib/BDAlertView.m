//
//  BDAlertView.m
//  pluto
//
//  Created by TTgg on 2016/11/7.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import "BDAlertView.h"
#import "UIView+BDLayer.h"

#define textsHide @"textHide_AlertView"
#define textsUnHide @"textUnHide_AlertView"

@interface BDAlertView ()
{
    UIImageView *_backImageVeiw;
    UIView *_backView;
    UIScrollView *_backScrollView;
    UIView *_midView;
    UIView *_bottomVeiw;
    UIView *_additionView;
    UILabel *_titleLabel;
    UITextView *_messageLabel;
    CGSize _bottomViewSize;
    CGFloat _backViewWidth;
    NSString *_titleStr;
    NSAttributedString *_message;
    UIView *_custom;
    CGRect _customFrame;
    CGRect _addtionFrame;
    NSMutableArray *_subButtons;
    UIImageView *_customBackGroundImageView;
    
    
    UIButton *_defaultCancel;
    UIButton *_defaultCertain;
    
    BOOL buttonInCenter;
    UITapGestureRecognizer *_touchTap;
    
}
@end
@implementation BDAlertView
-(instancetype)initWithTitle:(NSString *)str message:(NSAttributedString *)message delegate:(id)delegate othereButtons:(NSString *)buttons, ...NS_REQUIRES_NIL_TERMINATION
{
    _backViewWidth = CDScreenWidth - BDSpacing_Important_30*2;
    _titleStr = str;
    _message = message;
    self.delegate = delegate;
    [self creatDefaultButton];
     buttonInCenter = NO;
    [self creatBottomViewIsAll:NO andButtons:buttons, nil];
    return [self initWithType:0 withDelegate:delegate];
}
-(instancetype)initWithTitle:(NSString *)str message:(NSAttributedString *)message delegate:(id)delegate singleButtons:(NSString *)buttons, ...NS_REQUIRES_NIL_TERMINATION
{
    _backViewWidth = CDScreenWidth - BDSpacing_Important_30*2;
    _titleStr = str;
    _message = message;
    self.delegate = delegate;
    buttonInCenter = YES;
    [self creatSingleButton];
    [self creatBottomViewIsAll:NO andButtons:buttons, nil];
    
    return [self initWithType:0 withDelegate:delegate];
}
-(instancetype)initWithTitle:(NSString *)str message:(NSAttributedString *)message delegate:(id)delegate allButtons:(NSString *)buttons, ...NS_REQUIRES_NIL_TERMINATION
{
    _backViewWidth = CDScreenWidth - BDSpacing_Important_30*2;
    _titleStr = str;
    _message = message;
    self.delegate = delegate;
     buttonInCenter = NO;
    [self creatBottomViewIsAll:YES andButtons:buttons, nil];
    return [self initWithType:0 withDelegate:delegate];
}
-(instancetype)initWithTitle:(NSString *)str customView:(UIView *)custom customFram:(CGRect)frame delegate:(id)delegate otherButtons:(NSString *)buttons, ...NS_REQUIRES_NIL_TERMINATION
{
    _backViewWidth = CDScreenWidth - BDSpacing_Important_30*2;
    _titleStr = str;
    _custom = custom;
    _customFrame = frame;
    self.delegate = delegate;
    [self creatDefaultButton];
     buttonInCenter = NO;
    [self creatBottomViewIsAll:NO andButtons:buttons, nil];
    return [self initWithType:1 withDelegate:delegate];
}
-(instancetype)initWithTitle:(NSString *)str customView:(UIView *)custom customFram:(CGRect)frame delegate:(id)delegate allButtons:(UIButton *)buttons, ...NS_REQUIRES_NIL_TERMINATION
{
    _backViewWidth = CDScreenWidth - BDSpacing_Important_30*2;
    _titleStr = str;
    _custom = custom;
    _customFrame = frame;
    self.delegate = delegate;
     buttonInCenter = NO;
    [self creatBottomViewIsAll:YES andButtons:buttons, nil];
    return [self initWithType:1 withDelegate:delegate];
}
-(instancetype)initWithTitle:(NSString *)str customView:(UIView *)custom customFram:(CGRect)frame delegate:(id)delegate singleButtons:(NSString *)buttons, ...
{
    _backViewWidth = CDScreenWidth - BDSpacing_Important_30*2;
    _titleStr = str;
    _custom = custom;
    _customFrame = frame;
    self.delegate = delegate;
    buttonInCenter = YES;
    [self creatBottomViewIsAll:YES andButtons:buttons, nil];
    return [self initWithType:1 withDelegate:delegate];

}
//存在底部的广告
-(instancetype)initWithAddtionTitle:(NSString *)str customView:(UIView *)custom customFram:(CGRect)frame addtionView:(UIView *)addtionView addtionFrame:(CGRect )addtionFrame delegate:(id)delegate otherButtons:(NSString *)buttons, ...NS_REQUIRES_NIL_TERMINATION
{
    _backViewWidth = CDScreenWidth - BDSpacing_Important_30*2;
    _addtionFrame = addtionFrame;
    _additionView = addtionView;
    _titleStr = str;
    _custom = custom;
    _customFrame = frame;
    self.delegate = delegate;
    [self creatDefaultButton];
    buttonInCenter = NO;
    [self creatBottomViewIsAll:NO andButtons:buttons, nil];
    return [self initWithType:2 withDelegate:delegate];
}
-(instancetype)initWithType:(BDAlertViewShowType)type withDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.tag = 1211;
        self.frame = CGRectMake(0, 0, CDScreenWidth, SCREEN_HEIGHT);
        _backImageVeiw = [[UIImageView alloc]initWithFrame:self.frame];
        _backImageVeiw.userInteractionEnabled = YES;
        _backImageVeiw.alpha = 0;
        UIImage *image = [UIImage imageNamed:@"blackpoint"];
        _backImageVeiw.image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [self addSubview:_backImageVeiw];

        _backView = [[UIView alloc]initWithFrame:CGRectZero];
        _backView.frameX = BDSpacing_Important_30;
        _backView.frameWidth = _backViewWidth;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = BDViewCornerRadius_Important_2;
        _backView.backgroundColor = BDColors_Important_WhiteA;
        [_backImageVeiw addSubview:_backView];
        
        if ([NSString bd_returnNullStr:_titleStr].length > 0)
        {
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            _titleLabel.frameSize = BDViewSize_Important_AlertTitle;
            _titleLabel.textColor = BDColors_Important_GrayA;
            _titleLabel.font = BDFont_Important_Font18;
            _titleLabel.numberOfLines = 0;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            [_titleLabel bd_addViewSigleLineColor:BDColors_Important_GrayE withType:1];
            _titleLabel.text = _titleStr;
            [_backView addSubview:_titleLabel];
        }
        
        
        _bottomVeiw.frameWidth = _backViewWidth;
        if (type == 0) {
            _midView = [[UIView alloc]initWithFrame:CGRectZero];
            _messageLabel = [[UITextView alloc]initWithFrame:CGRectZero];
            _messageLabel.editable = NO;
            _messageLabel.frame = CGRectMake(15, 0, _backViewWidth-30, 10);
//            _messageLabel.font = BDFont_Important_Font14;
            _messageLabel.textColor = BDColors_Important_GrayB;
            
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:_message];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:BDSpacing_Important_10];
            [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [att length])];
            [att addAttribute:NSFontAttributeName value:BDFont_Important_Font14 range:NSMakeRange(0, att.length)];
            
            [_messageLabel setAttributedText:att];
            _messageLabel.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
            [_messageLabel sizeToFit];
            [_midView addSubview:_messageLabel];
            _midView.frameHeight = _messageLabel.frameHeight+BDSpacing_Important_15*2;
            _messageLabel.centerX = _backViewWidth/2.0f;
            _messageLabel.centerY = _midView.frameHeight/2.0f;
        }
        else if(type == 1)
        {
            _midView = [[UIView alloc]initWithFrame:CGRectZero];
            [_midView addSubview:_custom];
            
            _midView.frameHeight = BDSpacing_Important_15 * 2 + _customFrame.size.height;
        }
        else
        {
            _midView = [[UIView alloc]initWithFrame:CGRectZero];
            [_midView addSubview:_custom];
            _midView.frameHeight = _customFrame.size.height;
            _midView.frameWidth = _backViewWidth;

            if (_additionView != nil) {
                [_backView addSubview:_additionView];
                _additionView.frameHeight = _addtionFrame.size.height;
                _additionView.frameWidth = _backViewWidth;
            }
        }
        _midView.frameWidth = _backViewWidth;
        
        [_backView addSubview:_midView];
        CGFloat height = _titleLabel.frameHeight;
        if ([_titleStr isEqualToString:@""] || ![_titleStr isKindOfClass:[NSString class]]) {
            height = 0;
        }
        _midView.frameY = height;
        [_backView addSubview:_bottomVeiw];
        _bottomVeiw.frameY = _midView.frameBottom;
        _additionView.frameY =  _bottomVeiw.frameBottom;
        _backView.frameHeight = height + _midView.frameHeight + _bottomVeiw.frameHeight + _additionView.frameHeight;
        _backView.centerY = SCREEN_HEIGHT /2.0f;
        _backView.centerX = SCREEN_WIDTH /2.0f;
        if (buttonInCenter) {
            _defaultCertain.center = CGPointMake(_backViewWidth/2, _defaultCertain.center.y);
        }
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        if (_custom) {
            [self addTextsNotification:_custom];
        }
        
        
        if (delegate != nil) {
            self.delegate = delegate;
        }
    }
    return self;
}
-(void)customImageView
{
    if (_customBackGroundImageView == nil) {
        _customBackGroundImageView = [[UIImageView alloc]init];
        _customBackGroundImageView.frameSize = _backView.frameSize;
        _customBackGroundImageView.frameOrigin = CGPointMake(0, 0);
        [_backView insertSubview:_customBackGroundImageView atIndex:0];
        UIImage *image = [UIImage imageNamed:@"homeToast"];
        [_customBackGroundImageView setImage:image];
        
    }
}
-(void)creatDefaultButton
{
    CGSize buttonSize = BDViewSize_Important_Button1Size((_backViewWidth - BDSpacing_Important_15*3)/2.0f);
    _defaultCertain = [UIButton buttonWithType:UIButtonTypeCustom];
    _defaultCertain.frameSize = buttonSize;
    _defaultCertain.backgroundColor = BDColors_Important_BlueA;
    _defaultCertain.titleLabel.font = BDFont_Important_Font16;
    [_defaultCertain setTitleColor:BDColors_Important_WhiteA forState:UIControlStateNormal];
    [_defaultCertain setTitle:@"确定" forState:UIControlStateNormal];
    
    _defaultCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _defaultCancel.frameSize = buttonSize;
    _defaultCancel.backgroundColor = BDColors_Important_GrayA;
    _defaultCancel.titleLabel.font = BDFont_Important_Font16;
    [_defaultCancel setTitleColor:BDColors_Important_WhiteA forState:UIControlStateNormal];
    [_defaultCancel setTitle:@"取消" forState:UIControlStateNormal];
}

-(void)creatSingleButton
{
    CGSize buttonSize = BDViewSize_Important_Button1Size((_backViewWidth - BDSpacing_Important_15*3)/2.0f);
    _defaultCertain = [UIButton buttonWithType:UIButtonTypeCustom];
    _defaultCertain.frameSize = buttonSize;
    _defaultCertain.backgroundColor = BDColors_Important_BlueA;
    _defaultCertain.titleLabel.font = BDFont_Important_Font16;
    [_defaultCertain setTitleColor:BDColors_Important_WhiteA forState:UIControlStateNormal];
    [_defaultCertain setTitle:@"确定" forState:UIControlStateNormal];
}

-(void)creatBottomViewIsAll:(BOOL)isall andButtons:(id)buttons, ...NS_REQUIRES_NIL_TERMINATION
{
    if (_subButtons == nil)
    {
        _subButtons = [[NSMutableArray alloc]init];
    }
    else
    {
        [_subButtons removeAllObjects];
    }
    NSMutableArray *sub = [[NSMutableArray alloc]init];
    id otherString;
    va_list args;
    if (buttons != nil)
    {
        [sub addObject:buttons];
        va_start(args, buttons);
        while ((otherString = va_arg(args, id)))
        {
            [sub addObject:otherString];
        }
        va_end(args);

    }
    [_subButtons addObjectsFromArray:sub];
    if (buttonInCenter == YES)
    {
//        [_subButtons addObject:_defaultCertain];
        [_defaultCertain setTitle:[sub lastObject] forState:UIControlStateNormal];
    }
    else
    {
        if (isall == NO)
        {
            if (_subButtons.count == 0)
            {
                [_subButtons addObject:_defaultCancel];
                [_subButtons addObject:_defaultCertain];
            }
            else
            {
                [_subButtons insertObject:_defaultCertain atIndex:0];
                [_subButtons insertObject:_defaultCancel atIndex:0];
            }
        }
    }
    
    [self creatBottomViewUI];
}
-(void)creatBottomViewUI
{
    _bottomVeiw = [[UIView alloc]initWithFrame:CGRectZero];
    CGSize buttonSize;
    if (_subButtons.count > 2)
    {
        buttonSize = BDViewSize_Important_Button1Size((_backViewWidth - BDSpacing_Important_15*4)/3.0f);
        
    }
    else if (_subButtons.count == 1)
    {
        buttonSize = BDViewSize_Important_Button1Size((_backViewWidth - BDSpacing_Important_15*2));
    }
    else
    {
        buttonSize = BDViewSize_Important_Button1Size((_backViewWidth - BDSpacing_Important_15*3)/2.0f);
    }
    CGFloat x = BDSpacing_Important_15;
    CGFloat y = 0;
    for (int i = 0; i < _subButtons.count; i++) {
        UIButton *btn = [self creatButton:_subButtons[i] withSize:buttonSize];
        y = (i/3)*(btn.frameHeight+BDSpacing_Important_10);
        btn.frameOrigin = CGPointMake(x, y);
        x = btn.frameRight + BDSpacing_Important_15;
        [_bottomVeiw addSubview:btn];
        if (i == _subButtons.count - 1) {
            _bottomVeiw.frameHeight = btn.frameBottom + BDSpacing_Important_15;
        }
        [btn addTarget:self action:@selector(touchBottomView:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
    }
}
-(UIButton *)creatButton:(id)button withSize:(CGSize)size
{
    UIButton *newView;
    NSString *newStr;
    UIImage  *newImage;
    if ([button isKindOfClass:[NSString class]]) {
        newStr = [NSString stringWithFormat:@"%@",button];
    }
    else if ([button isKindOfClass:[UIImage class]])
    {
        newImage = button;
    }
    else if ([button isKindOfClass:[UIButton class]])
    {
        newView = button;
    }
    if (newView == nil) {
        newView = [UIButton buttonWithType:UIButtonTypeCustom];
        if (newStr.length > 0) {
            newView.backgroundColor = BDColors_Important_BlueA;
            [newView setTitleColor:BDColors_Important_WhiteA forState:UIControlStateNormal];
            [newView setTitle:newStr forState:UIControlStateNormal];
        }
        else
        {
            [newView setImage:newImage forState:UIControlStateNormal];
        }
    }
    newView.frameSize = size;
    newView.layer.masksToBounds = YES;
    newView.layer.cornerRadius = BDViewCornerRadius_Important_2;
    return newView;
}
-(void)touchBottomView:(UIButton *)sender
{
    if (self.theSender != nil) {
        self.theSender(sender.tag);
    }
    else
    {
//        if (sender.tag != 0) {
            if ([self.delegate respondsToSelector:@selector(bdAlertView:itemTouch:)]) {
                [self.delegate bdAlertView:self itemTouch:sender.tag];
            }
//    }
    }
    [self removeView];
}

-(void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        _backImageVeiw.alpha = 1;
    }];
}
//可以使用viewWithTag来移除当前视图
-(void)removeView
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _backImageVeiw.alpha = 0;
        [weakSelf resignNotification];
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

-(void)customCertain:(NSString *)str withColor:(UIColor *)color
{
    if (_defaultCertain) {
        [_defaultCertain setTitle:str forState:UIControlStateNormal];
        if (color != nil) {
            _defaultCertain.backgroundColor = color;
        }
    }
}
-(void)customCancel:(NSString *)str withColor:(UIColor *)color
{
    if (_defaultCancel) {
        [_defaultCancel setTitle:str forState:UIControlStateNormal];
        if (color != nil) {
            _defaultCancel.backgroundColor = color;
        }
//#warning mark - 语音验证
//        if (![str isEqualToString:@"取消"] && ![str isEqualToString:@"短信验证"]) {
//            _defaultCancel.backgroundColor = BDColors_Important_BlueA;
//        }
//        else
//        {
//            _defaultCancel.backgroundColor = BDColors_Important_GrayA;
//        }
    }
}
-(void)buttonsWithBlock:(BDAlertViewSender)sender
{
    self.theSender = sender;
}
-(void)addTextsNotification:(UIView *)view
{
    if ([self getAllProperties:view] == YES) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        if (_touchTap == nil) {
            _touchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackView:)];
            [_backImageVeiw addGestureRecognizer:_touchTap];
        }
    }
    
}
-(void)resignNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardShow:(NSNotification *)note {
    CGRect keyBoardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY = keyBoardRect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        if (_backView.frameBottom + deltaY > SCREEN_HEIGHT) {
            _backView.transform = CGAffineTransformMakeTranslation(0, -(_backView.frameBottom-SCREEN_HEIGHT+deltaY));
        }
    } completion:^(BOOL finished) {
        _touchTap.enabled = YES;
    }];
}

-(void)keyboardHide:(NSNotification *)note {
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _backView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _touchTap.enabled = NO;
    }];
}
- (BOOL)getAllProperties:(UIView *)ob
{
    for (UIView *view in ob.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            return YES;
        }
        if ([view isKindOfClass:[UITextView class]]) {
            return YES;
        }
    }
    
    return NO;
}
-(void)tapBackView:(UIGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        for (UIView *view in _custom.subviews) {
            if ([view isKindOfClass:[UITextField class]] && [view isFirstResponder] == YES) {
                [view resignFirstResponder];
            }
            if ([view isKindOfClass:[UITextView class]] && [view isFirstResponder] == YES) {
                [view resignFirstResponder];
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
