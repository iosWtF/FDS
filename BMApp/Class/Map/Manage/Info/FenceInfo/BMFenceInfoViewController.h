//
//  BMFenceInfoViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBaseViewController.h"
#import "BMFenceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMFenceInfoViewController : BMBaseViewController

@property(nonatomic ,strong)BMFenceModel * fenceModel;
@property(nonatomic ,assign)BOOL  isOwner;
@end

NS_ASSUME_NONNULL_END
