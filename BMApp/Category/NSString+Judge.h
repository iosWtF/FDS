//
//  NSString+Judge.h
//  Tourism
//
//  Created by Mac on 2019/3/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Judge)

//正则判断数字+字母
+(BOOL)JudgeTheillegalCharacter:(NSString *)content;
//正则判断手机号
+ (BOOL)checkPhone:(NSString *)phoneNumber;
//正则判断邮箱
+ (BOOL)checkEmail:(NSString *)email;
//正则判断身份证号
+ (BOOL)validateIdentityCard: (NSString *)idCard;
+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (BOOL)isNineKeyBoard:(NSString *)string;
//非法字符
+ (BOOL)hasIllegalCharacter:(NSString *)content;
+(BOOL)isEmpty:(NSString*)text;
@end

NS_ASSUME_NONNULL_END
