//
//  BMQuestionModel.h
//  BMApp
//
//  Created by Mac on 2019/10/24.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMQuestionModel : NSObject

@property(nonatomic ,copy)NSString * Id;
@property(nonatomic ,copy)NSString * name;
@property(nonatomic ,copy)NSString * content;
@property(nonatomic ,copy)NSString * sort;
@property(nonatomic ,copy)NSString * operateTime;

@end

NS_ASSUME_NONNULL_END
