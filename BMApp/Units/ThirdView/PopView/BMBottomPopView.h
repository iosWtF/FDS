//
//  BMBottomPopView.h
//  Tourism
//
//  Created by Mac on 2019/1/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMBottomPopView : UIView

/**
 从底部显示更多操作模式的按钮视图
 
 @param titleArray 标题名称
 @param imgNameArray 图片名称
 @param blockTapAction 点击返回事件(返回顺序:左->右,上->下, 0,1,2,3...)
 */
+ (void)showMoreWithTitle:(NSArray *)titleArray
             imgNameArray:(NSArray *)imgNameArray itemHeight:(CGFloat )itemHeight fontS:(CGFloat)fontS showCornerRadius:(BOOL)showCornerRadius
           blockTapAction:( void(^)(NSInteger index) )blockTapAction;


/**
 日期选择器
 */


+ (void)showDataSelectorWithDate:(NSString *)date Type:(NSString *)type BlockTapAction:( void(^)(NSString * date) )blockTapAction;

+ (void)showPeriodDateWithTitle:(NSString *)title BlockTapAction:( void(^)(NSString * date) )blockTapAction;

+ (void)showWeekDateBlockTapAction:(void(^)(NSString * date) )blockTapAction;
@end

NS_ASSUME_NONNULL_END

