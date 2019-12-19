//
//  BMUrgentSetTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDeviceModel.h"
#import "BMDeviceSettingModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SwitchBlock)(UISwitch * swich);
@interface BMUrgentSetTableViewCell : UITableViewCell

@property(nonatomic ,strong)BMDeviceModel * model;
@property(nonatomic ,strong)BMDeviceSettingModel * settingModel;
@property(nonatomic ,copy)SwitchBlock  switchBlock;

@end

NS_ASSUME_NONNULL_END
