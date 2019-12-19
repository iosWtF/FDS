//
//  BMAddDeviceScanViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMAddDeviceScanViewController.h"
#import "BMScanViewController.h"
@interface BMAddDeviceScanViewController ()

@end

@implementation BMAddDeviceScanViewController

#pragma mark ======  扫描  ======

- (void)scan{
    
    BMScanViewController * scan = [[BMScanViewController alloc] init];
    scan.cluModel = self.cluModel;
    scan.type = @"添加设备";
    [self.naviController pushViewController:scan animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor  getUsualColorWithString:@"#F5F6FA"];
    UIButton * scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [scanBtn setTitleColor:[UIColor getUsualColorWithString:@"#333333"] forState:UIControlStateNormal];
    scanBtn.titleLabel.font  = [UIFont systemFontOfSize:14.f];
    [scanBtn setImage:[UIImage imageNamed:@"tianjia_shebei_icon"] forState:UIControlStateNormal];
    [scanBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    ZViewBorderRadius(scanBtn, 5, 0, [UIColor whiteColor]);
    [scanBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:3];
    [scanBtn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(30 * AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
    }];
    
    UILabel * tipLb = [[UILabel alloc] init];
    tipLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
    tipLb.font = [UIFont systemFontOfSize:14.f];
    tipLb.textAlignment = NSTextAlignmentLeft;
    tipLb.text = @"请扫描设备上二维码";
    [self.view addSubview:tipLb];
    [tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.equalTo(scanBtn.mas_bottom).offset(13 * AutoSizeScaleY);
        make.height.equalTo(14 * AutoSizeScaleY);
    }];
    
}
#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    
    
}

- (void)listDidDisappear {}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
