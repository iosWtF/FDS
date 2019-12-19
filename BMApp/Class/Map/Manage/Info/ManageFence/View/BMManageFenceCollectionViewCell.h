//
//  BMManageFenceCollectionViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMFenceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMManageFenceCollectionViewCell : UICollectionViewCell
@property(nonatomic ,strong)UIImageView * imgView;
@property(nonatomic ,strong)UILabel * nameLb;

@property(nonatomic ,strong)BMFenceModel * model;
@end

NS_ASSUME_NONNULL_END
