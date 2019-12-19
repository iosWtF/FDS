//
//  BMPeriodTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDeviceModel.h"
#import "BMRetentionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMPeriodTableViewCell : UITableViewCell

@property(nonatomic ,strong)BMRetentionModel * retention;
@property(nonatomic ,strong)BMDeviceModel * device;
@end

NS_ASSUME_NONNULL_END
