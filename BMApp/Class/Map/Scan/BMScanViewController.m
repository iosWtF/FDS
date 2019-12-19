//
//  BMScanViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMScanViewController.h"

#import "LBXScanViewController.h"
#import "LBXScanVideoZoomView.h"
#import "LBXPermission.h"
#import "LBXPermissionSetting.h"
#import "StyleDIY.h"

#import "BMDeviceModel.h"
#import "BMEditDeviceViewController.h"
@interface BMScanViewController ()

@property (nonatomic, strong) LBXScanVideoZoomView *zoomView;
@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UILabel *tipLb1;
@property (nonatomic, strong) BMDeviceModel *device;
@end

@implementation BMScanViewController
- (WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.style = [StyleDIY qqStyle];
    self.isVideoZoom = YES;
    [self setupNav];
    [self setupTipLb];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor blackColor];
    
    //设置扫码后需要扫码图像
    self.isNeedScanImage = YES;
}

- (void)setupNav{
    
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
    self.customNavBar.title = @"扫一扫";
    [self.customNavBar wr_setRightButtonWithTitle:@"相册" titleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    ZWeakSelf(self);
    self.customNavBar.onClickRightButton = ^{
        
        [weakself rightBtnClick:weakself.customNavBar.rightButton];
    };
    
}
- (void)rightBtnClick:(UIButton *)btn{
    
    __weak __typeof(self) weakSelf = self;
    [LBXPermission authorizeWithType:LBXPermissionType_Photos completion:^(BOOL granted, BOOL firstTime) {
        if (granted) {
            [weakSelf openLocalPhoto:NO];
        }
        else if (!firstTime )
        {
            [LBXPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相册权限，是否前往设置" cancel:@"取消" setting:@"设置"];
        }
    }];
}
- (void)setupTipLb{
    
    UILabel * tipLb = [[UILabel alloc] init];
    tipLb.textAlignment = NSTextAlignmentCenter;
    tipLb.text = @"将二维码/条码放入框中，即可自动扫描";
    tipLb.textColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    tipLb.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:tipLb];
    [tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- 142 * AutoSizeScaleY - SafeAreaBottomHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(14 * AutoSizeScaleY);
    }];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    [self drawBottomItems];
    //    [self drawTitle];
    //    [self.view bringSubviewToFront:_topTitle];
    [self.view bringSubviewToFront:self.tipLb];
    
    [self.view bringSubviewToFront:self.customNavBar];
}

//绘制扫描区域
- (void)drawTitle
{
    if (!_topTitle)
    {
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, 145, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 50);
        
        //3.5inch iphone
        if ([UIScreen mainScreen].bounds.size.height <= 568 )
        {
            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 38);
            _topTitle.font = [UIFont systemFontOfSize:14];
        }
        
        
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
}

- (void)cameraInitOver
{
    if (self.isVideoZoom) {
        [self zoomView];
    }
}

- (LBXScanVideoZoomView*)zoomView
{
    if (!_zoomView)
    {
        
        CGRect frame = self.view.frame;
        
        int XRetangleLeft = self.style.xScanRetangleOffset;
        
        CGSize sizeRetangle = CGSizeMake(frame.size.width - XRetangleLeft*2, frame.size.width - XRetangleLeft*2);
        
        if (self.style.whRatio != 1)
        {
            CGFloat w = sizeRetangle.width;
            CGFloat h = w / self.style.whRatio;
            
            NSInteger hInt = (NSInteger)h;
            h  = hInt;
            
            sizeRetangle = CGSizeMake(w, h);
        }
        
        CGFloat videoMaxScale = [self.scanObj getVideoMaxScale];
        
        //扫码区域Y轴最小坐标
        CGFloat YMinRetangle = frame.size.height / 2.0 - sizeRetangle.height/2.0 - self.style.centerUpOffset;
        CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
        
        CGFloat zoomw = sizeRetangle.width + 40;
        _zoomView = [[LBXScanVideoZoomView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-zoomw)/2, YMaxRetangle + 40, zoomw, 18)];
        
        [_zoomView setMaximunValue:videoMaxScale/4];
        
        
        __weak __typeof(self) weakSelf = self;
        _zoomView.block= ^(float value)
        {
            [weakSelf.scanObj setVideoScale:value];
        };
        [self.view addSubview:_zoomView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.view addGestureRecognizer:tap];
    }
    
    return _zoomView;
    
}

- (void)tap
{
    _zoomView.hidden = !_zoomView.hidden;
}

- (void)drawBottomItems
{
    if (_bottomItemsView) {
        
        return;
    }
    
    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,
                                                                   CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    [self.view addSubview:_bottomItemsView];
    
    CGSize size = CGSizeMake(65, 87);
    self.btnFlash = [[UIButton alloc]init];
    _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/2, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnPhoto = [[UIButton alloc]init];
    _btnPhoto.bounds = _btnFlash.bounds;
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/4, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnMyQR = [[UIButton alloc]init];
    _btnMyQR.bounds = _btnFlash.bounds;
    _btnMyQR.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 3/4, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_nor"] forState:UIControlStateNormal];
    [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_down"] forState:UIControlStateHighlighted];
    [_btnMyQR addTarget:self action:@selector(myQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
    [_bottomItemsView addSubview:_btnMyQR];
    
}

- (void)showError:(NSString*)str
{
    
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //震动提醒
    // [LBXScanWrapper systemVibrate];
    //声音提醒
    //[LBXScanWrapper systemSound];
    [self popAlertMsgWithScanResult:strResult];
    //    [self showNextVCWithScanResult:scanResult];
    
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    
    MyLog(@"%@",strResult);
    if (!strResult) {
        
        strResult = @"识别失败";
        [self performSelector:@selector(reStartDevice) withObject:nil afterDelay:2.0];
        [self showHint:@"识别失败,请重新扫描"];
        return;
    }
    if ([self.type isEqualToString:@"添加设备"]) {
        
        [[BMHttpsMethod httpMethodManager] clusterBindingDeviceWithClusterId:self.cluModel.Id Imei:strResult ToGetResult:^(id  _Nonnull data) {
            
            LHLog(@"%@",data);
            [self performSelector:@selector(reStartDevice) withObject:nil afterDelay:2.0];
            if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                
                [self showHint:@"添加设备成功"];
                self.device = [BMDeviceModel mj_objectWithKeyValues:data[@"data"]];
                self.device.imei = strResult;
                BMEditDeviceViewController * edit = [[BMEditDeviceViewController alloc] init];
                edit.device = self.device;
                [self.navigationController pushViewController:edit animated:YES];
            }else{
                
                [self showHint:data[@"errorMsg"]];
            }
        }];
    }else{
        
        if ([self.ower isEqualToString:@"1"]) {
            
            //群主
            NSArray * style = [strResult componentsSeparatedByString:@":"];
            if ([style[0] isEqualToString:@"qz"]) {
                
                [[BMHttpsMethod httpMethodManager] clusterUserSaveWithUserId:UserID ClusterId:style[1] ToGetResult:^(id  _Nonnull data) {
                    
                    [self performSelector:@selector(reStartDevice) withObject:nil afterDelay:2.0];
                    if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                        
                        [self showHint:@"加入群组成功"];
                        [Z_NotificationCenter postNotificationName:@"changeGroupInfo" object:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else{
                        
                        [self showHint:data[@"errorMsg"]];
                    }
                }];
                
            }else if([style[0] isEqualToString:@"cy"]){
                
                [[BMHttpsMethod httpMethodManager] clusterUserSaveWithUserId:style[1] ClusterId:self.cluModel.Id ToGetResult:^(id  _Nonnull data) {
                    
                    [self performSelector:@selector(reStartDevice) withObject:nil afterDelay:2.0];
                    if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                        
                        [self showHint:@"邀请成员成功"];
                        [Z_NotificationCenter postNotificationName:@"changeGroupInfo" object:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else{
                        
                        [self showHint:data[@"errorMsg"]];
                    }
                    
                }];
            }else{
                
                //添加设备
                [[BMHttpsMethod httpMethodManager] clusterBindingDeviceWithClusterId:self.cluModel.Id Imei:strResult ToGetResult:^(id  _Nonnull data) {
                    
                    LHLog(@"%@",data);
                    [self performSelector:@selector(reStartDevice) withObject:nil afterDelay:2.0];
                    if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                        
                        [self showHint:@"添加设备成功"];
                        self.device = [BMDeviceModel mj_objectWithKeyValues:data[@"data"]];
                        self.device.imei = strResult;
                        BMEditDeviceViewController * edit = [[BMEditDeviceViewController alloc] init];
                        edit.device = self.device;
                        [self.navigationController pushViewController:edit animated:YES];
                    }else{
                        
                        [self showHint:data[@"errorMsg"]];
                    }
                }];
                
                
            }

        }else{
            
            //成员
            NSArray * style = [strResult componentsSeparatedByString:@":"];
            if ([style[0] isEqualToString:@"qz"]) {
                
                [[BMHttpsMethod httpMethodManager] clusterUserSaveWithUserId:UserID ClusterId:style[1] ToGetResult:^(id  _Nonnull data) {
                    
                    [self performSelector:@selector(reStartDevice) withObject:nil afterDelay:2.0];
                    if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                        
                        [self showHint:@"加入群组成功"];
                        [Z_NotificationCenter postNotificationName:@"changeGroupInfo" object:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else{
                        
                        [self showHint:data[@"errorMsg"]];
                    }
                    
                }];
                
            }else if([style[0] isEqualToString:@"cy"]){
                
                [self performSelector:@selector(reStartDevice) withObject:nil afterDelay:2.0];
                [self showHint:@"您没有权限,请联系群主添加"];
                
            }else{
                
                //添加设备
                [self performSelector:@selector(reStartDevice) withObject:nil afterDelay:2.0];
                [self showHint:@"您没有权限,请联系群主添加"];
            }
        }
        
        
    }
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    //    ScanResultViewController *vc = [ScanResultViewController new];
    //    vc.imgScan = strResult.imgScanned;
    //
    //    vc.strScan = strResult.strScanned;
    //
    //    vc.strCodeType = strResult.strBarCodeType;
    //
    //    [self.navigationController pushViewController:vc animated:YES];
    
    
}


#pragma mark -底部功能项
//打开相册
- (void)openPhoto
{
    __weak __typeof(self) weakSelf = self;
    [LBXPermission authorizeWithType:LBXPermissionType_Photos completion:^(BOOL granted, BOOL firstTime) {
        if (granted) {
            [weakSelf openLocalPhoto:NO];
        }
        else if (!firstTime )
        {
            [LBXPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相册权限，是否前往设置" cancel:@"取消" setting:@"设置"];
        }
    }];
}

//开关闪光灯
- (void)openOrCloseFlash
{
    [super openOrCloseFlash];
    
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}


#pragma mark -底部功能项


- (void)myQRCode
{
    //    CreateBarCodeViewController *vc = [CreateBarCodeViewController new];
    //    [self.navigationController pushViewController:vc animated:YES];
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
