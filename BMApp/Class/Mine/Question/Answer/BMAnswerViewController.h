//
//  BMAnswerViewController.h
//  BMApp
//
//  Created by Mac on 2019/10/24.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBaseViewController.h"
#import "BMQuestionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMAnswerViewController : BMBaseViewController

@property(nonatomic ,strong)BMQuestionModel * question;

@end

NS_ASSUME_NONNULL_END
