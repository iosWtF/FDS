//
//  BMContentTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDeviceSettingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMContentTableViewCell : UITableViewCell

@property(nonatomic ,strong)BMDeviceSettingModel * settingModel;

@end

NS_ASSUME_NONNULL_END
