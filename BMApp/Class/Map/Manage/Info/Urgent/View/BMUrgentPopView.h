//
//  BMUrgentPopView.h
//  BMApp
//
//  Created by Mac on 2019/10/25.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMUrgentPopView : UIView

+ (void)showWithContent:(NSString *)content blockTapAction:(void(^)(NSInteger index))blockTapAction;

@end

NS_ASSUME_NONNULL_END
