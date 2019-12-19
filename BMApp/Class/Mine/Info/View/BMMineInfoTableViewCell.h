//
//  BMMineInfoTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChooseSexBlock)(UITextField *tf);
typedef void(^EditBlock)(UITextField *tf);

@interface BMMineInfoTableViewCell : UITableViewCell

@property(nonatomic ,strong)UIImageView *iconImgView;
@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,strong)UserModel * user;
@property(nonatomic ,copy)ChooseSexBlock chooseSexBlock;
@property(nonatomic ,copy)EditBlock editBlock;
@property(nonatomic ,assign)BOOL  canEdit;

@end

NS_ASSUME_NONNULL_END
