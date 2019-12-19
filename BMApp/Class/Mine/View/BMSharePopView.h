//
//  BMSharePopView.h
//  BMApp
//
//  Created by Mac on 2019/9/16.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMSharePopView : UIView

+ (void)showMoreWithTitle:(NSArray *)titleArray
             imgNameArray:(NSArray *)imgNameArray
           blockTapAction:( void(^)(NSInteger index) )blockTapAction;

@end

NS_ASSUME_NONNULL_END
