//
//  BMDeviceSettingModel.h
//  BMApp
//
//  Created by Mac on 2019/10/26.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMDeviceSettingModel : NSObject

@property(nonatomic ,copy)NSString * Id;
@property(nonatomic ,copy)NSString * sportModeMinute;
@property(nonatomic ,copy)NSString * slienceModeMinute;
@property(nonatomic ,copy)NSString * urgencyModeSecond;
@property(nonatomic ,copy)NSString * urgencyModeMinute;
@property(nonatomic ,copy)NSString * sleepStartHour;
@property(nonatomic ,copy)NSString * sleepEndHour;
@property(nonatomic ,copy)NSString * offlineMinute;
@property(nonatomic ,copy)NSString * exceptionMinute;

//id: 1,
//sportModeMinute: 动态模式上传时间间隔,
//slienceModeMinute: 静态模式上传时间间隔,
//urgencyModeSecond: 紧急模式上传时间间隔,
//urgencyModeMinute: 紧急模式开启时长,
//sleepStartHour: 休眠开始时间,
//sleepEndHour: 休眠结束时间,
//offlineMinute: 设备离线判断时间,
//exceptionMinute: 异常停留判断时间,
@end

NS_ASSUME_NONNULL_END
