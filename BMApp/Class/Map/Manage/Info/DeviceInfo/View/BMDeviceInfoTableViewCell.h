//
//  BMDeviceInfoTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface BMDeviceInfoTableViewCell : UITableViewCell

@property(nonatomic ,strong)UIImageView *iconImgView;
@property(nonatomic ,strong)UITextField *contentTf;
@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,copy)NSString * img;

@end

NS_ASSUME_NONNULL_END
