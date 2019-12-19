//
//  BMFenceModel.h
//  BMApp
//
//  Created by Mac on 2019/10/23.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMFenceModel : NSObject
@property(nonatomic ,copy)NSString * Id;
@property(nonatomic ,copy)NSString * clusterId;
@property(nonatomic ,copy)NSString * name;
@property(nonatomic ,copy)NSString * position;
@property(nonatomic ,copy)NSString * longitude;
@property(nonatomic ,copy)NSString * latitude;
@property(nonatomic ,copy)NSString * radius;
@property(nonatomic ,copy)NSString * createTime;

//id : 用户群组id,
//clusterId: 群组id,
//name: 围栏名称,
//position: 围栏中心点位置名称,
//longitude: 经度,
//latitude: 纬度,
//radius: 半径,
//createTime: 添加时间

@end

NS_ASSUME_NONNULL_END
