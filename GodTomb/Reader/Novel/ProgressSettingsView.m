//
//  ProgressSettingsView.m
//  BReader
//
//  Created by ruikye on 14-5-11.
//
//

#import "ProgressSettingsView.h"

static int ITEM_HEIGHT = 34;

@interface ProgressSettingsView ()
@property (nonatomic, strong) UILabel *chapaterLabel;
@property (nonatomic, strong) UIButton* prevChapater;
@property (nonatomic, strong) UIButton* nextChapater;
@end

@implementation ProgressSettingsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        self.prevChapater = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 48, ITEM_HEIGHT)];
        [self.prevChapater setTitle:@"上一章" forState:UIControlStateNormal];
        [self.prevChapater.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.prevChapater setTitleColor:kUIColorFromRGB(0x5599aa, 1) forState:UIControlStateHighlighted];
        [self.prevChapater setTitleColor:kUIColorFromRGB(0xaaaaaa, 0.9) forState:UIControlStateNormal];
        self.prevChapater.layer.borderWidth = 0.8;
        self.prevChapater.layer.borderColor = kUIColorFromRGB(0xaaaaaa, 0.5).CGColor;
        self.prevChapater.layer.cornerRadius = 2;
        [self addSubview:self.prevChapater];

        self.chapaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.prevChapater.frame)+15, 0, self.frame.size.width-(48+15+15)*2, ITEM_HEIGHT)];
        [self.chapaterLabel setFont:[UIFont systemFontOfSize:14]];
        [self.chapaterLabel setTextColor:kUIColorFromRGB(0xaaaaaa, 0.9)];
        [self.chapaterLabel setText:@"fjasdflandfaldnfa;dsnfasdlifasn;fnsdfisan;i"];
        [self.chapaterLabel setTextAlignment:NSTextAlignmentCenter];
        [self.chapaterLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.chapaterLabel];

        self.nextChapater = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 15 - 48, 0, 48, ITEM_HEIGHT)];
        [self.nextChapater setTitle:@"下一章" forState:UIControlStateNormal];
        [self.nextChapater.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.nextChapater setTitleColor:kUIColorFromRGB(0x5555aa, 0.9) forState:UIControlStateHighlighted];
        [self.nextChapater setTitleColor:kUIColorFromRGB(0xaaaaaa, 0.9) forState:UIControlStateNormal];
        self.nextChapater.layer.borderWidth = 0.8;
        self.nextChapater.layer.borderColor = kUIColorFromRGB(0xaaaaaa, 0.5).CGColor;
        self.nextChapater.layer.cornerRadius = 2;
        [self addSubview:self.nextChapater];
        
        self.prevChapater.center = CGPointMake(self.prevChapater.center.x, self.frame.size.height/2);
        self.nextChapater.center = CGPointMake(self.nextChapater.center.x, self.frame.size.height/2);
        self.chapaterLabel.center = CGPointMake(self.chapaterLabel.center.x, self.frame.size.height/2);

//        UIButton* prevPage = [[UIButton alloc] initWithFrame:CGRectMake(space_x, frame.size.height - space_y - ITEM_HEIGHT, 16, ITEM_HEIGHT)];
//        [prevPage setTitle:@"<" forState:UIControlStateNormal];
//        [prevPage.titleLabel setFont:[UIFont systemFontOfSize:12]];
//        [prevPage setTitleColor:kUIColorFromRGB(0x5599aa, 1) forState:UIControlStateHighlighted];
//        [prevPage setTitleColor:kUIColorFromRGB(0xaaaaaa, 0.9) forState:UIControlStateNormal];
//        prevPage.layer.borderWidth = 0.8;
//        prevPage.layer.borderColor = kUIColorFromRGB(0xaaaaaa, 0.5).CGColor;
//        prevPage.layer.cornerRadius = 2;
//        [self addSubview:prevPage];
//
//        UIButton* nextPage = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - space_x - 16, frame.size.height - space_y - ITEM_HEIGHT, 16, ITEM_HEIGHT)];
//        [nextPage setTitle:@">" forState:UIControlStateNormal];
//        [nextPage.titleLabel setFont:[UIFont systemFontOfSize:12]];
//        [nextPage setTitleColor:kUIColorFromRGB(0x5555aa, 0.9) forState:UIControlStateHighlighted];
//        [nextPage setTitleColor:kUIColorFromRGB(0xaaaaaa, 0.9) forState:UIControlStateNormal];
//        nextPage.layer.borderWidth = 0.8;
//        nextPage.layer.borderColor = kUIColorFromRGB(0xaaaaaa, 0.5).CGColor;
//        nextPage.layer.cornerRadius = 2;
//        [self addSubview:nextPage];

//        UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(space_x*2+16, frame.size.height-space_y-ITEM_HEIGHT, frame.size.width - 32-4*space_x, ITEM_HEIGHT)];
//
//        UIImage* image = [UIImage imageNamed:@"seek_bar_thumb"];
//        [slider setThumbImage:image forState:UIControlStateHighlighted];
//        [slider setThumbImage:image forState:UIControlStateNormal];
//
//        slider.minimumValue = 0;
//        slider.maximumValue = 100;
//
//        [self addSubview:slider];

//        self.layer.shadowOffset = CGSizeMake(0, -0.5);
//        self.layer.shadowOpacity = 1;
//        self.layer.shadowRadius = 1.5;
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
    }
    return self;
}

- (void)updateTitle:(NSString *)title
{
    self.chapaterLabel.text = title;
}

- (void)nextChapter:(id)target sel:(SEL)sel
{
    [self.nextChapater addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)prevChapter:(id)target sel:(SEL)sel
{
    [self.prevChapater addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
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
