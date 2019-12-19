//
//  BMUserInfoModel.m
//  Tourism
//
//  Created by Mac on 2019/3/15.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMUserInfoModel.h"

@implementation BMUserInfoModel
//解 归档 操作宏
MJCodingImplementation


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"Friend":@"friend"};
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if (!oldValue||[oldValue isKindOfClass:[NSNull class]]) {
        
        return @"";
    }
    return oldValue;
}
    
@end
