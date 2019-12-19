//
//  BMLoginModel.m
//  BMApp
//
//  Created by Mac on 2019/10/18.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMLoginModel.h"

@implementation BMLoginModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([NSString isEmpty:oldValue]) {// 以字符串类型为例
        return  @"";
    }
    return oldValue;
}

+ (NSDictionary *)objectClassInArray{
    return @{
             @"clusterList" : @"BMClusterModel",
             @"deviceList" : @"BMDeviceModel"
             };
}

@end
