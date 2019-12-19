//
//  CommonMethod.m
//  BMApp
//
//  Created by Mac on 2019/5/23.
//  Copyright © 2019 BM. All rights reserved.
//

#import "CommonMethod.h"

#import "BMNavigationController.h"
#import "LLTabBar.h"

#import "BMLoginViewController.h"
#import "BMMapViewController.h"
#import "BMMssageTitlesViewController.h"
#import "BMMineViewController.h"

@implementation CommonMethod

+(NSString *)timeStampConversionNSString:(NSString *)timeStamp Format:(NSString *)format
{
    if ([timeStamp isKindOfClass:[NSString class]]) {
        
        if (timeStamp.length == 0) {
            
            return @"";
        }
    }
    if (!timeStamp) {
        
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    @"yyyy-MM-dd HH:mm:ss"
    if ([format isEqualToString:@""]) {
        
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSString *)dateConversionTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr Format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([format isEqualToString:@""]) {
        
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    [dateFormatter setDateFormat:format];
    //    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

#pragma mark - 将某个时间转化成 时间戳

+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}


+ (NSString *)checkTheDate:(NSString *)string{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string longLongValue]/1000];
    
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    NSString *strDiff = nil;
    
    if(isToday) {
        strDiff= [CommonMethod timeStampConversionNSString:string Format:@"HH:mm"];
    }else{
        
        //        if ([CommonMethod isThisYearString:date]) {
        //
        //            strDiff= [CommonMethod timeStampConversionNSString:string Format:@"MM-dd HH:mm"];
        //        }else{
        
        strDiff= [CommonMethod timeStampConversionNSString:string Format:@"yyyy-MM-dd HH:mm"];
        //        }
    }
    return strDiff;
}
+ (NSString *)HourAndMinuteWithDate:(NSString *)dateStr{
    
    NSInteger i = [self timeSwitchTimestamp:dateStr andFormatter:@"yyyy-MM-dd HH:mm:ss"] * 1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSString * format = @"HH:mm";
    [formatter setDateFormat:format];
    dateStr= [CommonMethod timeStampConversionNSString:[NSString stringWithFormat:@"%ld",i] Format:format];
    return dateStr;
    
}


+ (BOOL)isThisYearString:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    
    return nowCmps.year == selfCmps.year;
    
}
+ (BOOL)isYesterdayDate:(NSDate *)date
{
    
    // 得到当前时间（世界标准时间 UTC/GMT）
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:date toDate:nowDate options:0];
    return cmps.day == 1;
}
+ (BOOL)isTheDayBeforeYesterday:(NSDate *)date
{
    
    // 得到当前时间（世界标准时间 UTC/GMT）
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:date toDate:nowDate options:0];
    return cmps.day == 2;
}
+ (NSString *)checkDate:(NSString *)string{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSString * format = @"";
    [formatter setDateFormat:format];
    NSString *dateStr = @"";
    if (![self isThisYearString:date]) {
        
        //不是今年
        format = @"yyyy-MM-dd HH:mm";
        dateStr= [CommonMethod timeStampConversionNSString:string Format:format];
        
    }else{
        
        //今天
        if ([[NSCalendar currentCalendar] isDateInToday:date]) {
            //今天
            format = @"HH:mm";
            dateStr= [CommonMethod timeStampConversionNSString:string Format:format];
        }else{
            
            if ([self isYesterdayDate:date]) {
                
                //昨天
                format = @"HH:mm";
                                dateStr = [NSString stringWithFormat:@"昨天%@",[CommonMethod timeStampConversionNSString:string Format:format]];
//                dateStr = [NSString stringWithFormat:@"昨天"];
            }else if ([self isTheDayBeforeYesterday:date]) {
                
                //前天
                format = @"HH:mm";
                                dateStr = [NSString stringWithFormat:@"前天%@",[CommonMethod timeStampConversionNSString:string Format:format]];
//                dateStr = [NSString stringWithFormat:@"前天"];
            }else{
                
                
                format = @"MM-dd HH:mm";
                dateStr= [CommonMethod timeStampConversionNSString:string Format:format];
            }
            
        }
    }
    
    return dateStr;
}
+ (NSString *)dateToHands:(NSString *)str{
    
    NSInteger i = [self timeSwitchTimestamp:str andFormatter:@"yyyy-MM-dd HH:mm:ss"] * 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%ld",i] longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSString * format = @"";
    [formatter setDateFormat:format];
    NSString *dateStr = @"";
    if (![self isThisYearString:date]) {
        
        //不是今年
        format = @"yyyy-MM-dd HH:mm";
        dateStr= [CommonMethod timeStampConversionNSString:[NSString stringWithFormat:@"%ld",i] Format:format];
        
    }else{
        
        //今天
        if ([[NSCalendar currentCalendar] isDateInToday:date]) {
            //今天
            format = @"HH:mm";
            dateStr= @"今天";
        }else{
            
            if ([self isYesterdayDate:date]) {
                
                //昨天
                format = @"HH:mm";
//                dateStr = [NSString stringWithFormat:@"昨天%@",[CommonMethod timeStampConversionNSString:string Format:format]];
                                dateStr = [NSString stringWithFormat:@"昨天"];
            }else if ([self isTheDayBeforeYesterday:date]) {
                
                //前天
                format = @"HH:mm";
//                dateStr = [NSString stringWithFormat:@"前天%@",[CommonMethod timeStampConversionNSString:string Format:format]];
                                dateStr = [NSString stringWithFormat:@"前天"];
            }else{
                
                
                format = @"MM-dd";
                dateStr= [CommonMethod timeStampConversionNSString:[NSString stringWithFormat:@"%ld",i] Format:format];
            }
            
        }
    }
    
    return dateStr;
}
+ (NSString *)fontDate:(NSString *)str{
    
    NSInteger i = [self timeSwitchTimestamp:str andFormatter:@"yyyy-MM-dd HH:mm:ss"] * 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%ld",i] longLongValue]/1000];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSString * time = [NSString stringWithFormat:@"%ld",[[CommonMethod dateConversionTimeStamp:lastDay] integerValue] * 1000];
    NSString * last = [CommonMethod timeStampConversionNSString:time Format:@"yyyy-MM-dd HH:mm:ss"];
    return last;
}
+ (NSString *)nextDate:(NSString *)str{
    
    NSInteger i = [self timeSwitchTimestamp:str andFormatter:@"yyyy-MM-dd HH:mm:ss"] * 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%ld",i] longLongValue]/1000];
    NSDate *lastDay = [NSDate dateWithTimeInterval:+24*60*60 sinceDate:date];//前一天
    NSString * time = [NSString stringWithFormat:@"%ld",[[CommonMethod dateConversionTimeStamp:lastDay] integerValue] * 1000];
    NSString * last = [CommonMethod timeStampConversionNSString:time Format:@"yyyy-MM-dd HH:mm:ss"];
    return last;
}

+ (NSString *)configDateWithDate:(NSString *)dateStr{
    
//    NSString * date = [self dateConversionTimeStamp:[NSString stringWithFormat:@"%ld",]];
    NSInteger i = [self timeSwitchTimestamp:dateStr andFormatter:@"yyyy-MM-dd HH:mm:ss"] * 1000;
    return [self checkDate:[NSString stringWithFormat:@"%ld",i]];
}
+ (NSString *)configYear:(NSString *)string{
    
    NSInteger i = [self timeSwitchTimestamp:string andFormatter:@"yyyy-MM-dd HH:mm:ss"] * 1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSString * format = @"yyyy-MM-dd";
    [formatter setDateFormat:format];
    NSString *dateStr = @"";
    dateStr= [CommonMethod timeStampConversionNSString:[NSString stringWithFormat:@"%ld",i] Format:format];
    return dateStr;
}

+ (void)RefreshSetMj_footerHidden:(NSMutableArray *)sourceArr ScrollView:(UIScrollView *)scrollview{
    
    if (sourceArr.count == 0) {
        
        scrollview.mj_footer.hidden = YES;
    }else{
        
        scrollview.mj_footer.hidden = NO;
        if (sourceArr.count < [PageSize integerValue]) {
            
            [scrollview.mj_footer endRefreshingWithNoMoreData];
            scrollview.mj_footer.hidden = YES;
        }
    }
    
    
}



+ (void)LoadDataSetMj_footerHidden:(NSMutableArray *)sourceArr Page:(NSInteger)page ScrollView:(UIScrollView *)scrollview{
    
    if (sourceArr.count < page * [PageSize integerValue]) {
        
        [scrollview.mj_footer endRefreshingWithNoMoreData];
        scrollview.mj_footer.hidden = YES;
    }
}


+ (void)RefreshSetMj_footerHidden:(NSMutableArray *)sourceArr Size:(NSInteger)size ScrollView:(UIScrollView *)scrollview{
    
    scrollview.mj_footer.state = MJRefreshStateIdle;
    if (sourceArr.count == 0) {
        
        scrollview.mj_footer.hidden = YES;
    }else{
        
        scrollview.mj_footer.hidden = NO;
        if (sourceArr.count < size) {
            
            [scrollview.mj_footer endRefreshingWithNoMoreData];
        }
    }
    
    
}

+ (void)LoadDataSetMj_footerHidden:(NSMutableArray *)sourceArr Page:(NSInteger)page Size:(NSInteger)size ScrollView:(UIScrollView *)scrollview{
    
    if (sourceArr.count < page * size) {
        
        [scrollview.mj_footer endRefreshingWithNoMoreData];
    }
}


+ (NSString *)changeStringNum:(NSString *)str{
    
    NSUInteger tmpSize = [str integerValue];
    if (tmpSize >= 1000*1000*10) {
        str = [NSString stringWithFormat:@"%@999w",@""];
    }else if (tmpSize >= 10000) {
        str = [NSString stringWithFormat:@"%.1f万",tmpSize / 10000.f];
    }
    return str;
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        
        
        currentVC = rootVC;
    }
    
    return currentVC;
}



+ (UINavigationController *)currentNC
{
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getCurrentNCFrom:rootViewController];
}

//递归
+ (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNCFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNCFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNCFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNCFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}
+ (void)setupBaseUI{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[BMUserInfoManager sharedManager] isLoginIn]) {

        BMLoginViewController * login = [[BMLoginViewController alloc] init];
        BMNavigationController *loginVc =[[BMNavigationController alloc] initWithRootViewController:login];
        delegate.window.rootViewController = loginVc;
    }else{

        BMMapViewController * home = [[BMMapViewController alloc] init];
        BMNavigationController *homeViewController =[[BMNavigationController alloc] initWithRootViewController:home];

        BMNavigationController *communityViewController =[[BMNavigationController alloc] initWithRootViewController:[[BMMssageTitlesViewController alloc] init]];
        BMNavigationController *recommendViewController =[[BMNavigationController alloc] initWithRootViewController:[[BMMineViewController alloc] init]];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.viewControllers = @[homeViewController, communityViewController, recommendViewController];
        LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];

        tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"地图", kLLTabBarItemAttributeNormalImageName : @"home_ditu_n", kLLTabBarItemAttributeSelectedImageName : @"home_ditu_s", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                        @{kLLTabBarItemAttributeTitle : @"消息", kLLTabBarItemAttributeNormalImageName : @"home_message_n", kLLTabBarItemAttributeSelectedImageName : @"home_message_s", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                        @{kLLTabBarItemAttributeTitle : @"我的", kLLTabBarItemAttributeNormalImageName : @"home_my_n", kLLTabBarItemAttributeSelectedImageName : @"home_my_s", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];



        //        tabBar.delegate = self;

        [tabBarController.tabBar addSubview:tabBar];
        delegate.window.rootViewController = tabBarController;
    }
}

+ (NSString *)translationArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"HH:mm"];
    NSString * todayStr=[dateFormat stringFromDate:today];//将日期转换成字符串
    today=[ dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    //startTime格式为 02:22   expireTime格式为 12:44
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startStr EndTime:(NSString *)endStr{
    
    //获取当前时间
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,建议大写    HH 使用 24 小时制；hh 12小时制
    [dateFormat setDateFormat:@"yyyy:mm:HH:mm:ss"];
    NSString * todayStr=[dateFormat stringFromDate:today];//将日期转换成字符串
    today=[ dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    //start end 格式 "2016-05-18 9:00:00"
    NSDate *start = [dateFormat dateFromString:startStr];
    NSDate *expire = [dateFormat dateFromString:endStr];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

+ (NSAttributedString *)changeStrColorWithContent:(NSString *)content Str:(NSString *)str Color:(NSString *)color Font:(NSInteger)font{
    
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:content];
    //找出特定字符在整个字符串中的位置
    NSRange redRange = NSMakeRange([[contentStr string] rangeOfString:str].location, [[contentStr string] rangeOfString:str].length);
    //修改特定字符的颜色
    [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor getUsualColorWithString:color] range:redRange];
    //修改特定字符的字体大小
    [contentStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font] range:redRange];
    return contentStr;
}
+ (void)drawLineByImageView:(UIImageView *)imageView {
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor darkGrayColor].CGColor);
    
    
    CGFloat lengths[] = {5,2};//先画4个点再画2个点
    CGContextSetLineDash(line,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(line, 0.0, 2.0);    //开始画线
    CGContextAddLineToPoint(line,imageView.frame.size.width,2.0);
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    UIImage *image =   UIGraphicsGetImageFromCurrentImageContext();
    imageView.image = image;
}
#pragma mark 代理
- (void)tabBarDidSelectedRiseButton {
    
    
}
+ (NSString *)MineWeekDateToHans:(NSString *)date{
    
    if ([date isEqualToString:@"请选择"] || date.length == 0) {
        
        return date;
    }
    
    NSArray * dateArr = [date componentsSeparatedByString:@","];
    
    if (dateArr.count ==5 && [date containsString:@"1"] &&[date containsString:@"2"]&&[date containsString:@"3"]&&[date containsString:@"4"]&&[date containsString:@"5"]) {
        
        return @"工作日";
    }
    if (dateArr.count ==2 && [date containsString:@"6"] &&[date containsString:@"0"]) {
        
        return @"周末";
    }
    if (dateArr.count ==7 && [date containsString:@"1"] &&[date containsString:@"2"]&&[date containsString:@"3"]&&[date containsString:@"4"]&&[date containsString:@"5"]&& [date containsString:@"6"]&&[date containsString:@"0"]) {
        
        return @"每天";
    }
    
    NSString * I = @"";
    
    for (NSString * i in dateArr) {
        
        if ([i isEqualToString:@"0"]) {
            
            I = [NSString stringWithFormat:@"%@ %@",I,@"日"];
        }else{
            
            I = [NSString stringWithFormat:@"%@ %@",I,[self translationArabicNum:[i integerValue]]];
        }
 
    }
    
    return I;
}
@end

