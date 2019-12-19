//
//  BMSecurityDetailInfoView.h
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMSecurityMsgModel.h"
#import "BMSecurityMsgDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^CheckBlock)(void);
@interface BMSecurityDetailInfoView : UIView

@property(nonatomic ,strong)BMSecurityMsgDetailModel * model;
//@property(nonatomic ,strong)BMSecurityMsgModel * model;
@property(nonatomic ,copy)CheckBlock  checkBlock;
@end

NS_ASSUME_NONNULL_END
