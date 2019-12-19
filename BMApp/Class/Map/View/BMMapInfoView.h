//
//  BMMapInfoView.h
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDeviceModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^FuncBlock)(NSInteger i);

@interface BMMapInfoView : UIView

@property(nonatomic ,copy)FuncBlock funcBlock;
@property(nonatomic ,strong)BMDeviceModel * device;
@end

NS_ASSUME_NONNULL_END
