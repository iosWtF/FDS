//
//  BMAddDeviceScanViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBaseViewController.h"
#import "BMClusterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMAddDeviceScanViewController : UIViewController<JXCategoryListContentViewDelegate>

@property(nonatomic ,strong)UINavigationController * naviController;
@property(nonatomic ,strong)BMClusterModel * cluModel;

@end

NS_ASSUME_NONNULL_END
