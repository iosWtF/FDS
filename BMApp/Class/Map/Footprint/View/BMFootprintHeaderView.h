//
//  BMFootprintHeaderView.h
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDeviceModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^LeftBlock)(void);
typedef void(^RightBlock)(void);
@interface BMFootprintHeaderView : UIView

@property(nonatomic ,copy)NSString * cityCount;
@property(nonatomic ,copy)NSString * positionCount;
@property(nonatomic ,copy)NSString * icon;
@property(nonatomic ,strong)BMDeviceModel * model;
@property(nonatomic ,copy)NSString * date;
@property(nonatomic ,copy)LeftBlock leftBlock;
@property(nonatomic ,copy)RightBlock rightBlock;
@end

NS_ASSUME_NONNULL_END
