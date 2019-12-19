//
//  BMOpinionHeaderCollectionReusableView.h
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OpinionTvBlock)(UITextView * tv);
typedef void(^PhoneBlock)(UITextField * tf);
@interface BMOpinionHeaderCollectionReusableView : UICollectionReusableView

@property(nonatomic ,copy)OpinionTvBlock opinionTvBlock;
@property(nonatomic ,copy)PhoneBlock phoneBlock;
@end

NS_ASSUME_NONNULL_END
