//
//  BMClusterModel.m
//  BMApp
//
//  Created by Mac on 2019/10/18.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMClusterModel.h"

@implementation BMClusterModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([NSString isEmpty:oldValue]) {// 以字符串类型为例
        return  @"";
    }
    return oldValue;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"Id":@"id"};
}

@end
