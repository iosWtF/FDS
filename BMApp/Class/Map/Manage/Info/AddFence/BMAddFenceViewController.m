//
//  BMAddFenceViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMAddFenceViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "STPickerSingle.h"
@interface BMAddFenceViewController ()<UITextFieldDelegate,AMapLocationManagerDelegate,MAMapViewDelegate,STPickerSingleDelegate>

@property(nonatomic ,strong)NSArray * arrData;
@property(nonatomic ,assign)int radius;
@property(nonatomic ,strong)UITextField * searchTf;
@property (nonatomic, strong) MAMapView            *mapView;
@property (nonatomic, strong) UIImageView          *centerAnnotationView;
@property (nonatomic, assign) BOOL                  isLocated;
@property (nonatomic, strong) MACircle * circle;

@property (nonatomic, strong) UIButton * radiusBtn;

@property (nonatomic, strong) UILabel * loctionLb;
@property (nonatomic, strong) UITextField * nameTf;
@property (nonatomic, strong) STPickerSingle *pickerSingle;
@end

@implementation BMAddFenceViewController

#pragma mark ======  切换区域范围  ======

- (void)changeRadius{
    
    [self.pickerSingle show];
}
#pragma mark ======  STPickerDelegate  ======
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    //    NSString *text = [NSString stringWithFormat:@"%@ 人民币", selectedTitle];
    //    self.textSingle.text = text;
    
    NSArray * circleArr =@[@300,@400,@500,@600,@700,@800,@900,@1000,@1100,@1200,@1300,@1400,@1500];
    NSInteger i = [self.arrData indexOfObject:selectedTitle];
    self.radius = [circleArr[i] intValue];
    [self.circle setRadius:[circleArr[i] intValue]];
    [self.radiusBtn setTitle:selectedTitle forState:UIControlStateNormal];
    [self.radiusBtn setImagePositionWithType:SSImagePositionTypeRight spacing:3];
}
#pragma mark ======  完成  ======

- (void)finish{
    
    if (self.nameTf.text.length == 0) {
        
        [self showHint:@"请输入围栏名称"];
        return;
    }
    
    if ([NSString hasIllegalCharacter:self.nameTf.text]) {
        
        [self showHint:@"围栏名称不可包含非法字符"];
        return;
    }
    
    [[BMHttpsMethod httpMethodManager] fenceSaveWithClusterId:self.cluModel.Id Name:self.nameTf.text Position:self.loctionLb.text Longitude:[NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.longitude] Latitude:[NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.latitude] Radius:[NSString stringWithFormat:@"%d",self.radius] ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self showHint:@"添加围栏成功"];
            [Z_NotificationCenter postNotificationName:@"fenceChange" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        
        
    }];
    
}
- (STPickerSingle *)pickerSingle{
    
    if (!_pickerSingle) {
        
        
        STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
        pickerSingle.widthPickerComponent = Z_SCREEN_WIDTH;
        [pickerSingle setArrayData:[NSMutableArray arrayWithArray:self.arrData]];
        [pickerSingle setTitle:@"请选择区域范围"];
        //        [pickerSingle setTitleUnit:@"人民币"];
        [pickerSingle setContentMode:STPickerContentModeBottom];
        [pickerSingle setDelegate:self];
        [pickerSingle.buttonLeft setTitle:@"取消" forState:UIControlStateNormal];
        [pickerSingle.buttonRight setTitle:@"完成" forState:UIControlStateNormal];
        pickerSingle.borderButtonColor = [UIColor whiteColor];
        _pickerSingle = pickerSingle;
    }
    return _pickerSingle;
}
- (void)setupUI{
    
    UITextField * nameTf = [[UITextField alloc] init];
    nameTf.frame =CGRectMake(17 * AutoSizeScaleX, SafeAreaTopHeight, Z_SCREEN_WIDTH - 34 * AutoSizeScaleX, 50 * AutoSizeScaleY);
    [nameTf setValue:[UIColor getUsualColorWithString:@"#333333"] forKeyPath:@"placeholderLabel.textColor"];
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 * AutoSizeScaleX, 50 * AutoSizeScaleY)];
    leftView.textColor = [UIColor getUsualColorWithString:@"#333333"];
    leftView.font = [UIFont systemFontOfSize:14.f];
    leftView.textAlignment = NSTextAlignmentLeft;
    leftView.text = @"围栏名称";
    nameTf.leftView = leftView;
    nameTf.leftViewMode = UITextFieldViewModeAlways;
    nameTf.delegate = self;
    nameTf.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    nameTf.placeholder = @"请输入围栏名称";
    nameTf.font = [UIFont systemFontOfSize:14.f];
    [nameTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:nameTf];
    self.nameTf = nameTf;
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(nameTf.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(1);
    }];
    
    UILabel * loctionLb = [[UILabel alloc] init];
    loctionLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
    loctionLb.font = [UIFont systemFontOfSize:14.f];
    loctionLb.textAlignment = NSTextAlignmentLeft;
//    loctionLb.text = @"浙江省杭州市滨江区新华书店（五一北路店）";
    [self.view addSubview:loctionLb];
    [loctionLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(line.mas_bottom);
        make.height.equalTo(50 * AutoSizeScaleY);
        make.left.equalTo(35 * AutoSizeScaleX);
    }];
    self.loctionLb = loctionLb;
    UIImageView * loctionImgView = [[UIImageView alloc] init];
    [loctionImgView setImage:[UIImage imageNamed:@"tianjia_icon_dizhi-1"]];
    [self.view addSubview:loctionImgView];
    [loctionImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(loctionLb);
        make.right.equalTo(loctionLb.mas_left).offset(- 6 * AutoSizeScaleX);
        make.size.equalTo(CGSizeMake(13 * AutoSizeScaleX, 15 * AutoSizeScaleX));
    }];
    [self initMapView];
    
    UIButton * radiusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [radiusBtn setTitle:@"半径500米内" forState:UIControlStateNormal];
    [radiusBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    radiusBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [radiusBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    ZViewBorderRadius( radiusBtn, 5, 0, [UIColor whiteColor]);
    [radiusBtn setImage:[UIImage imageNamed:@"ytianjia_sanjiao"] forState:UIControlStateNormal];
    [radiusBtn setImagePositionWithType:SSImagePositionTypeRight spacing:3];
    [radiusBtn addTarget:self action:@selector(changeRadius) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:radiusBtn];
    [radiusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.mapView).offset(100 * AutoSizeScaleY);
        make.centerX.equalTo(self.mapView);
        make.size.equalTo(CGSizeMake(114 * AutoSizeScaleX, 28 * AutoSizeScaleY));
    }];
    self.radiusBtn = radiusBtn;
    
    UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [finishBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    ZViewBorderRadius(finishBtn, 5, 0, [UIColor whiteColor]);
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- 24 * AutoSizeScaleY - SafeAreaBottomHeight);
        make.centerX.equalTo(self.mapView);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
    }];
}

#pragma mark - MapViewDelegate

- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager {
    
    [locationManager requestAlwaysAuthorization];
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (self.mapView.userTrackingMode == MAUserTrackingModeNone)
    {
        [self centerAnnotationAnimimate];
        [self.circle setCircleWithCenterCoordinate:self.mapView.centerCoordinate radius:self.radius];
        [self.mapView addOverlay:self.circle];
        [self setLocationWithLatitude:self.mapView.centerCoordinate.latitude AndLongitude:self.mapView.centerCoordinate.longitude];
    }
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        circleRenderer.lineWidth   = 0;
        circleRenderer.strokeColor = [UIColor whiteColor];
         circleRenderer.fillColor   = [[UIColor getUsualColorWithString:@"#0083FF"] colorWithAlphaComponent:0.1];
        
        return circleRenderer;
    }
    
    return nil;
}

#pragma mark - userLocation

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(!updatingLocation)
        return ;
    
    if (userLocation.location.horizontalAccuracy < 0)
    {
        return ;
    }
    
    // only the first locate used.
    if (!self.isLocated)
    {
        self.isLocated = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
        [self.circle setCircleWithCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude) radius:self.radius];
        [self.mapView addOverlay:self.circle];
        
        [self setLocationWithLatitude:userLocation.location.coordinate.latitude AndLongitude:userLocation.location.coordinate.longitude];
        
    }
}

- (void)mapView:(MAMapView *)mapView  didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
}


- (void)setLocationWithLatitude:(CLLocationDegrees)latitude AndLongitude:(CLLocationDegrees)longitude{
    
    NSString *latitudeStr = [NSString stringWithFormat:@"%f",latitude];
    NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
     [NSString stringWithFormat:@"%@,%@",latitudeStr,longitudeStr];
    //NSLog(@"%@",_mapCoordinate);
    //反编码 经纬度---->位置信息
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"反编码失败:%@",error);
            
        }else{
            //NSLog(@"反编码成功:%@",placemarks);
            CLPlacemark *placemark=[placemarks lastObject];
            //NSLog(@"%@",placemark.addressDictionary[@"FormattedAddressLines"]);
            NSDictionary *addressDic=placemark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            //NSLog(@"%@,%@,%@,%@",state,city,subLocality,street);
            NSString *strLocation;
            if (street.length == 0 || street == NULL || [street isEqualToString:@"(null)"]) {
                strLocation= [NSString stringWithFormat:@"%@%@%@",state,city,subLocality];
            }else{
                strLocation= [NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
            }
            
            self.loctionLb.text = strLocation;
        }
    }];

}


#pragma mark - Initialization

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight + 100 * AutoSizeScaleY + 1, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaBottomHeight - SafeAreaTopHeight - 100 * AutoSizeScaleY - 1)];
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.distanceFilter = 15.0f;
    [self.mapView setZoomLevel:15 animated:YES];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.isLocated = NO;
}

- (void)initCenterView
{
    self.centerAnnotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tianjia_icon_dizhi"]];
    //    self.centerAnnotationView.center = CGPointMake(self.mapView.center.x, self.mapView.center.y - CGRectGetHeight(self.centerAnnotationView.bounds) / 2);
    
    [self.mapView addSubview:self.centerAnnotationView];
    [self.centerAnnotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mapView.mas_centerX);
        make.centerY.equalTo(self.mapView.mas_centerY);
    }];
}
/* 移动窗口弹一下的动画 */
- (void)centerAnnotationAnimimate
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y -= 20;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y += 20;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"添加围栏";
    self.arrData = @[@"半径300米内",@"半径400米内",@"半径500米内",@"半径600米内",@"半径700米内",@"半径800米内",@"半径900米内",@"半径1000米内",@"半径1100米内",@"半径1200米内",@"半径1300米内",@"半径1400米内",@"半径1500米内"];
    self.radius = 500;
    self.circle = [[MACircle alloc] init];
    [self setupUI];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initCenterView];
}
#pragma mark textFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
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

- (void)textFieldDidChange:(UITextField *)textField{
    
    
        NSUInteger maxLength = 10;
        // text field 的内容
        NSString *contentText = textField.text;
    
        // 获取高亮内容的范围
        UITextRange *selectedRange = [textField markedTextRange];
        // 这行代码 可以认为是 获取高亮内容的长度
        NSInteger markedTextLength = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
        // 没有高亮内容时,对已输入的文字进行操作
        if (markedTextLength == 0) {
            // 如果 text field 的内容长度大于我们限制的内容长度
            if (contentText.length > maxLength) {
    
                NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [contentText substringWithRange:rangeRange];
            }
        }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // 缓存数据并且刷新界面
    [self.searchTf resignFirstResponder];
    return YES;
}

#pragma mark - Helper methods
- (void)alertViewWithMessage {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请在系统设置中开启服务" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //进入系统设置页面，APP本身的权限管理页面
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
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

