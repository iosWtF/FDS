//
//  BMRetentionModel.h
//  BMApp
//
//  Created by Mac on 2019/10/23.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMRetentionModel : NSObject

@property(nonatomic ,copy)NSString * Id;
@property(nonatomic ,copy)NSString * deviceId;
@property(nonatomic ,copy)NSString * startTime;
@property(nonatomic ,copy)NSString * endTime;
@property(nonatomic ,copy)NSString * period;

//id: 异常停留id,
//deviceId: 设备id,
//startTime: 开始时间,
//endTime: 结束时间,
//period: 重复周期(0 未绑定 1 已绑定),

@end

NS_ASSUME_NONNULL_END
