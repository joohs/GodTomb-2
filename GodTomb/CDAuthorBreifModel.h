//
//  CDAuthorBreifModel.h
//  GodTomb
//
//  Created by xiangxiong on 2017/3/29.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDAuthorBreifModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *breif;
@property (nonatomic, strong) NSArray *baseInforArray;
@property (nonatomic, strong) NSArray *otherInforArray;

+ (NSArray *)spotLightArray;
@end
