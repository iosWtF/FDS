//
//  BMOpinionCollectionViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMOpinionCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *gifLable;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

- (UIView *)snapshotView;

@end

NS_ASSUME_NONNULL_END
