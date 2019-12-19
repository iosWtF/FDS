//
//  BMLoginViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMLoginViewController.h"

#import "DHGuidePageHUD.h"
#import "BMBindPhoneViewController.h"
#import "BMLoginModel.h"
#import "BMAgreeViewController.h"
@interface BMLoginViewController ()<UITextFieldDelegate,TTTAttributedLabelDelegate>

@property (nonatomic,strong) id timer;
@property(nonatomic ,strong)UIImageView * logoImgView;
@property(nonatomic ,strong)UIButton * getCodeBtn;
@property(nonatomic ,strong)UITextField * phoneNumTf;
@property(nonatomic ,strong)UITextField * codeTf;
@end

@implementation BMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.customNavBar.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.customNavBar wr_setBackgroundAlpha:0];
    
//    if (![USER_DEFAULT boolForKey:@"AdShow"]) {
//
//        [USER_DEFAULT setBool:YES forKey:@"AdShow"];
//        // 静态引导页
//        [self setStaticGuidePage];
//    }else{
//
//
//    }
    [self setupUI];
    [self configData];
}
- (void)setStaticGuidePage{
    
//    [[BMHttpsMethod httpMethodManager] getStartUpAdWithUserid:UserID Bussid:@"" ToGetResult:^(id  _Nonnull data) {
//
//        if ([data[@"code"] isEqualToNumber:@0]) {
//
//            MyLog(@"广告数据 = %@",data[@"data"][@"img1"]);
//            //            NSLog(@"广告数据 = %@",data[@"data"]);
//            NSArray *imageNameArray = @[[NSString stringWithFormat:@"%@%@",BaseURL,data[@"data"][@"img1"]],[NSString stringWithFormat:@"%@%@",BaseURL,data[@"data"][@"img2"]],[NSString stringWithFormat:@"%@%@",BaseURL,data[@"data"][@"img3"]]];
//            DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
//            guidePage.slideInto = YES;
//            [self.navigationController.view addSubview:guidePage];
//
//        }
//        [self setupUI];
//
//    }];
}

- (void)configData{
    

    [[BMHttpsMethod httpMethodManager] settingGetSettingToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            NSLog(@"广告数据 = %@",data[@"data"]);
            [self.logoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data[@"data"][@"logoUrl"]]] placeholderImage:nil];
        }
        
    }];
}

- (void)setupUI{
    
    UIImageView * iconImgView = [[UIImageView alloc] init];
    //    [iconImgView setBackgroundColor:[UIColor getUsualColorWithString:@"#FF5445"]];
    iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    ZViewBorderRadius(iconImgView, 77 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    [self.view addSubview:iconImgView];
    [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(77 * AutoSizeScaleX, 77 * AutoSizeScaleX));
        make.top.equalTo(self.view).offset(SafeAreaTopHeight + 5 * AutoSizeScaleY);
    }];
    self.logoImgView = iconImgView;
    
    for (int i = 0; i < 2; i ++) {
        
        UIView * leftView = [[UIView alloc] init];
        leftView.frame = CGRectMake(0, 0, 0, 30);
        leftView.tag = i + 10;
        UIImageView * leftImgView = [[UIImageView alloc] init];
        leftImgView.frame = CGRectMake(0, 0, 30, 30);
        [leftView addSubview:leftImgView];
    }
    UITextField *phoneNumTf = [[UITextField alloc] init];
    phoneNumTf.placeholder = @"请输入手机号";
    phoneNumTf.font = [UIFont systemFontOfSize:18.f];
    [phoneNumTf setValue:[UIColor getUsualColorWithString:@"#B6B6B6"] forKeyPath:@"placeholderLabel.textColor"];
    phoneNumTf.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumTf.leftView = [self.view viewWithTag:10];
    phoneNumTf.leftViewMode = UITextFieldViewModeAlways;
    phoneNumTf.delegate = self;
    [phoneNumTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phoneNumTf];
    [phoneNumTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(iconImgView.mas_bottom).offset(50* AutoSizeScaleY);
        make.left.equalTo(30* AutoSizeScaleX);
        make.right.equalTo(- 30* AutoSizeScaleX);
        make.height.equalTo(50* AutoSizeScaleY);
    }];
    self.phoneNumTf = phoneNumTf;
    
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
    [getCodeBtn setTitleColor:[UIColor getUsualColorWithString:@"#000000"] forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    self.getCodeBtn = getCodeBtn;
    getCodeBtn.frame = CGRectMake(0, 0, 120* AutoSizeScaleX, 30* AutoSizeScaleY);
    
    UITextField *codeTf = [[UITextField alloc] init];
    codeTf.placeholder = @"请输入短信验证码";
    codeTf.font = [UIFont systemFontOfSize:18.f];
    [codeTf setValue:[UIColor getUsualColorWithString:@"#B6B6B6"] forKeyPath:@"placeholderLabel.textColor"];
    codeTf.leftView = [self.view viewWithTag:11];
    codeTf.leftViewMode = UITextFieldViewModeAlways;
    [codeTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    codeTf.rightView = getCodeBtn;
    codeTf.rightViewMode = UITextFieldViewModeAlways;
    codeTf.delegate = self;
    codeTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:codeTf];
    [codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom).offset(13* AutoSizeScaleY);
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
    [loginBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#446EDD"]];
    [loginBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
    ZViewBorderRadius(loginBtn, 25* AutoSizeScaleY, 0, [UIColor whiteColor]);
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(codeTf.mas_bottom).offset(30* AutoSizeScaleY);
        make.left.equalTo(30* AutoSizeScaleX);
        make.right.equalTo(-30* AutoSizeScaleX);
        make.centerX.equalTo(self.view);
        make.height.equalTo(50* AutoSizeScaleY);
    }];
    
    UILabel * tipLb = [[UILabel alloc] init];
    tipLb.textColor = [UIColor getUsualColorWithString:@"#B6B6B6"];
    tipLb.font = [UIFont systemFontOfSize:14.f];
    tipLb.textAlignment = NSTextAlignmentCenter;
    tipLb.text = @"手机号快捷登录，未创建手机号将自动创建账号";
    [self.view addSubview:tipLb];
    [tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(loginBtn.mas_bottom).offset(7* AutoSizeScaleY);
        make.left.right.equalTo(self.view);
    }];
    
    NSString *text=@"登录即代表您已经同意《用户注册协议》";
    TTTAttributedLabel *agreeLb = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    agreeLb.font = [UIFont systemFontOfSize:12.f];
    agreeLb.numberOfLines = 0;
    agreeLb.textColor = [UIColor getUsualColorWithString:@"#B6B6B6"];
    agreeLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:agreeLb];
    [agreeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset(- SafeAreaBottomHeight - 30* AutoSizeScaleY);
        make.left.right.equalTo(line);
    }];
    agreeLb.text=text;
    agreeLb.delegate=self;
    //设置行间距
    agreeLb.lineSpacing = 8;
    //可自动识别url，显示为蓝色+下划线
    agreeLb.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    //此属性可以不显示下划线，点击的颜色默认为红色
    agreeLb.linkAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithBool:NO],(NSString *)kCTUnderlineStyleAttributeName,nil];
    //此属性可以改变点击的颜色
    agreeLb.activeLinkAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor purpleColor],(NSString *)kCTForegroundColorAttributeName,nil];
    //设置需要点击的文字的颜色大小
    [agreeLb setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        
        
        //得到需要点击的文字的位置
        NSRange selRange=[text rangeOfString:@"《用户注册协议》"];
        //设定可点击文字的的大小
        UIFont *selFont=[UIFont systemFontOfSize:12.f];
        CTFontRef selFontRef = CTFontCreateWithName((__bridge CFStringRef)selFont.fontName, selFont.pointSize, NULL);
        
        //设置可点击文本的大小
        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)selFontRef range:selRange];
        
        //设置可点击文本的颜色
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor getUsualColorWithString:@"#FF5445"] CGColor] range:selRange];
        
        //设置可点击文本的背景颜色
        if (@available(iOS 10.0, *)) {
            [mutableAttributedString addAttribute:(NSString*)kCTBackgroundColorAttributeName value:(id)[[UIColor whiteColor] CGColor] range:selRange];
        } else {
            // Fallback on earlier versions
        }
        CFRelease(selFontRef);
        return mutableAttributedString;
    }];
    
    //添加点击事件
    NSRange selRange=[text rangeOfString:@"《用户注册协议》"];
    [agreeLb addLinkToTransitInformation:@{@"select":@"《用户注册协议》"} withRange:selRange];
    //给 电话号码 添加点击事件
    //    NSRange telRange=[text rangeOfString:@"15112345678"];
    //    [label addLinkToPhoneNumber:@"15112345678" withRange:telRange];
    //    //给  时间  添加点击事件
    //    NSRange dateRange=[text rangeOfString:@"2017-05-06"];
    //    [label addLinkToDate:[NSDate date] withRange:dateRange];
    //    //给  天安门  添加点击事件
    //    NSRange addressRange=[text rangeOfString:@"天安门"];
    //    [label addLinkToAddress:@{@"address":@"天安门",@"longitude":@"116.2354",@"latitude":@"38.2145"} withRange:addressRange];
    UIButton * tencentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tencentBtn setTitleColor:[UIColor getUsualColorWithString:@"#999999"] forState:UIControlStateNormal];
    [tencentBtn setTitle:@"QQ" forState:UIControlStateNormal];
    tencentBtn.titleLabel.font = [UIFont systemFontOfSize:11.];
    [tencentBtn setImage:[UIImage imageNamed:@"login_btn_qq"] forState:UIControlStateNormal];
    tencentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [tencentBtn addTarget:self action:@selector(tencentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tencentBtn];
    [tencentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(agreeLb.mas_top).offset(- 48* AutoSizeScaleY);
        make.size.equalTo(CGSizeMake(50* AutoSizeScaleX, 60* AutoSizeScaleY));
        make.left.equalTo(self.view.mas_centerX).offset(25 * AutoSizeScaleX);
    }];
    [tencentBtn setImagePositionWithType:SSImagePositionTypeTop spacing:4];
    
    UIButton * wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatBtn setImage:[UIImage imageNamed:@"login_btn_wechat"] forState:UIControlStateNormal];
    [wechatBtn setTitleColor:[UIColor getUsualColorWithString:@"#999999"] forState:UIControlStateNormal];
    [wechatBtn setTitle:@"微信" forState:UIControlStateNormal];
    wechatBtn.titleLabel.font = [UIFont systemFontOfSize:11.f];
    wechatBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [wechatBtn addTarget:self action:@selector(wechatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(tencentBtn);
        make.size.equalTo(tencentBtn);
        make.right.equalTo(self.view.mas_centerX).offset(- 25* AutoSizeScaleY);
    }];
    [wechatBtn setImagePositionWithType:SSImagePositionTypeTop spacing:4];
    
    UILabel * thirdLoginLb = [[UILabel alloc] init];
    thirdLoginLb.text = @"其他登录方式";
    thirdLoginLb.textColor = [UIColor getUsualColorWithString:@"#B6B6B6"];
    thirdLoginLb.font = [UIFont systemFontOfSize:14.f];
    [thirdLoginLb sizeToFit];
    [self.view addSubview:thirdLoginLb];
    [thirdLoginLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(wechatBtn.mas_top).offset(- 24* AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        
    }];
    
    UIView * line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor getUsualColorWithString:@"#F1F1F1"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(40* AutoSizeScaleX);
        make.centerY.equalTo(thirdLoginLb);
        make.right.equalTo(thirdLoginLb.mas_left).offset(- 21* AutoSizeScaleX);
        make.height.equalTo(1);
    }];
    
    UIView * line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor getUsualColorWithString:@"#F1F1F1"];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(thirdLoginLb.mas_right).offset(21* AutoSizeScaleX);
        make.centerY.equalTo(line2);
        make.right.equalTo(self.view).offset(-40* AutoSizeScaleX);
        make.height.equalTo(line2);
    }];
}


#pragma TTTAttributedLabel Delegate
//文字的点击事件
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    
    MyLog(@"点击协议");
    BMAgreeViewController * agree = [[BMAgreeViewController alloc] init];
    [self.navigationController pushViewController:agree animated:YES];
    
}
//文字的长按事件
- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithURL:(NSURL *)url atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithURL  :%@",url);
}
- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithDate:(NSDate *)date atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithDate  :%@",date);
    
}
- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithAddress:(NSDictionary *)addressComponents atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithAddress  :%@",addressComponents);
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithPhoneNumber:(NSString *)phoneNumber atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithPhoneNumber  :%@",phoneNumber);
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithTransitInformation:(NSDictionary *)components atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithTransitInformation  :%@",components);
    
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
    
    [[BMHttpsMethod httpMethodManager] userGetCheckCodeWithPhoneNo:self.phoneNumTf.text Type:@"1" ToGetResult:^(id  _Nonnull data) {
       
        
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
    [[BMHttpsMethod httpMethodManager] userLoginWithPhoneNo:self.phoneNumTf.text CheckCode:self.codeTf.text QqOpenid:@"" WechatOpenid:@"" NickName:@"" PicUrl:@"" Gender:@"" ToGetResult:^(id  _Nonnull data) {
        
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
}

- (void)loginWithType:(NSInteger )index{
    
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:index currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            MyLog(@"%@",error);
            [self showHint:@"登陆失败!"];
        } else {
            
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            NSString * type ;
            if (index == 1) {
                
                type = @"2";
            }else if (index == 4){
                
                type = @"3";
            }
            NSString * sex;
            if ([resp.gender isEqualToString:@"f"] || [resp.gender isEqualToString:@"女"] ) {
                
                sex = @"2";
            }else if ([resp.gender isEqualToString:@"m"]|| [resp.gender isEqualToString:@"男"]){
                
                sex = @"1";
            }else{
                
                sex = @"";
            }
            NSString *number = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
            NSString * qqOpenId = @"";
            NSString * wehchatOpenId = @"";
            if (index == 1) {
                
                qqOpenId = resp.openid;
            }else if (index == 4){
                
                wehchatOpenId = resp.openid;
            }
            
            [[BMHttpsMethod httpMethodManager] userRedirectWithQqOpenid:qqOpenId WechatOpenid:wehchatOpenId ToGetResult:^(id  _Nonnull data) {
               
                if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                    
                    UserModel * user = [UserModel mj_objectWithKeyValues:data[@"data"][@"user"]];
                    [[BMUserInfoManager sharedManager] saveUser:user];
                    
                    [JPUSHService setAlias:[NSString stringWithFormat:@"jpush%@",UserID] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                        
                        MyLog(@"%@",iAlias);
                    } seq:0];
                    [CommonMethod setupBaseUI];
                }else if ([data[@"errorCode"] isEqualToString:@"0002"]){
                    
                    BMBindPhoneViewController * bind = [[BMBindPhoneViewController alloc] init];
                    bind.qqOpenid = qqOpenId;
                    bind.wechatOpenid = wehchatOpenId;
                    bind.nickName = resp.name;
                    bind.gender = sex;
                    bind.picUrl = resp.iconurl;
                    [self.navigationController pushViewController:bind animated:YES];
                }else{
                    
                    [self showHint:data[@"errorMsg"]];
                }
            }];
            
            
            
            
        }
    }];
}

#pragma mark ======  微信登录  ======
- (void)wechatBtnClick:(UIButton *)btn{
    
    [self loginWithType:1];
}
#pragma mark ======  QQ登录  ======
- (void)tencentBtnClick:(UIButton *)btn{
    
    [self loginWithType:4];
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
- (void)viewWillAppear:(BOOL)animated{
    
    [self wr_setNavBarShadowImageHidden:YES];
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = YES;
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
