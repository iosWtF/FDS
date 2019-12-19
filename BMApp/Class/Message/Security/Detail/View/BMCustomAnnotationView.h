//
//  BMCustomAnnotationView.h
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

#import "BMDeviceModel.h"
#import "BMSecurityMsgDetailModel.h"
@import UIKit;
@import MAMapKit;
NS_ASSUME_NONNULL_BEGIN

@interface BMCustomAnnotationView : MAAnnotationView


@property (nonatomic, strong) BMDeviceModel *device;
@property (nonatomic, strong) BMSecurityMsgDetailModel *msg;
@end

NS_ASSUME_NONNULL_END
