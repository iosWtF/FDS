//
//  BMEditDeviceViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMBaseViewController.h"
#import "BMDeviceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMEditDeviceViewController : BMBaseViewController

@property(nonatomic ,strong)BMDeviceModel * device;

@end

NS_ASSUME_NONNULL_END
