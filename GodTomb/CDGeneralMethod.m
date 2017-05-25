//
//  CDGeneralMethod.m
//  GodTomb
//
//  Created by xiangxiong on 2017/3/28.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "CDGeneralMethod.h"


@implementation CDGeneralMethod
+ (NSString *)stringForKey:(NSString *)key withDiction:(NSDictionary *)diction
{
    if (![diction isKindOfClass:[NSDictionary class]] ) {
        return @"";
    }
    else
    {
        return [diction stringForKeyCategory:key];
    }
}

+(NSString *)returnNullStr:(NSString *)str
{
    if (str == nil||str.length == 0||[str isEqualToString:@"<null>"]||[str isEqualToString:@"(null)"]) {
        return @"";
    }
    else
    {
        return str;
    }
}

+ (NSArray *)arrayForKey:(NSString *)key withDiction:(NSDictionary *)diction
{
    if (![diction isKindOfClass:[NSDictionary class]] ) {
        return @[];
    }
    else
    {
        return [diction arrayForKeyCategory:key];
    }
}

+ (NSDictionary *)dictionaryForKey:(NSString *)key withDiction:(NSDictionary *)diction
{
    if (![diction isKindOfClass:[NSDictionary class]] ) {
        return @{};
    }
    else
    {
        return [diction dictionaryForKeyCategory:key];
    }
}

//position - 需要先给一个button的宽度，否则除了默认的左图右字能用，其他展示都存在问题
+ (UIButton *)returnPositionButton:(UIButton *)btn contentPosition:(titleAndImagePosition )contentPosition  gap:(CGFloat )gap
{
    if (contentPosition == leftTitleRightImage) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.bounds.size.width-gap/2, 0, btn.imageView.bounds.size.width)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width+gap/2, 0, -btn.titleLabel.bounds.size.width)];
    }else if(contentPosition == topImageBottomTitle){
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.bounds.size.height+gap/2 ,-btn.imageView.bounds.size.width, 0, 0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.bounds.size.height-gap/2, 0, 0, -btn.titleLabel.bounds.size.width)];
    }else if(contentPosition == topTitleBottomImage){
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(-btn.imageView.bounds.size.height-gap/2 ,-btn.imageView.bounds.size.width, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(btn.titleLabel.bounds.size.height+gap/2, 0, 0, -btn.titleLabel.bounds.size.width)];
    }else{
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, gap/2, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -gap/2, 0, 0)];
    }
    return btn;
}

+ (NSURL *)returnUrlString:(NSString *)urlString
{
    if ([NSURL URLWithString:urlString] == nil) {
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)urlString,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
        return [NSURL URLWithString:encodedString];
    }
    return [NSURL URLWithString:urlString];
}

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}
#pragma mark - make HexString to DecimalString
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
//将颜色转化为16进制 注意转换出来的字符串不带＃号
+ (NSString *)toHexStringByUIColor:(UIColor*)color{
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    
    return [NSString stringWithFormat:@"%06x", rgb];
}

//将颜色转化为16进制，有＃号
+ (NSString *)toHexStringByUIColorExistSymbol:(UIColor *)color
{
    NSString *hexString = [CDGeneralMethod toHexStringByUIColor:color];
    return [NSString stringWithFormat:@"#%@",hexString];
}

// 16进制转10进制
+ (NSNumber *) numberHexString:(NSString *)aHexString
{
    // 为空,直接返回.
    if (nil == aHexString)
    {
        return nil;
    }
    
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    
    unsigned long long longlongValue;
    
    [scanner scanHexLongLong:&longlongValue];
    
    //将整数转换为NSNumber,存储到数组中,并返回.
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    
    return hexNumber;
}
@end
