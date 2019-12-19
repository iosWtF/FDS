//
//  BMFootPrintAnnotationView.h
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@import UIKit;
@import MAMapKit;
NS_ASSUME_NONNULL_BEGIN

@interface BMFootPrintAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImageView *frontImgView;

@end

NS_ASSUME_NONNULL_END
