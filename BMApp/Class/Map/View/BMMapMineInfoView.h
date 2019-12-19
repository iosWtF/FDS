//
//  BMMapMineInfoView.h
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDeviceModel.h"
#import "BMFenceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMMapMineInfoView : UIView

@property(nonatomic ,strong)BMDeviceModel * device;
@property(nonatomic ,strong)BMFenceModel * fence;
@end

NS_ASSUME_NONNULL_END
