//
//  BMBatteryView.h
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMBatteryView : UIView

/**
 value:0 - 100
 */
- (void)setBatteryValue:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
