//
//  BMMemberInfoViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBaseViewController.h"
#import "BMClusterUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMMemberInfoViewController : BMBaseViewController
@property(nonatomic ,strong)BMClusterUserModel * model;
@property(nonatomic ,assign)BOOL isOwner;

@end

NS_ASSUME_NONNULL_END
