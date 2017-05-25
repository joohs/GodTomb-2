//
//  CDUserDefaults.m
//  GodTomb
//
//  Created by 吴相雄 on 2017/4/13.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDUserDefaults.h"
static CDUserDefaults *instance;
static NSString *commonString = @"commonString";
@interface CDUserDefaults ()
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation CDUserDefaults
- (id)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CDUserDefaults alloc]init];
    });
    return instance;
}

- (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isChoiceCustom
{
    return [self.userDefaults boolForKey:[NSString stringWithFormat:@"%@_%@",commonString,@"isChoiceCustom"]];
}

- (void)setIsChoiceCustom:(BOOL)isChoiceCustom
{
    [self.userDefaults setBool:isChoiceCustom forKey:[NSString stringWithFormat:@"%@_%@",commonString,@"isChoiceCustom"]];
    [self synchronize];
}

- (UIImage *)selectBGImage
{
    NSData *data =  [self.userDefaults objectForKey:[NSString stringWithFormat:@"%@_%@",commonString,@"selectBGImage"]];
    data = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [UIImage imageWithData:data];
}

- (void)setSelectBGImage:(UIImage *)selectBGImage
{
    NSData *data = UIImagePNGRepresentation(selectBGImage);
    if (data == nil) {
        data = UIImageJPEGRepresentation(selectBGImage, 1.f);
    }
    data  = [NSKeyedArchiver archivedDataWithRootObject:data];
    [self.userDefaults setObject:data forKey:[NSString stringWithFormat:@"%@_%@",commonString,@"selectBGImage"]];
    [self synchronize];
}

- (BOOL)isNight
{
    return [self.userDefaults boolForKey:[NSString stringWithFormat:@"%@_%@",commonString,@"isNight"]];
}

- (void)setIsNight:(BOOL)isNight
{
    [self.userDefaults setBool:isNight forKey:[NSString stringWithFormat:@"%@_%@",commonString,@"isNight"]];
    [self synchronize];
}

- (NSInteger)fontSize
{
    return [self.userDefaults integerForKey:[NSString stringWithFormat:@"%@_%@",commonString,@"fontSize"]];
}

- (void)setFontSize:(NSInteger)fontSize
{
    [self.userDefaults setInteger:fontSize forKey:[NSString stringWithFormat:@"%@_%@",commonString,@"fontSize"]];
    [self synchronize];
}

- (NSString *)customColorString
{
    return [self.userDefaults stringForKey:[self returnKey:@"customColorString"]];
}

- (void)setCustomColorString:(NSString *)customColorString
{
    [self.userDefaults setValue:customColorString forKey:[self returnKey:@"customColorString"]];
    [self synchronize];
}


#pragma mark -
- (NSString *)returnKey:(NSString *)key
{
    return [NSString stringWithFormat:@"%@_%@",commonString,key];
}



@end
