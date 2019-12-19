//
//  BMGroupMemberCollectionViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMClusterUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMGroupMemberCollectionViewCell : UICollectionViewCell

@property(nonatomic ,strong)BMClusterUserModel * userModel;
@property(nonatomic ,strong)UIImageView * iconImgView;
@property(nonatomic ,strong)UIButton * nameBtn;

@end

NS_ASSUME_NONNULL_END
