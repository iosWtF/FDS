//
//  BMHttpsMethod.h
//  Tourism
//
//  Created by Mac on 2019/3/4.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetWorkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMHttpsMethod : NSObject

+ (BMHttpsMethod *)httpMethodManager;


#pragma mark 接口声明

- (void)sharePlanWithUserid:(NSString *)userid OrderId:(NSString *)orderId Fid:(NSString *)fid ToGetResult:(void (^)(id data))complete;

#pragma mark ======  上传图片  ======

/**
 上传图片

 @param img 图片数组
 @param complete 返回值
 */
- (void)fileUploadFileWithImgArr:(NSArray *)img ToGetResult:(void (^)(id data))complete;

- (void)fileUploadFilesWithImgArr:(NSArray *)img ToGetResult:(void (^)(id data))complete;

#pragma mark ======  获取群组设备列表  ======

/**
 获取群组设备列表

 @param clusterId 群组id
 @param complete 返回值
 */
- (void)deviceDeviceListWithClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  足迹/轨迹  ======

/**
 足迹/轨迹

 @param date 日期
 @param deviceId 设备id
 @param complete 返回值
 */
- (void)positionGetListWithDate:(NSString *)date DeviceId:(NSString *)deviceId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  安全消息列表  ======

/**
 安全消息列表

 @param pageNow 当前页
 @param size 大小
 @param userid 用户id
 @param complete 返回值
 */
- (void)messagePageWithPageNow:(NSString *)pageNow Size:(NSString *)size userid:(NSString *)userid ToGetResult:(void (^)(id data))complete;

#pragma mark ======  查看安全消息详情  ======

/**
 查看安全消息详情

 @param Id 消息id
 @param complete 返回值
 */
- (void)messageGetWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete;

#pragma mark ======  开启/关闭紧急状态  ======


/**
 开启/关闭紧急状态

 @param deviceId 设备id
 @param status 状态(1开启 0 关闭)
 @param complete 返回值
 */
- (void)deviceOutburstWithDeviceId:(NSString *)deviceId Status:(NSString *)status ToGetResult:(void (^)(id data))complete;

#pragma mark ======  获取验证码  ======

/**
 获取验证码

 @param phoneNo 手机号
 @param type 类型(1 注册 2 登录)
 @param complete 返回值
 */
- (void)userGetCheckCodeWithPhoneNo:(NSString *)phoneNo Type:(NSString *)type ToGetResult:(void (^)(id data))complete;

#pragma mark ======  登录注册  ======

/**
 登录注册

 @param phoneNo 手机号
 @param checkCode 短信验证码
 @param qqOpenid qq唯一码
 @param wechatOpenid 微信唯一码
 @param complete 返回值
 */
- (void)userLoginWithPhoneNo:(NSString *)phoneNo CheckCode:(NSString *)checkCode QqOpenid:(NSString *)qqOpenid WechatOpenid:(NSString *)wechatOpenid NickName:(NSString *)nickName PicUrl:(NSString *)picUrl Gender:(NSString *)gender ToGetResult:(void (^)(id data))complete;

#pragma mark ======  获取首页信息  ======

/**
 获取首页信息

 @param Id 用户id
 @param complete 返回值
 */
- (void)userFrontPageWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete;

#pragma mark ======  群组管理  ======

/**
 群组管理

 @param userId 用户id
 @param complete 返回值
 */
- (void)clusterGetClusterListWithUserId:(NSString *)userId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  创建群组  ======

/**
 创建群组

 @param userId 用户id
 @param name 群组名称
 @param complete 返回值
 */
- (void)clusterCreateClusterWithUserId:(NSString *)userId Name:(NSString *)name ToGetResult:(void (^)(id data))complete;


#pragma mark ======  获取群组信息  ======

/**
 获取群组信息

 @param userId 用户id
 @param clusterId 群组id
 @param complete 返回值
 */
- (void)clusterGetClusterInfoWithUserId:(NSString *)userId ClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  查看成员信息  ======

/**
 查看成员信息

 @param Id 用户id
 @param complete 返回值
 */
- (void)userGetUserDetailByIdWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete;

#pragma mark ======  修改群组名称  ======

/**
 修改群组名称

 @param Id 群组id
 @param name 名称
 @param complete 返回值
 */
- (void)clusterUpdateWithId:(NSString *)Id Name:(NSString *)name ToGetResult:(void (^)(id data))complete;

#pragma mark ======  获取围栏列表  ======

/**
 获取围栏列表

 @param clusterId 群组id
 @param complete 返回值
 */
- (void)fenceGetFenceListWithClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  添加围栏  ======

/**
 添加围栏

 @param clusterId 群组id
 @param name 围栏名称
 @param position 围栏中心点位置名称
 @param longitude 经度
 @param latitude 纬度
 @param radius 半径
 @param complete 返回值
 */
- (void)fenceSaveWithClusterId:(NSString *)clusterId Name:(NSString *)name Position:(NSString *)position Longitude:(NSString *)longitude Latitude:(NSString *)latitude Radius:(NSString *)radius ToGetResult:(void (^)(id data))complete;

#pragma mark ======  查看围栏  ======

/**
 查看围栏

 @param Id 围栏id
 @param complete 返回值
 */
- (void)fenceGetWithClusterId:(NSString *)Id ToGetResult:(void (^)(id data))complete;

#pragma mark ======  删除围栏  ======

/**
 删除围栏

 @param Id 围栏id
 @param complete 返回值
 */
- (void)fenceDeleteWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete;

#pragma mark ======  获取群组设备列表  ======

/**
 获取群组设备列表

 @param userId 用户id(首页点击群组时传此参数)
 @param clusterId 群组id
 @param complete 返回值
 */
- (void)deviceDeviceListWithUserId:(NSString *)userId ClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  获取群成员列表  ======

/**
 获取群成员列表

 @param clusterId 群组id
 @param complete 返回值
 */
- (void)clusterGetUserListWithClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  通知设置  ======

/**
 通知设置

 @param Id 用户群组id
 @param remind 是否通知(1通知 0 不通知)
 @param complete 返回值
 */
- (void)clusterUserRemindWithId:(NSString *)Id Remind:(NSString *)remind ToGetResult:(void (^)(id data))complete;

#pragma mark ======  获取设备异常停留列表  ======

/**
 获取设备异常停留列表

 @param deviceId 设备id
 @param complete 返回值
 */
- (void)retentionRetentionListWithDeviceId:(NSString *)deviceId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  添加异常停留  ======

/**
 添加异常停留

 @param deviceId 设备id
 @param startTime 开始时间
 @param endTime 结束时间
 @param period 重复(0,1,2,3,4,5,6)
 @param complete 返回值
 */
- (void)retentionSaveWithDeviceId:(NSString *)deviceId StartTime:(NSString *)startTime EndTime:(NSString *)endTime Period:(NSString *)period ToGetResult:(void (^)(id data))complete;

#pragma mark ======  删除异常停留  ======

/**
 删除异常停留

 @param Id 异常停留id
 @param complete 返回值
 */
- (void)retentionDeleteWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete;
#pragma mark ======  查看设备详情  ======


/**
 查看设备详情

 @param Id 设备id
 @param complete 返回值
 */
- (void)deviceGetWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete;


#pragma mark ======  删除设备  ======

/**
 删除设备

 @param Id 设备ID
 @param complete 返回值
 */
- (void)deviceDeleteWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete;

#pragma mark ======  绑定设备  ======

/**
 绑定设备

 @param clusterId clusterId
 @param imei imei
 @param complete 返回值
 */
- (void)clusterBindingDeviceWithClusterId:(NSString *)clusterId Imei:(NSString *)imei ToGetResult:(void (^)(id data))complete;

#pragma mark ======  修改设备信息  ======

/**
 修改设备信息

 @param Id 设备id
 @param name 设备名称
 @param birthday 儿童生日
 @param childrenType 儿童学习阶段
 @param picUrl 头像地址
 @param complete 返回值
 */
- (void)deviceUpdateWithId:(NSString *)Id Name:(NSString *)name Birthday:(NSString *)birthday ChildrenType:(NSString *)childrenType PicUrl:(NSString *)picUrl ToGetResult:(void (^)(id data))complete;

#pragma mark ======  系统消息  ======

/**
 系统消息

 @param pageNow 当前页
 @param Size 页容
 @param userId 用户id
 @param complete 返回值
 */
- (void)noticePageWithPageNow:(NSString *)pageNow Size:(NSString *)size UserId:(NSString *)userId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  我的  ======

/**
 我的

 @param userId 用户id
 @param complete 返回值
 */
- (void)userMyInfoWithUserId:(NSString *)userId ToGetResult:(void (^)(id data))complete;


#pragma mark ======  删除安全消息  ======

/**
 删除安全消息

 @param Id 安全消息id
 @param complete 返回值
 */
- (void)messageUserDeleteWithId:(NSString *)Id UserId:(NSString *)userId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  删除系统消息  ======

/**
 删除系统消息

 @param Id 系统消息id
 @param complete 返回值
 */
- (void)noticeUserDeleteWithId:(NSString *)Id UserId:(NSString *)userId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  群组添加成员  ======

/**
 群组添加成员

 @param userId 用户id
 @param clusterId 群组id
 @param complete 返回值
 */
- (void)clusterUserSaveWithUserId:(NSString *)userId ClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  修改个人信息  ======

/**
 修改个人信息

 @param Id 用户id
 @param isPush 是否接受推送
 @param nickName 昵称
 @param picUrl 头像地址
 @param gender 性别(1 男 2 女)
 @param description     简介
 @param complete 返回值
 */
- (void)userUpdateWithId:(NSString *)Id IsPush:(NSString *)isPush NickName:(NSString *)nickName PicUrl:(NSString *)picUrl Gender:(NSString *)gender Description:(NSString *)description ToGetResult:(void (^)(id data))complete;

#pragma mark ======  添加意见反馈  ======

/**
 添加意见反馈

 @param userId 用户id
 @param content 反馈内容
 @param phoneNo 联系电话
 @param picUrls 图片地址,以逗号分隔
 @param complete 返回值
 */
- (void)feedbackSaveWithUserId:(NSString *)userId Content:(NSString *)content PhoneNo:(NSString *)phoneNo PicUrls:(NSString *)picUrls ToGetResult:(void (^)(id data))complete;

#pragma mark ======  校验当前手机号码验证码  ======

/**
 校验当前手机号码验证码

 @param phoneNo 手机号码
 @param checkCode 验证码
 @param complete 返回值
 */
- (void)userCheckCodeWithPhoneNo:(NSString *)phoneNo CheckCode:(NSString *)checkCode ToGetResult:(void (^)(id data))complete;


#pragma mark ======  修改手机号码  ======

/**
 修改手机号码

 @param userId 用户id
 @param phoneNo 手机号码
 @param checkCode 验证码
 @param complete 返回值
 */
- (void)userUpdatePhoneNoWithUserId:(NSString *)userId PhoneNo:(NSString *)phoneNo CheckCode:(NSString *)checkCode ToGetResult:(void (^)(id data))complete;

#pragma mark ======  常见问题列表  ======

/**
 常见问题列表

 @param pageNow 当前页
 @param size 页容
 @param complete 返回值
 */
- (void)questionPageWithPageNow:(NSString *)pageNow Size:(NSString *)size ToGetResult:(void (^)(id data))complete;

#pragma mark ======  获取系统配置  ======

/**
 获取系统配置

 @param complete 返回值
 */
- (void)settingGetSettingToGetResult:(void (^)(id data))complete;


#pragma mark ======  转让群组  ======

/**
 转让群组

 @param userId 用户id
 @param clusterId 群组id
 @param complete 返回值
 */
- (void)clusterTransferWithUserId:(NSString *)userId ClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  解散群组  ======

/**
 解散群组


 @param clusterId 群组id
 @param complete 返回值
 */
- (void)clusterDissolveWithClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  从群内移除成员/退出群组  ======

/**
 从群内移除成员/退出群组

 @param clusterId 群组id
 @param userId 用户id
 @param complete 返回值
 */
- (void)clusterUserRemoveWithClusterId:(NSString *)clusterId UserId:(NSString *)userId ToGetResult:(void (^)(id data))complete;

#pragma mark ======  第三方登录  ======


/**
 第三方登录

 @param qqOpenid qq唯一码
 @param wechatOpenid 微信唯一码
 @param complete 返回值
 */
- (void)userRedirectWithQqOpenid:(NSString *)qqOpenid WechatOpenid:(NSString *)wechatOpenid ToGetResult:(void (^)(id data))complete;


#pragma mark ======  获取设备参数  ======

/**
 获取设备参数

 @param complete 返回值
 */
- (void)deviceSettingGetSettingToGetResult:(void (^)(id data))complete;

@end

NS_ASSUME_NONNULL_END
