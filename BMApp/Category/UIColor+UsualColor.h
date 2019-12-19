//
//  UIColor+UsualColor.h
//  BMApp
//
//  Created by Mac on 2018/11/27.
//  Copyright © 2018年 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UsualColor)

/**
 *  颜色值 # 转 成RGB的方法
 *
 *  @param colorString 颜色值
 *
 *  @return 可用color
 */
+ (UIColor *)getUsualColorWithString:(NSString *)colorString;

@end
