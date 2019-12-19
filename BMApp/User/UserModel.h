//
//  UserModel.h
//  Tourism
//
//  Created by Mac on 2019/3/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *userId;//用户ID
@property (nonatomic, copy) NSString *phoneNo;//用户ID
@property (nonatomic, copy) NSString *wechatOpenid;//用户ID
@property (nonatomic, copy) NSString *qqOpenid;//用户ID
@property (nonatomic, copy) NSString *nickName;//用户ID
@property (nonatomic, copy) NSString *picUrl;//用户ID
@property (nonatomic, copy) NSString *gender;//用户ID
@property (nonatomic, copy) NSString *descriptionn;//用户ID
@property (nonatomic, copy) NSString *qrcodeUrl;//用户ID
@property (nonatomic, copy) NSString *status;//用户ID
@property (nonatomic, copy) NSString *isPush;//用户ID
@property (nonatomic, copy) NSString *registerTime;//用户ID

@property (nonatomic, copy) NSString *createCount;//用户ID
@property (nonatomic, copy) NSString *joinCount;//用户ID
@property (nonatomic, copy) NSString *bindingCount;//用户ID
@property (nonatomic, copy) NSString *genderStr;//用户ID
@property (nonatomic, copy) NSString *statusStr;//用户ID

//id: 用户id,
//phoneNo: 手机号,
//wechatOpenid: 微信openid,
//qqOpenid: qq登录凭证,
//nickName: 昵称,
//picUrl: 头像地址,
//gender: 性别(1 男 2 女),
//description: 简介,
//qrcodeUrl: 二维码地址,
//status: 状态,
//isPush: 推送设置(0 不接受,1 接受),
//registerTime: 注册时间,


//createCount: 创建群数量,
//joinCount: 加入群数量,
//bindingCount: 绑定设备数量,
//genderStr: 性别,
//statusStr: 状态
@end

NS_ASSUME_NONNULL_END
