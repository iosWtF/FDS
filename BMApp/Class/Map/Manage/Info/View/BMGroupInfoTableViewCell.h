//
//  BMGroupInfoTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDeviceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMGroupInfoTableViewCell : UITableViewCell

@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,copy)NSString * content;
@property(nonatomic ,assign)BOOL imgHidden;
@property(nonatomic ,strong)UIImageView *arrowImgView;
@property(nonatomic ,strong)BMDeviceModel *deviceModel;

@end

NS_ASSUME_NONNULL_END
