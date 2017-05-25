//
//  BDLabel.h
//  pluto
//
//  Created by xiangxiong on 16/10/8.
//  Copyright © 2016年 bertadata. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface BDLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;
@property BOOL canCopy;

@end
