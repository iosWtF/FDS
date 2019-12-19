//
//  BMSecurityMsgModel.h
//  BMApp
//
//  Created by Mac on 2019/10/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMSecurityMsgModel : NSObject

@property(nonatomic ,copy)NSString * Id;//
@property(nonatomic ,copy)NSString * deviceId;//设备id,
@property(nonatomic ,copy)NSString * positionId;//位置信息,
@property(nonatomic ,copy)NSString * longitude;// 经度,
@property(nonatomic ,copy)NSString * latitude;//纬度,
@property(nonatomic ,copy)NSString * position;//位置,
@property(nonatomic ,copy)NSString * type;// 类型,
@property(nonatomic ,copy)NSString * status;//状态,
@property(nonatomic ,copy)NSString * reply;// 处理回复,
@property(nonatomic ,copy)NSString * amPm;//上午/下午,
@property(nonatomic ,copy)NSString * createTime;// 发送时间,
@property(nonatomic ,copy)NSString * name;// 设备名称,
@property(nonatomic ,copy)NSString * nickName;//群主昵称,
@property(nonatomic ,copy)NSString * phoneNo;//群主联系方式,
@property(nonatomic ,copy)NSString * birthday;// 儿童生日,
@property(nonatomic ,copy)NSString * childrenType;//儿童学习阶段
@property(nonatomic ,copy)NSString * devicePic;//设备图片
@property(nonatomic ,copy)NSString * fenceName;//围栏名称
@property(nonatomic ,copy)NSString * messageId;//消息id
@end

NS_ASSUME_NONNULL_END
