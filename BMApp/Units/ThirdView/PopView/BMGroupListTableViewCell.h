//
//  BMGroupListTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMClusterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMGroupListTableViewCell : UITableViewCell

@property(nonatomic ,strong)BMClusterModel * model;
@property(nonatomic ,assign)BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
