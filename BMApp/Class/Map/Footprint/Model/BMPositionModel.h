//
//  BMPositionModel.h
//  BMApp
//
//  Created by Mac on 2019/10/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMPositionModel : NSObject

@property(nonatomic ,copy)NSString * deviceId;//设备id,
@property(nonatomic ,copy)NSString * longitude;//经度,
@property(nonatomic ,copy)NSString * latitude;//纬度,
@property(nonatomic ,copy)NSString * city;//城市,
@property(nonatomic ,copy)NSString * position;// 详细位置,
@property(nonatomic ,copy)NSString * locationTime;//定位时间

@end

NS_ASSUME_NONNULL_END
