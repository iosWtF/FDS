//
//  BMChooseGroupPopView.h
//  BMApp
//
//  Created by Mac on 2019/11/4.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMClusterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMChooseGroupPopView : UIView

+ (void)showWithGroupArr:(NSMutableArray *)arr blockTapAction:(void(^)(BMClusterModel * cluModel))blockTapAction;

@end

@interface BMChooseGroupTableViewCell : UITableViewCell

@property(nonatomic ,strong)BMClusterModel * model;

@end


NS_ASSUME_NONNULL_END
