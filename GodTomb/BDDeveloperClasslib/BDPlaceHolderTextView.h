//
//  BDPlaceHolderTextView.h
//  pluto
//
//  Created by TTgg on 2016/12/29.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDPlaceHolderTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong)  UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
@end
