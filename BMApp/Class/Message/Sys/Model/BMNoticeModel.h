//
//  BMNoticeModel.h
//  BMApp
//
//  Created by Mac on 2019/10/24.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMNoticeModel : NSObject

@property(nonatomic ,copy)NSString * Id;
@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,copy)NSString * content;
@property(nonatomic ,copy)NSString * type;
@property(nonatomic ,copy)NSString * clusterName;
@property(nonatomic ,copy)NSString * amPm;
@property(nonatomic ,copy)NSString * publishTime;
@property(nonatomic ,copy)NSString * picUrl;
@property(nonatomic ,copy)NSString * nickName;
@property(nonatomic ,copy)NSString * userPic;
//id: 1,
//picUrl: 公告头像,
//title: 公告标题,(除系统公告,用户反馈外 用此名称)
//content: 公告详情,
//type: 公告类型,
//clusterName: 群组名称,
//amPm: 上午/下午,
//publishTime: 发布时间,
//nickName: 用户昵称,(系统公告,用户反馈 用此名称)
//userPic: 用户头像,(系统公告,用户反馈 用此头像)
@end

NS_ASSUME_NONNULL_END
