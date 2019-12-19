//
//  BMDeviceModel.h
//  BMApp
//
//  Created by Mac on 2019/10/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMDeviceModel : NSObject

@property(nonatomic ,copy)NSString * Id;//设备id,
@property(nonatomic ,copy)NSString * imei;
@property(nonatomic ,copy)NSString * platformId;//电信平台设备id,
@property(nonatomic ,copy)NSString * binding;//设备状态(0 未绑定 1 已绑定),
@property(nonatomic ,copy)NSString * clusterId;//群组id
@property(nonatomic ,copy)NSString * name;//设备名称
@property(nonatomic ,copy)NSString * picUrl;//头像地址
@property(nonatomic ,copy)NSString * birthday;//儿童生日
@property(nonatomic ,copy)NSString * childrenType;//儿童学习阶段,
@property(nonatomic ,copy)NSString * addTime;//添加时间
@property(nonatomic ,copy)NSString * position;//位置
@property(nonatomic ,copy)NSString * longitude;//经度
@property(nonatomic ,copy)NSString * latitude;//维度
@property(nonatomic ,copy)NSString * status;//设备状态,
@property(nonatomic ,copy)NSString * bindingTime;//绑定时间,
@property(nonatomic ,copy)NSString * refreshTime;//更新时间
@property(nonatomic ,copy)NSString * retentionCount;//异常停留数量
@property(nonatomic ,copy)NSString * battery;//电量
@property(nonatomic ,copy)NSString * distance;//距离
@property(nonatomic ,copy)NSString * emergency;//紧急状态

@end

NS_ASSUME_NONNULL_END
