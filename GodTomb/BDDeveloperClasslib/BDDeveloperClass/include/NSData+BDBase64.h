//
//  NSData+BDBase64.h
//  DeveloperTools
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BDBase64)
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
@end
