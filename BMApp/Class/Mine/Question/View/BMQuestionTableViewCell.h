//
//  BMQuestionTableViewCell.h
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMQuestionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMQuestionTableViewCell : UITableViewCell

@property(nonatomic ,strong)BMQuestionModel * question;

@end

NS_ASSUME_NONNULL_END
