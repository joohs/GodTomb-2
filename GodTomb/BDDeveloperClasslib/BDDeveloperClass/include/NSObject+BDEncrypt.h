//
//  NSObject+BDEncrypt.h
//  DeveloperTools
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BDEncrypt)
+ (NSString *) encryptWithNumber:(long)number;

+ (NSString *) decryptWithString:(NSString *)string;
@end
