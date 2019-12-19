//
//  BMBaseViewController.m
//  Tourism
//
//  Created by Mac on 2018/12/24.
//  Copyright © 2018 BM. All rights reserved.
//

#import "BMBaseViewController.h"

@interface BMBaseViewController ()

@end

@implementation BMBaseViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)setupNavBar
{
    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"home_top_bg"];
    
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
    if (self.navigationController.childViewControllers.count != 1) {
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"icon_fanhui"]];
    }
    self.customNavBar.titleLabelFont = [UIFont systemFontOfSize:18.f weight:2];
    self.customNavBar.titleLabelColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
}

- (WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
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
