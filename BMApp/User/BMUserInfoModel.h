//
//  BMUserInfoModel.h
//  Tourism
//
//  Created by Mac on 2019/3/15.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMUserInfoModel : NSObject

@property (nonatomic, copy) NSString *name;//用户昵称
@property(nonatomic, copy) NSString *headimg;//用户头像
@property(nonatomic, copy) NSString *background;//用户e景图
@property(nonatomic, copy) NSString *level;//用户等级
@property(nonatomic, copy) NSString *info;//用户个性签名
@property(nonatomic, copy) NSString *focus;//用户关注
@property(nonatomic, copy) NSString *fans;//用户粉丝
@property(nonatomic, copy) NSString *visitor;//用户访客
@property(nonatomic, copy) NSString *sex;//用户性别
@property(nonatomic, copy) NSString *birthday;//用户生日
@property(nonatomic, copy) NSString *city;//用户城市
@property(nonatomic, copy) NSString *order;//用户行程订单开关
@property(nonatomic, copy) NSString *notice;//用户系统通知开关
@property(nonatomic, copy) NSString *Friend;//用户添加好友开关
@property(nonatomic, copy) NSString *balance;//用户余额
@property(nonatomic, copy) NSString *phone;//用户手机号
@property(nonatomic, copy) NSString *authentication;//用户实名认证状态
@property(nonatomic, copy) NSString *email;// 0未绑定邮箱 1已绑定
@end

NS_ASSUME_NONNULL_END
