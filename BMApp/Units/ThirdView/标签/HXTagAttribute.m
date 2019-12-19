//
//  HXTagAttribute.m
//  HXTagsView https://github.com/huangxuan518/HXTagsView
//  博客地址 http://blog.libuqing.com/
//  Created by Love on 16/6/30.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXTagAttribute.h"

@implementation HXTagAttribute

- (instancetype)init
{
    self = [super init];
    if (self) {
        int r = arc4random() % 255;
        int g = arc4random() % 255;
        int b = arc4random() % 255;
        
        UIColor *normalColor = [UIColor colorWithRed:b/255.0 green:r/255.0 blue:g/255.0 alpha:1.0];
        UIColor *normalBackgroundColor = [UIColor whiteColor];
        UIColor *selectedBackgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        
        _borderWidth = 1.0f;
        _borderColor = [UIColor getUsualColorWithString:@"#AEAEAE"];
        _cornerRadius = 3.0f;
        _normalBackgroundColor = [UIColor whiteColor];
        _selectedBackgroundColor = [UIColor getUsualColorWithString:@"#FF5445"];
        _titleSize = 12.f;
        _textColor = [UIColor getUsualColorWithString:@"#666666"];
        _selectColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _keyColor = [UIColor redColor];
        _tagSpace = 18;
    }
    return self;
}

@end
