//
//  BMBindPhoneViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMBindPhoneViewController.h"

@interface BMBindPhoneViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) id timer;
@property(nonatomic ,strong)UITextField *  phoneNumTf;
@property(nonatomic ,strong)UITextField *  codeTf;
@property(nonatomic ,strong)UIButton *  getCodeBtn;

@end

@implementation BMBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    self.customNavBar.title = @"绑定手机号";
    [self setupUI];
}
- (void)setupUI{
    
    UIView * leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 103 * AutoSizeScaleX, 45 * AutoSizeScaleX);
    UILabel * leftLb = [[UILabel alloc] init];
    leftLb.frame = CGRectMake(14 * AutoSizeScaleX, 0, 0, 45 * AutoSizeScaleX);
    leftLb.text = @"手机号码";
    leftLb.textColor = [UIColor getUsualColorWithString:@"#323232"];
    leftLb.font = [UIFont systemFontOfSize:15.f];
    [leftLb sizeToFit];
    leftLb.centerY = leftView.centerY;
    [leftView addSubview:leftLb];
    
    UITextField *phoneNumTf = [[UITextField alloc] init];
    phoneNumTf.delegate = self;
    phoneNumTf.backgroundColor = [UIColor whiteColor];
    phoneNumTf.placeholder = @"请输入您的手机号";
    phoneNumTf.font = [UIFont systemFontOfSize:15.f];
    [phoneNumTf setValue:[UIColor getUsualColorWithString:@"#C5C9D1"] forKeyPath:@"placeholderLabel.textColor"];
    phoneNumTf.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumTf.leftView = leftView;
    phoneNumTf.leftViewMode = UITextFieldViewModeAlways;
    phoneNumTf.delegate = self;
    [phoneNumTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phoneNumTf];
    [phoneNumTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(SafeAreaTopHeight + 10 * AutoSizeScaleY);
        make.left.right.equalTo(self.view);
        make.height.equalTo(45* AutoSizeScaleY);
    }];
    self.phoneNumTf = phoneNumTf;
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#F1F1F1"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneNumTf.mas_bottom);
        make.left.right.equalTo(phoneNumTf);
        make.height.equalTo(1);
    }];
    
    UIButton * getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [getCodeBtn setTitleColor:[UIColor getUsualColorWithString:@"#FF5445"] forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    self.getCodeBtn = getCodeBtn;
    getCodeBtn.frame = CGRectMake(0, 0, 120 * AutoSizeScaleX, 30* AutoSizeScaleY);
    
    UIView * leftView1 = [[UIView alloc] init];
    leftView1.frame = CGRectMake(0, 0, 103 * AutoSizeScaleX, 45 * AutoSizeScaleX);
    UILabel * leftLb1 = [[UILabel alloc] init];
    leftLb1.frame = CGRectMake(14 * AutoSizeScaleX, 0, 0, 45 * AutoSizeScaleX);
    leftLb1.text = @"验证码";
    leftLb1.textColor = [UIColor getUsualColorWithString:@"#323232"];
    leftLb1.font = [UIFont systemFontOfSize:15.f];
    [leftLb1 sizeToFit];
    leftLb1.centerY = leftView1.centerY;
    [leftView1 addSubview:leftLb1];
    
    UITextField *codeTf = [[UITextField alloc] init];
    codeTf.delegate = self;
    codeTf.backgroundColor = [UIColor whiteColor];
    codeTf.placeholder = @"请输入验证码";
    codeTf.font = [UIFont systemFontOfSize:15.f];
    [codeTf setValue:[UIColor getUsualColorWithString:@"#C5C9D1"] forKeyPath:@"placeholderLabel.textColor"];
    codeTf.leftView = leftView1;
    codeTf.leftViewMode = UITextFieldViewModeAlways;
    codeTf.keyboardType = UIKeyboardTypeNumberPad;
    codeTf.delegate = self;
    [codeTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    codeTf.rightView = getCodeBtn;
    codeTf.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:codeTf];
    [codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom);
        make.left.right.height.equalTo(phoneNumTf);
        
    }];
    self.codeTf = codeTf;
    
    UIView * line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor getUsualColorWithString:@"#DDDDDD"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(codeTf.mas_bottom);
        make.left.right.height.equalTo(line);
    }];
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    [loginBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"确认" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    ZViewBorderRadius(loginBtn, 5, 0, [UIColor getUsualColorWithString:@"#FF5445"]);
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- SafeAreaBottomHeight - 20* AutoSizeScaleY);
        make.left.equalTo(28* AutoSizeScaleX);
        make.right.equalTo(-28* AutoSizeScaleX);
        make.centerX.equalTo(self.view);
        make.height.equalTo(45* AutoSizeScaleY);
    }];
    
}
#pragma mark ======  获取验证码  ======
- (void)getCodeBtnClick:(UIButton *)btn{
    
    if (self.phoneNumTf.text.length == 0) {
        
        [self showHint:@"请输入手机号"];
        return;
    }
    if (![NSString checkPhone:self.phoneNumTf.text]){
        
        [self showHint:@"手机号不正确"];
        return;
    }
    
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
    
    
//    [[BMHttpsMethod httpMethodManager] getCodeWithUserid:UserID Type:@"2" Phone:self.phoneNumTf.text ToGetResult:^(id  _Nonnull data) {
//
//        if ([data[@"code"] isEqualToNumber:@0]) {
//
//            [self showHint:@"发送成功"];
//            //发送成功
//            __block NSInteger second = 60;
//            //全局队列    默认优先级
//            dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//            //定时器模式  事件源
//            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
//
//            self.timer = timer;
//
//            //NSEC_PER_SEC是秒，＊1是每秒
//            dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
//            //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
//            dispatch_source_set_event_handler(timer, ^{
//                //回调主线程，在主线程中操作UI
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (second >= 0) {
//                        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%lds",(long)second] forState:UIControlStateNormal];
//                        second--;
//                        self.getCodeBtn.enabled = NO;
//                    }
//                    else
//                    {
//                        //这句话必须写否则会出问题
//                        dispatch_source_cancel(timer);
//                        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                        self.getCodeBtn.enabled = YES;
//                    }
//                });
//            });
//            //启动源
//            dispatch_resume(timer);
//        }else{
//
//            [self showHint:@"发送失败"];
//        }
//    }];
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
#pragma mark ======  登录  ======
- (void)loginBtnClick:(UIButton *)btn{
    
    if (self.phoneNumTf.text.length == 0) {
        
        [self showHint:@"请输入手机号"];
        return;
    }
    if (![NSString checkPhone:self.phoneNumTf.text]){
        
        [self showHint:@"手机号不正确"];
        return;
    }
    if (self.codeTf.text.length == 0) {
        
        [self showHint:@"请输入验证码"];
        return;
    }
    
    if (self.codeTf.text.length != 4){
        
        [self showHint:@"验证码不正确"];
        return;
    }
    [[BMHttpsMethod httpMethodManager] userLoginWithPhoneNo:self.phoneNumTf.text CheckCode:self.codeTf.text QqOpenid:self.qqOpenid WechatOpenid:self.wechatOpenid NickName:self.nickName PicUrl:self.picUrl Gender:self.gender ToGetResult:^(id  _Nonnull data) {
        
        LHLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            UserModel * user = [UserModel mj_objectWithKeyValues:data[@"data"][@"user"]];
            [[BMUserInfoManager sharedManager] saveUser:user];
            
            [JPUSHService setAlias:[NSString stringWithFormat:@"jpush%@",UserID] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
                MyLog(@"%@",iAlias);
            } seq:0];
            [CommonMethod setupBaseUI];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
    
    
//    [[BMHttpsMethod httpMethodManager] loginBindPhonekWithUserid:self.user.userId Code:self.codeTf.text Phone:self.phoneNumTf.text ToGetResult:^(id  _Nonnull data) {
//
//        if ([data[@"code"] isEqualToNumber:@0]) {
//
//            //新用户
//            [[BMUserInfoManager sharedManager] saveUser:self.user];
//            if ([self.user.newuser isEqualToString:@"1"]) {
//
//                //新用户
//                BMNewUserGuideViewController * new = [[BMNewUserGuideViewController alloc] init];
//                [self.navigationController pushViewController:new animated:YES];
//            }else{
//
//                //老用户
//                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                [BMCommonMethod setupBaseUIWithDelegate:appDelegate Interest:@""];
//            }
//
//        }else{
//
//            [self showHint:data[@"msg"]];
//        }
//    }];
    
    
}
#pragma mark ======  textFieldDelegate  ======

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.phoneNumTf) {
        
        if (textField.text.length > 10 && ![string isEqualToString:@""]){
            return NO;
        }
    }
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
