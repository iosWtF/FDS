//
//  BMChangePhoneCheckViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMChangePhoneCheckViewController.h"

#import "BMChangePhoneViewController.h"

@interface BMChangePhoneCheckViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) id timer;
@property(nonatomic ,strong)UIButton * getCodeBtn;
@property(nonatomic ,strong)UITextField * phoneNumTf;
@property(nonatomic ,strong)UITextField * codeTf;

@end

@implementation BMChangePhoneCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title =@"更换手机号";
    
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    [self setupUI];
    
}

- (void)confirm{
    
    if (self.codeTf.text.length == 0) {
        
        [self showHint:@"请输入验证码"];
        return;
    }
    if (self.codeTf.text.length != 4) {
        
        [self showHint:@"验证码错误"];
        return;
    }
    
    [[BMHttpsMethod httpMethodManager] userCheckCodeWithPhoneNo:self.phoneNumTf.text CheckCode:self.codeTf.text ToGetResult:^(id  _Nonnull data) {
       
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]){
            
            BMChangePhoneViewController * change = [[BMChangePhoneViewController alloc] init];
            [self.navigationController pushViewController:change animated:YES];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}

- (void)setupUI{
    
    UILabel * tipLb = [[UILabel alloc] init];
    tipLb.text = @"请验证您的手机号进行下一步操作";
    tipLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
    tipLb.font = [UIFont systemFontOfSize:14.f];
    tipLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLb];
    [tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(38 * AutoSizeScaleY);
    }];
    
    UIView * leftView1 = [[UIView alloc] init];
    leftView1.frame = CGRectMake(0, 0, 104 * AutoSizeScaleX, 30 * AutoSizeScaleY);
    UILabel * tipLb1 = [[UILabel alloc] initWithFrame:CGRectMake(14 * AutoSizeScaleX, 0, 90 * AutoSizeScaleX, 30 * AutoSizeScaleY)];
    tipLb1.text = @"手机号码";
    tipLb1.textColor = [UIColor getUsualColorWithString:@"#323232"];
    tipLb1.font = [UIFont systemFontOfSize:15.f];
    tipLb1.textAlignment = NSTextAlignmentLeft;
    [leftView1 addSubview:tipLb1];
    
    UIView * leftView2 = [[UIView alloc] init];
    leftView2.frame = CGRectMake(0, 0, 104 * AutoSizeScaleX, 30 * AutoSizeScaleY);
    UILabel * tipLb2 = [[UILabel alloc] initWithFrame:CGRectMake(14 * AutoSizeScaleX, 0, 90 * AutoSizeScaleX, 30 * AutoSizeScaleY)];
    tipLb2.text = @"验证码";
    tipLb2.textColor = [UIColor getUsualColorWithString:@"#323232"];
    tipLb2.font = [UIFont systemFontOfSize:15.f];
    tipLb2.textAlignment = NSTextAlignmentLeft;
    [leftView2 addSubview:tipLb2];
    
    
    UITextField *phoneNumTf = [[UITextField alloc] init];
    phoneNumTf.backgroundColor = [UIColor whiteColor];
    phoneNumTf.placeholder = @"请输入手机号";
    phoneNumTf.font = [UIFont systemFontOfSize:18.f];
    [phoneNumTf setValue:[UIColor getUsualColorWithString:@"#C5C9D1"] forKeyPath:@"placeholderLabel.textColor"];
    phoneNumTf.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumTf.leftView = leftView1;
    phoneNumTf.leftViewMode = UITextFieldViewModeAlways;
    phoneNumTf.delegate = self;
    [phoneNumTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phoneNumTf];
    [phoneNumTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(tipLb.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(45* AutoSizeScaleY);
    }];
    self.phoneNumTf = phoneNumTf;
    UserModel * user = [[BMUserInfoManager sharedManager] getUser];
    self.phoneNumTf.text = user.phoneNo;
    
    
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#DDDDDD"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneNumTf.mas_bottom);
        make.left.right.equalTo(phoneNumTf);
        make.height.equalTo(1);
    }];
    
    UIButton * getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [getCodeBtn setTitleColor:[UIColor getUsualColorWithString:@"#999999"] forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.getCodeBtn = getCodeBtn;
    getCodeBtn.frame = CGRectMake(0, 0, 120* AutoSizeScaleX, 30* AutoSizeScaleY);
    
    UITextField *codeTf = [[UITextField alloc] init];
    codeTf.backgroundColor = [UIColor whiteColor];
    codeTf.placeholder = @"请输入验证码";
    codeTf.font = [UIFont systemFontOfSize:15.f];
    [codeTf setValue:[UIColor getUsualColorWithString:@"#C5C9D1"] forKeyPath:@"placeholderLabel.textColor"];
    codeTf.leftView = leftView2;
    codeTf.leftViewMode = UITextFieldViewModeAlways;
    [codeTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    codeTf.rightView = getCodeBtn;
    codeTf.rightViewMode = UITextFieldViewModeAlways;
    codeTf.keyboardType = UIKeyboardTypeNumberPad;
    codeTf.delegate = self;
    [self.view addSubview:codeTf];
    [codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom);
        make.left.right.height.equalTo(phoneNumTf);
        
    }];
    self.codeTf = codeTf;
    
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    ZViewBorderRadius(confirmBtn, 5, 0, [UIColor getUsualColorWithString:@"#4285F4"]);
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(- 10 * AutoSizeScaleY - SafeAreaBottomHeight);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
    }];
    
    
}

#pragma mark ======  获取验证码  ======
- (void)getCodeBtnClick:(UIButton *)btn{
    
//    if (![NSString checkPhone:self.phoneNumTf.text]){
//
//        [self showHint:@"手机号不正确"];
//        return;
//    }
    
    [[BMHttpsMethod httpMethodManager] userGetCheckCodeWithPhoneNo:self.phoneNumTf.text Type:@"" ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]){
            
            [self showHint:@"发送成功"];
            //发送成功
            __block NSInteger second = 60;
            //全局队列    默认优先级
            dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //定时器模式  事件源
            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
            
            self.timer = timer;
            
            //NSEC_PER_SEC是秒，＊1是每秒
            dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
            //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
            dispatch_source_set_event_handler(timer, ^{
                //回调主线程，在主线程中操作UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (second >= 0) {
                        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%lds",(long)second] forState:UIControlStateNormal];
                        second--;
                        self.getCodeBtn.enabled = NO;
                    }
                    else
                    {
                        //这句话必须写否则会出问题
                        dispatch_source_cancel(timer);
                        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                        self.getCodeBtn.enabled = YES;
                    }
                });
            });
            //启动源
            dispatch_resume(timer);
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [self wr_setNavBarShadowImageHidden:NO];
    if (_timer){
        dispatch_source_cancel(_timer) ;
    }
    if (self.getCodeBtn) {
        
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getCodeBtn.enabled = YES;
    }
    
}

#pragma mark ======  textFieldDelegate  ======

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.phoneNumTf) {
        
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
        if (textField == self.codeTf) {
    
            if (textField.text.length > 3 && ![string isEqualToString:@""]){
                return NO;
            }
        }
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
