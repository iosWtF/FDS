//
//  BMClusterUserModel.h
//  BMApp
//
//  Created by Mac on 2019/10/19.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMClusterUserModel : NSObject

@property(nonatomic ,copy)NSString * userClusterId;
@property(nonatomic ,copy)NSString * clusterId;
@property(nonatomic ,copy)NSString * userId;
@property(nonatomic ,copy)NSString * remind;
@property(nonatomic ,copy)NSString * isOwner;
@property(nonatomic ,copy)NSString * checked;
@property(nonatomic ,copy)NSString * addTime;
@property(nonatomic ,copy)NSString * nickName;
@property(nonatomic ,copy)NSString * picUrl;
//userClusterId : 用户群组id,
//clusterId: 群组id,
//userId: 用户id,
//remind: 是否通知,
//isOwner: 是否是群主,
//checked: 是否选中,
//addTime: 入群时间,
//nickName: 成员昵称,
//picUrl: 成员头像
@end

NS_ASSUME_NONNULL_END
