//
//  CommonMethod.h
//  BMApp
//
//  Created by Mac on 2019/5/23.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonMethod : NSObject

//时间戳转字符串
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp Format:(NSString *)format;
//时间转时间戳
+(NSString *)dateConversionTimeStamp:(NSDate *)date ;
//字符串转时间
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr Format:(NSString *)format;
+ (NSString *)configDateWithDate:(NSString *)dateStr;
+ (NSString *)HourAndMinuteWithDate:(NSString *)dateStr;
//判断是否是今天
+ (NSString *)checkTheDate:(NSString *)string;
+ (NSString *)configYear:(NSString *)string;
+ (NSString *)configYearMonthDay:(NSString *)string;
+ (BOOL)isThisYearString:(NSDate *)date;
//直选日期显示
+ (NSString *)checkDate:(NSString *)date;

+ (NSString *)dateToHands:(NSString *)str;
+ (NSString *)fontDate:(NSString *)str;
+ (NSString *)nextDate:(NSString *)str;
+ (void)RefreshSetMj_footerHidden:(NSMutableArray *)sourceArr ScrollView:(UIScrollView *)scrollview;
+ (void)LoadDataSetMj_footerHidden:(NSMutableArray *)sourceArr Page:(NSInteger)page ScrollView:(UIScrollView *)scrollview;

+ (void)RefreshSetMj_footerHidden:(NSMutableArray *)sourceArr Size:(NSInteger)size ScrollView:(UIScrollView *)scrollview;
+ (void)LoadDataSetMj_footerHidden:(NSMutableArray *)sourceArr Page:(NSInteger)page Size:(NSInteger)size ScrollView:(UIScrollView *)scrollview;

+ (NSString *)changeStringNum:(NSString *)str;


+ (void)pushThirdCouponWithType:(NSString *)type SellerId:(NSString *)sellerId ActivityId:(NSString *)activityId;
//获取当前导航控制器
+ (UINavigationController *)currentNC;

+ (UIViewController *)getCurrentVC;

+ (void)setupBaseUI;

+ (NSString *)translationArabicNum:(NSInteger)arabicNum;

+ (NSAttributedString *)changeStrColorWithContent:(NSString *)content Str:(NSString *)str Color:(NSString *)color Font:(NSInteger)font;

//当前时间是否在时间段内 (忽略年月日)
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime;
//当前时间是否在时间段内 (完整时间)
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startStr EndTime:(NSString *)endStr;
+ (void)drawLineByImageView:(UIImageView *)imageView;


+ (NSString *)MineWeekDateToHans:(NSString *)date;


@end

NS_ASSUME_NONNULL_END

