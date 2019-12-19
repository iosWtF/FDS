//
//  BMMineSetTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMMineSetTableViewCell : UITableViewCell
@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,copy)NSString * cache;


@property(nonatomic ,assign)BOOL arrowHide;
@end

NS_ASSUME_NONNULL_END
