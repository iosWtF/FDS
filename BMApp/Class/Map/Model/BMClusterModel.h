//
//  BMClusterModel.h
//  BMApp
//
//  Created by Mac on 2019/10/18.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMClusterModel : NSObject

@property(nonatomic ,copy)NSString * Id;
@property(nonatomic ,copy)NSString * name;
@property(nonatomic ,copy)NSString * ownerId;
@property(nonatomic ,copy)NSString * picUrl;
@property(nonatomic ,copy)NSString * qrcodeUrl;

@end

NS_ASSUME_NONNULL_END
