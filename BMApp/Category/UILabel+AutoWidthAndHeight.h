//
//  UILabel+AutoWidthAndHeight.h
//  BMApp
//
//  Created by Mac on 2018/11/27.
//  Copyright © 2018年 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoWidthAndHeight)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;
//两端对齐

- (void)textAlignmentLeftAndRight;

//指定Label以最后的冒号对齐的width两端对齐

- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth;
@end
