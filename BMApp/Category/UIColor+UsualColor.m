//
//  UIColor+UsualColor.m
//  BMApp
//
//  Created by Mac on 2018/11/27.
//  Copyright © 2018年 BM. All rights reserved.
//

#import "UIColor+UsualColor.h"

@implementation UIColor (UsualColor)

/**
 *  颜色值 # 转 成RGB的方法
 *
 *  @param colorString 颜色值
 *
 *  @return 可用color
 */
+ (UIColor *)getUsualColorWithString:(NSString *)colorString
{

    colorString = [colorString stringByReplacingCharactersInRange:[colorString rangeOfString:@"#"] withString:@"0x"];
    //    16进制字符串转成整形
    long colorLong = strtol([colorString cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    //    通过位与方法获取三色值
    int R = (colorLong & 0xFF0000)>>16;
    int G = (colorLong & 0x00FF00)>>8;
    int B = colorLong & 0x0000FF;
    //    string转color
    UIColor * wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return wordColor;
}

@end
