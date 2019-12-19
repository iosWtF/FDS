//
//  BMWeekTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMWeekTableViewCell : UITableViewCell

@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,assign)BOOL select;
@end

NS_ASSUME_NONNULL_END
