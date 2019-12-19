//
//  BMAddDeviceInputViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMAddDeviceInputViewController.h"

#import "BMEditDeviceViewController.h"
#import "BMDeviceModel.h"
@interface BMAddDeviceInputViewController ()<UITextFieldDelegate>

@property(nonatomic ,strong)UITextField * idTf;
@property(nonatomic ,strong)BMDeviceModel * device;
@end

@implementation BMAddDeviceInputViewController

#pragma mark ======  绑定  ======

- (void)bind{
 
    if (self.idTf.text.length == 0) {
        
        [self showHint:@"请输入设备id"];
        return;
    }
    
    [[BMHttpsMethod httpMethodManager] clusterBindingDeviceWithClusterId:self.cluModel.Id Imei:self.idTf.text ToGetResult:^(id  _Nonnull data) {
       
        LHLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.device = [BMDeviceModel mj_objectWithKeyValues:data[@"data"]];
            self.device.imei = self.idTf.text;
            BMEditDeviceViewController * edit = [[BMEditDeviceViewController alloc] init];
            edit.device = self.device;
            [self.naviController pushViewController:edit animated:YES];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor  getUsualColorWithString:@"#F5F6FA"];
    
    UITextField *idTf = [[UITextField alloc] init];
    idTf.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    idTf.placeholder = @"请输入设备ID (IMEI)";
    idTf.font = [UIFont systemFontOfSize:14.f];
    [idTf setValue:[UIColor getUsualColorWithString:@"#C8C8C8"] forKeyPath:@"placeholderLabel.textColor"];
    idTf.leftView = [self.view viewWithTag:11];
    idTf.leftViewMode = UITextFieldViewModeAlways;
    [idTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    idTf.delegate = self;
    idTf.keyboardType = UIKeyboardTypeNumberPad;
    idTf.textAlignment = NSTextAlignmentCenter;
    ZViewBorderRadius(idTf, 5, 0, [UIColor whiteColor]);
    [self.view addSubview:idTf];
    [idTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(30* AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
        
    }];
    self.idTf = idTf;
    
    UIButton * bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [bindBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    bindBtn.titleLabel.font  = [UIFont systemFontOfSize:14.f];
    [bindBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    ZViewBorderRadius(bindBtn, 5, 0, [UIColor whiteColor]);
    [bindBtn addTarget:self action:@selector(bind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindBtn];
    [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(idTf.mas_bottom).offset(20 * AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
    }];
    
}
#pragma mark ======  textFieldDelegate  ======

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([NSString isNineKeyBoard:string] ){
        
        return YES;
    }else{
        
        if ([NSString stringContainsEmoji:string]) {
            
            return NO;
        }
    }
    return YES;
}

-(void)textFieldDidChange:(UITextField *)tf{
    
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
