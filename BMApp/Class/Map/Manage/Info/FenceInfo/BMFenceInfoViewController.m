//
//  BMFenceInfoViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMFenceInfoViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import "BMMapMineInfoView.h"
@interface BMFenceInfoViewController ()<AMapLocationManagerDelegate,MAMapViewDelegate>

@property (nonatomic, strong) MAMapView            *mapView;
@property (nonatomic, strong) UIImageView          *centerAnnotationView;
@property (nonatomic, strong) MACircle * circle;

@property (nonatomic, strong) UIButton * radiusBtn;
@property (nonatomic, strong) BMMapMineInfoView *infoView;

@property(nonatomic ,strong)BMFenceModel * infoModel;

@end

@implementation BMFenceInfoViewController

#pragma mark ======  删除  ======
- (void)delete{
    
    [BMPopView showWithContent:@"确认删除当前围栏?" blockTapAction:^(NSInteger index) {
       
        [[BMHttpsMethod httpMethodManager] fenceDeleteWithId:self.infoModel.Id ToGetResult:^(id  _Nonnull data) {
            
            if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                
                [self showHint:@"删除成功"];
                [Z_NotificationCenter postNotificationName:@"fenceChange" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [self showHint:data[@"errorMsg"]];
            }
        }];
    }];
}

- (void)setupUI{
    
    [self initMapView];
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [deleteBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    ZViewBorderRadius(deleteBtn, 5, 0, [UIColor whiteColor]);
    [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- 24 * AutoSizeScaleY - SafeAreaBottomHeight);
        make.centerX.equalTo(self.mapView);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
    }];
    [self.view addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(deleteBtn.mas_top).offset(- 17 * AutoSizeScaleY);
        make.left.equalTo(15);
        make.right.equalTo(- 15);
    }];
    if (!self.isOwner) {
        
        [deleteBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(- 24 * AutoSizeScaleY - SafeAreaBottomHeight);
            make.centerX.equalTo(self.mapView);
            make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 0 * AutoSizeScaleY));
        }];
    }
    
}
#pragma mark - Initialization

- (BMMapMineInfoView *)infoView{
    
    if (!_infoView) {
        
        _infoView = [[BMMapMineInfoView alloc] init];
        _infoView.backgroundColor = [UIColor whiteColor];
        ZViewBorderRadius(_infoView, 15, 0, [UIColor whiteColor]);
        
    }
    return _infoView;
}
#pragma mark - MapViewDelegate

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
#pragma mark - Initialization

- (void)initMapView
{
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaBottomHeight - SafeAreaTopHeight)];
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.showsUserLocation = NO;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.distanceFilter = 15.0f;
    [self.mapView setZoomLevel:15 animated:YES];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
}

- (void)initCenterView
{
    self.centerAnnotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tianjia_icon_dizhi"]];
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
    self.customNavBar.title = self.fenceModel.name;
    self.circle = [[MACircle alloc] init];
    [self setupUI];
    [self configData];
}

- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] fenceGetWithClusterId:self.fenceModel.Id ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.infoModel = [BMFenceModel mj_objectWithKeyValues:data[@"data"]];
            self.infoView.fence = self.infoModel;
            
            self.mapView.centerCoordinate = CLLocationCoordinate2DMake([self.infoModel.latitude floatValue], [self.infoModel.longitude floatValue]);
            [self.circle setCircleWithCenterCoordinate:CLLocationCoordinate2DMake([self.infoModel.latitude floatValue], [self.infoModel.longitude floatValue]) radius:[self.infoModel.radius intValue]];
            [self.mapView addOverlay:self.circle];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initCenterView];
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

