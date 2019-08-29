//
//  CommonSettingsiew.m
//  BReader
//
//  Created by ruikye on 14-5-11.
//
//

#import "CommonSettingsiew.h"

@interface CommonSettingsiew ()
@property (nonatomic, strong) UIButton *customBgBtn;
@property (nonatomic, strong) UIButton *lightBtn;
@property (nonatomic, strong) UIButton *fontSizeBtn;
@property (nonatomic, strong) UIButton *colorBtn;
@end

@implementation CommonSettingsiew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width/4;
        CGFloat height = 42;
        CGFloat orginY = 3;
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        self.lightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, orginY, width, height)];
        [self.lightBtn setImage:[UIImage imageNamed:@"brigness"] forState:UIControlStateNormal];
        [self.lightBtn setTitle:@"屏幕亮度" forState:UIControlStateNormal];
        self.lightBtn.titleLabel.font = [UIFont systemFontOfSize:8.5];
        [self returnTopImageBottomTitleButton:self.lightBtn gap:6];
        
        self.fontSizeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lightBtn.frame), orginY, width, height)];
        [self.fontSizeBtn setImage:[UIImage imageNamed:@"fontsize"] forState:UIControlStateNormal];
        [self.fontSizeBtn setTitle:@"字体大小" forState:UIControlStateNormal];
        self.fontSizeBtn.titleLabel.font = [UIFont systemFontOfSize:8.5];
        [self returnTopImageBottomTitleButton:self.fontSizeBtn gap:6];
        
        self.colorBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fontSizeBtn.frame), orginY, width, height)];
        [self.colorBtn setImage:[UIImage imageNamed:@"fontcolor"] forState:UIControlStateNormal];
        [self.colorBtn setTitle:@"自定义颜色" forState:UIControlStateNormal];
        self.colorBtn.titleLabel.font = [UIFont systemFontOfSize:8.5];
        [self returnTopImageBottomTitleButton:self.colorBtn gap:6];
        
        self.customBgBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.colorBtn.frame), orginY, width, height)];
        [self.customBgBtn setImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
        [self.customBgBtn setTitle:@"自定义背景" forState:UIControlStateNormal];
        self.customBgBtn.titleLabel.font = [UIFont systemFontOfSize:8.5];
        [self returnTopImageBottomTitleButton:self.customBgBtn gap:6];
        
        [self addSubview:self.customBgBtn];
        [self addSubview:self.lightBtn];
        [self addSubview:self.fontSizeBtn];
        [self addSubview:self.colorBtn];
    }
    return self;
}

- (UIButton *)returnTopImageBottomTitleButton:(UIButton *)btn gap:(CGFloat)gap
{
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.bounds.size.height+gap/2 ,-btn.imageView.bounds.size.width, 0, 0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.bounds.size.height-gap/2, 0, 0, -btn.titleLabel.bounds.size.width)];
    return btn;
}

-(void)setTarget:(id)target customBgImage:(SEL)action1 changLight:(SEL)action2 changeFontSize:(SEL)action3 changeColor:(SEL)action4 {
    [self.customBgBtn addTarget:target action:action1 forControlEvents:UIControlEventTouchUpInside];
    [self.lightBtn addTarget:target action:action2 forControlEvents:UIControlEventTouchUpInside];
    [self.fontSizeBtn addTarget:target action:action3 forControlEvents:UIControlEventTouchUpInside];
    [self.colorBtn addTarget:target action:action4 forControlEvents:UIControlEventTouchUpInside];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
