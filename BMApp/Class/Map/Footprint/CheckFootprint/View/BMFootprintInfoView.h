//
//  BMFootprintInfoView.h
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMPositionModel.h"

typedef void(^LeftBlock)(void);
typedef void(^RightBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface BMFootprintInfoView : UIView
@property(nonatomic ,strong)BMPositionModel * model;
@property(nonatomic ,copy)LeftBlock  leftBlock;
@property(nonatomic ,copy)RightBlock rightBlock;
@end

NS_ASSUME_NONNULL_END
