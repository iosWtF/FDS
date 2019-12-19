//
//  BMMineHeaderView.h
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FuncBlock)(NSInteger i);

@interface BMMineHeaderView : UIView

@property(nonatomic ,copy)FuncBlock funcBlock;
@property(nonatomic ,strong)UserModel * user;
@end

NS_ASSUME_NONNULL_END
