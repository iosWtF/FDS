//
//  BMSecurityMsgDetailModel.h
//  BMApp
//
//  Created by Mac on 2019/10/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMSecurityMsgDetailModel : NSObject

@property(nonatomic ,copy)NSString * Id;//
@property(nonatomic ,copy)NSString * deviceId;//设备id,
@property(nonatomic ,copy)NSString * longitude;//
@property(nonatomic ,copy)NSString * latitude;//
@property(nonatomic ,copy)NSString * position;//
@property(nonatomic ,copy)NSString * type;//
@property(nonatomic ,copy)NSString * status;//
@property(nonatomic ,copy)NSString * createTime;//
@property(nonatomic ,copy)NSString * devicePic;
@property(nonatomic ,copy)NSString * name;
@property(nonatomic ,copy)NSString * fenceName;
//deviceId: 设备id,

//longitude: 经度,
//latitude: 纬度,
//position: 位置,
//type: 类型,
//status: 状态,
//reply: 处理回复,
//amPm: 上午/下午,
//createTime: 发送时间,
@end

NS_ASSUME_NONNULL_END
