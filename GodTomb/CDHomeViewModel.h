//
//  CDHomeViewModel.h
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDHomeViewModel : NSObject
@property (nonatomic, strong) NSString     *imageName;
@property (nonatomic, strong) NSString     *titleName;
@property (nonatomic, strong) NSString     *chapterCount;
@property (nonatomic, strong) NSString     *completeTime;
@property (nonatomic, strong) NSString     *breif;
@property (nonatomic, strong) NSString     *status;
@property (nonatomic, strong) NSString     *content;
@property (nonatomic, strong) NSString     *introduceUrl;
@property (nonatomic, strong) NSString     *numberOfWords;
@property (nonatomic, strong) NSString     *pictureUrl;
@property (nonatomic, strong) NSString     *originalUrl;
@property (nonatomic, strong) Book         *book;


+ (instancetype)getModelWithDiction:(NSDictionary *)dic;
+ (NSMutableArray *)bookData;
+ (void)bookDataController:(UIViewController *)controller book:(Book *)book;
@end
