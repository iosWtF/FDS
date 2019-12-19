//
//  BMGroupModel.m
//  BMApp
//
//  Created by Mac on 2019/10/19.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMGroupModel.h"

@implementation BMGroupModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([NSString isEmpty:oldValue]) {// 以字符串类型为例
        return  @"";
    }
    return oldValue;
}

+ (NSDictionary *)objectClassInArray{
    return @{
             @"clusterUserList" : @"BMClusterUserModel",
             @"deviceList" : @"BMDeviceModel"
             };
}

@end
