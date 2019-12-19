//
//  BMChooseDeviceViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBaseViewController.h"
#import "BMClusterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMChooseDeviceViewController : BMBaseViewController
@property(nonatomic ,strong)BMClusterModel * cluModel;
@property(nonatomic ,assign)BOOL isOwner;
@end

NS_ASSUME_NONNULL_END
