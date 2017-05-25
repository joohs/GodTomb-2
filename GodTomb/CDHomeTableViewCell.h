//
//  CDHomeTableViewCell.h
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDHomeTableViewCell : UITableViewCell
- (void)updateCellModel:(NSDictionary *)dic;
- (void)addTarget:(id)target tag:(NSInteger)tag sel:(SEL)sel;
@end
