//
//  BMGroupModel.h
//  BMApp
//
//  Created by Mac on 2019/10/19.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMClusterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMGroupModel : NSObject

@property(nonatomic ,copy)NSString * isOwner;
@property(nonatomic ,strong)NSMutableArray * clusterUserList;
@property(nonatomic ,strong)NSMutableArray * deviceList;
@property(nonatomic ,strong)BMClusterModel * cluster;

@end

NS_ASSUME_NONNULL_END
