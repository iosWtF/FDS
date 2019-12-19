//
//  BMGroupInfoHeaderView.h
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TypeBlock)(NSInteger i);
typedef void(^CheckAllBlock)(void);

@interface BMGroupInfoHeaderView : UIView
@property(nonatomic ,strong)NSMutableArray * sourceArr;
@property(nonatomic ,copy)TypeBlock typeBlock;
@property(nonatomic ,copy)CheckAllBlock checkAllBlock;

@end

NS_ASSUME_NONNULL_END
