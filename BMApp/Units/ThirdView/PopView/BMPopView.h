//
//  BMDeleteAddressPopView.h
//  BMApp
//
//  Created by Mac on 2019/6/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMPopView : UIView

+ (void)showWithContent:(NSString *)content blockTapAction:(void(^)(NSInteger index))blockTapAction;

@end

NS_ASSUME_NONNULL_END
