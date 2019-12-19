//
//  BMBindPhoneViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMBindPhoneViewController : BMBaseViewController

@property(nonatomic ,copy)NSString * qqOpenid;
@property(nonatomic ,copy)NSString * wechatOpenid;
@property(nonatomic ,copy)NSString * nickName;
@property(nonatomic ,copy)NSString * picUrl;
@property(nonatomic ,copy)NSString * gender;

@end

NS_ASSUME_NONNULL_END
