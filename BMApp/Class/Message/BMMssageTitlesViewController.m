//
//  BMMssageTitlesViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMssageTitlesViewController.h"

#import "JXCategoryDotView.h"

@interface BMMssageTitlesViewController ()<JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryDotView *myCategoryView;
@property (nonatomic, strong) NSMutableArray *dotStates;
@end

@implementation BMMssageTitlesViewController

- (void)viewDidLoad {
    self.titles = [NSMutableArray arrayWithArray:@[@"安全消息", @"系统消息"]];
    
    [super viewDidLoad];
    
    self.customNavBar.title = @"消息中心";
    [self.customNavBar wr_setRightButtonWithTitle:@"清空" titleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    self.customNavBar.onClickRightButton = ^{
      
        [BMPopView showWithContent:@"确认清空安全消息列表?" blockTapAction:^(NSInteger index) {
           
            
            if (self.categoryView.selectedIndex == 0) {
                
                [Z_NotificationCenter postNotificationName:@"clearSecMsg" object:nil];
            }else{
                
                [Z_NotificationCenter postNotificationName:@"clearSysMsg" object:nil];
            }
            
        }];
        
        
        
        
        
    };
//    _dotStates = @[@NO, @YES, @NO, @NO, @YES, @YES, @YES, @NO, @YES, @YES, @NO].mutableCopy;
//    self.myCategoryView.dotStates = self.dotStates;
    CGFloat totalItemWidth = self.view.bounds.size.width - 150 * AutoSizeScaleX;
    self.myCategoryView.layer.cornerRadius = 5;
    self.myCategoryView.layer.masksToBounds = YES;
    self.myCategoryView.layer.borderColor = [UIColor getUsualColorWithString:@"#446EDD"].CGColor;
    self.myCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.cellWidth = totalItemWidth/self.titles.count;
    self.myCategoryView.titleColor = [UIColor getUsualColorWithString:@"#446EDD"];
    self.myCategoryView.titleSelectedColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
//    self.myCategoryView.cellBackgroundUnselectedColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
//    self.myCategoryView.cellBackgroundSelectedColor = [UIColor getUsualColorWithString:@"#446EDD"];
    self.myCategoryView.titleLabelMaskEnabled = YES;
    
    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorCornerRadius = 0;
    backgroundView.indicatorHeight = 33;
    backgroundView.indicatorWidthIncrement = 0;
    backgroundView.indicatorColor = [UIColor getUsualColorWithString:@"#446EDD"];
    self.myCategoryView.indicators = @[backgroundView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat totalItemWidth = self.view.bounds.size.width - 150 * AutoSizeScaleX;
    self.myCategoryView.frame = CGRectMake(75 * AutoSizeScaleX, SafeAreaTopHeight + 15 , totalItemWidth, 33);
}

- (JXCategoryDotView *)myCategoryView {
    return (JXCategoryDotView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryDotView alloc] init];
}

- (void)reloadDot {
    self.dotStates = @[@NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO].mutableCopy;
    self.myCategoryView.dotStates = self.dotStates;
    [self.myCategoryView reloadData];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    if ([self.dotStates[index] boolValue] == YES) {
        self.dotStates[index] = @(NO);
        self.myCategoryView.dotStates = self.dotStates;
        [categoryView reloadCellAtIndex:index];
    }
}

@end
