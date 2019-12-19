//
//  BMPeriodViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBaseViewController.h"
#import "BMDeviceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMPeriodViewController : BMBaseViewController

@property(nonatomic ,strong)BMDeviceModel * device;
@property(nonatomic ,assign)BOOL isOwner;
@end

NS_ASSUME_NONNULL_END
