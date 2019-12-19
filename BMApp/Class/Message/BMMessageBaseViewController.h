//
//  BMMessageBaseViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBaseViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMMessageBaseViewController : BMBaseViewController

@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, assign) BOOL shouldHandleScreenEdgeGesture;

- (JXCategoryBaseView *)preferredCategoryView;

- (CGFloat)preferredCategoryViewHeight;

- (id<JXCategoryListContentViewDelegate>)preferredListAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
