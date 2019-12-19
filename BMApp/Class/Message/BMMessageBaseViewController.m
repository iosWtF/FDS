//
//  BMMessageBaseViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMessageBaseViewController.h"
#import "BMSecurityMessageViewController.h"
#import "BMSysMessageViewController.h"

@interface BMMessageBaseViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@end

@implementation BMMessageBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldHandleScreenEdgeGesture = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
    
    self.listContainerView.didAppearPercent = 0.01; //滚动一点就触发加载
    [self.view addSubview:self.listContainerView];
    
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    
    self.listContainerView.scrollView.scrollEnabled = NO;
}
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.listContainerView.frame = CGRectMake(0, [self preferredCategoryViewHeight] + SafeAreaTopHeight +30 , self.view.bounds.size.width, self.view.bounds.size.height - [self preferredCategoryViewHeight] - SafeAreaTopHeight - SafeAreaBottomHeight - 30 - 49);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    
    return 33;
}

- (id<JXCategoryListContentViewDelegate>)preferredListAtIndex:(NSInteger)index {
    
    if (index == 0) {
        
        BMSecurityMessageViewController * order = [[BMSecurityMessageViewController alloc] init];
        
        return order;
    }else if (index == 1){
        
        BMSysMessageViewController * order = [[BMSysMessageViewController alloc] init];
        
        return order;
    }
    return nil;
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [self preferredCategoryView];
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    }
    return _listContainerView;
}
#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    if (_shouldHandleScreenEdgeGesture) {
        self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    }
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
    
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> list = [self preferredListAtIndex:index];
    
    if ([list isKindOfClass:[BMSecurityMessageViewController class]]) {
        
        BMSecurityMessageViewController * order = (BMSecurityMessageViewController *)list;
        order.naviController = self.navigationController;
    }else if ([list isKindOfClass:[BMSysMessageViewController class]]) {
        
        BMSysMessageViewController * order = (BMSysMessageViewController *)list;
        order.naviController = self.navigationController;
    }
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index{
    
    [self.listContainerView.scrollView setContentOffset:CGPointMake(index*self.self.listContainerView.scrollView.bounds.size.width, 0) animated:NO];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
