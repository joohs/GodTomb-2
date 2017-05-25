//
//  UICopyLabel.h
//  constraints
//
//  Created by TEST on 15/9/22.
//  Copyright (c) 2015年 Oubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICopyLabel : UILabel
@property (nonatomic, strong) UIColor *defColor;
@property (nonatomic, assign) BOOL enableCopy;
@property (nonatomic, assign) BOOL isOnlyCopy;
@end
