//
//  BMAddDeviceTitlesViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMAddDeviceTitlesViewController.h"

#import "JXCategoryTitleView.h"
#import "BMAddDeviceInputViewController.h"
#import "BMAddDeviceScanViewController.h"
@interface BMAddDeviceTitlesViewController ()

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end
@implementation BMAddDeviceTitlesViewController

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view.
    if (self.titles == nil) {
        
        self.titles = [NSMutableArray arrayWithArray:@[@"扫码", @"输入"]];
    }
    
    [super viewDidLoad];
    self.customNavBar.title = @"添加设备";

    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleFont = [UIFont systemFontOfSize:15.f];
    self.myCategoryView.titleSelectedFont = [UIFont systemFontOfSize:15.f];
    self.myCategoryView.titleColor = [UIColor getUsualColorWithString:@"#6C6C6C"];
    self.myCategoryView.titleSelectedColor = [UIColor getUsualColorWithString:@"#4285F4"];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    lineView.indicatorWidthIncrement = 25;
    lineView.indicatorLineViewColor = [UIColor getUsualColorWithString:@"#0088FF"];
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.indicators = @[lineView];
    
    

}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
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
