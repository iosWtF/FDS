//
//  BMEditDeviceTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChooseBlock)(UITextField *tf);
typedef void(^EditBlock)(UITextField *tf);

@interface BMEditDeviceTableViewCell : UITableViewCell

@property(nonatomic ,strong)UIImageView *iconImgView;
@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,copy)NSString * content;
@property(nonatomic ,copy)NSString * img;
@property(nonatomic ,copy)NSString * placeHolder;
@property(nonatomic ,copy)ChooseBlock chooseBlock;
@property(nonatomic ,copy)EditBlock editBlock;
@property(nonatomic ,assign)BOOL  canEdit;

@end

NS_ASSUME_NONNULL_END
