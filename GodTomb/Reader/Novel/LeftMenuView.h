//
//  LeftMenuView.h
//  GodTomb
//
//  Created by xiangxiong on 2017/4/5.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LeftMenuViewDidSelectBlock)(Catalog *log);
@interface LeftMenuView : UIView
@property (nonatomic, strong) LeftMenuViewDidSelectBlock didSelectBlock;
-(void) showingWithAnim:(BOOL)anim;
-(void) hiddingWithAnim:(BOOL)anim;
- (void)updateTableView:(NSMutableArray *)arr selectIndex:(NSInteger )selectIndex;
@end
