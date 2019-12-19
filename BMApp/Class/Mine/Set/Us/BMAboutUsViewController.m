//
//  BMAboutUsViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMAboutUsViewController.h"

@interface BMAboutUsViewController ()

@property(nonatomic ,strong)UIImageView * logoImgView;
@property(nonatomic ,strong)UILabel * nameLb;
@property(nonatomic ,strong)UILabel * versionLb;

@end

@implementation BMAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"关于我们";
    [self setupUI];
    
    [self configData];
}

- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] settingGetSettingToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self.logoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data[@"data"][@"logoUrl"]]] placeholderImage:nil];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        
    }];
    
}

- (void)setupUI{
    
    UIImageView * logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    logoImgView.contentMode = UIViewContentModeScaleAspectFill;
    logoImgView.clipsToBounds = YES;
    
    [self.view addSubview:logoImgView];
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight + 52 * AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(96 * AutoSizeScaleX, 96 * AutoSizeScaleX));
    }];
    self.logoImgView = logoImgView;
    
    UILabel * nameLb = [[UILabel alloc] init];
    nameLb.text = @"DC智能书包";
    nameLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
    nameLb.font = [UIFont systemFontOfSize:18.f];
    nameLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(logoImgView.mas_bottom).offset(11 * AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        make.height.equalTo(20 * AutoSizeScaleY);
    }];
    self.nameLb = nameLb;
    
    UILabel * versionLb = [[UILabel alloc] init];
    versionLb.text = @"版本号:1.0";
    versionLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
    versionLb.font = [UIFont systemFontOfSize:14.f];
    versionLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLb];
    [versionLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameLb.mas_bottom).offset(10 * AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        make.height.equalTo(12 * AutoSizeScaleY);
    }];
    self.versionLb = versionLb;
    
    UILabel * rightLb = [[UILabel alloc] init];
    rightLb.text = @"@江苏大晨文具用品有限公司版权所有";
    rightLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
    rightLb.font = [UIFont systemFontOfSize:12.f];
    rightLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightLb];
    [rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- 27 * AutoSizeScaleY - SafeAreaBottomHeight);
        make.centerX.equalTo(self.view);
        make.height.equalTo(12 * AutoSizeScaleY);
    }];
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
