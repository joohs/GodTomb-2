//
//  CDUserDefaults.h
//  GodTomb
//
//  Created by 吴相雄 on 2017/4/13.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDUserDefaults : NSObject
+ (instancetype)shareInstance;
@property (nonatomic, assign) BOOL isChoiceCustom;
@property (nonatomic, strong) UIImage *selectBGImage;
@property (nonatomic, assign) BOOL isNight;
@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, strong) NSString *customColorString;
@end
