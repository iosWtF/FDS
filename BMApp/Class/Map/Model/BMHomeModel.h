//
//  BMHomeModel.h
//  BMApp
//
//  Created by Mac on 2019/10/19.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMHomeModel : NSObject

@property(nonatomic ,copy)NSString * clusterId;
@property(nonatomic ,strong)NSMutableArray * clusterList;
@property(nonatomic ,strong)NSMutableArray * deviceList;


@end

NS_ASSUME_NONNULL_END
