//
//  BMMapViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMapViewController.h"

#import "BMCustomAnnotationView.h"
#import "CustomPopOverView.h"
#import "BMMapInfoView.h"
#import "BMMapMineInfoView.h"
#import "BMScanViewController.h"
#import "BMAddDeviceTitlesViewController.h"
#import "BMCreateGroupViewController.h"
#import "BMManageGroupViewController.h"
#import "BMFootprintViewController.h"
#import "BMDeviceModel.h"
#import "BMClusterModel.h"
#import "BMHomeModel.h"

#import "BMSharePopView.h"
#import "BMUrgentSetViewController.h"
#import "BMAddDeviceTitlesViewController.h"
@interface BMMapViewController()<AMapLocationManagerDelegate,MAMapViewDelegate,CustomPopOverViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSMutableArray *annotations;

@property (nonatomic, strong) CustomPopOverView *addPopView;
@property (nonatomic, strong) CustomPopOverView *groupPopView;

@property (nonatomic, strong) BMMapInfoView *mapInfoView;
@property (nonatomic, strong) BMMapMineInfoView *mineInfoView;

@property (nonatomic, strong) NSMutableArray *sourceArr;

@property (nonatomic, assign) BOOL                  isLocated;
@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic ,copy)NSString * la;
@property (nonatomic ,copy)NSString * lo;

@property (nonatomic, strong) UIButton *groupBtn;

@property (nonatomic, strong) BMHomeModel *homeModel;

@property (nonatomic, strong) UIButton *locBtn;
@property (nonatomic, strong) UIButton *urgentBtn;

@property (nonatomic ,copy)NSString * inviteJoinUrl;

@property (nonatomic ,copy)NSString *selectIndex;
@end

@implementation BMMapViewController


#pragma mark - Life Cycle

- (void)dealloc{
    
    [Z_NotificationCenter removeObserver:self];
}
//允许多个交互事件
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.selectIndex = nil;
    [self configData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"createGroup" object:nil];
//    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"changeGroupInfo" object:nil];
//    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"dissolveClu" object:nil];
//    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"deviceChange" object:nil];
//    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"mineChange" object:nil];
    
    
    [self setNav];
    self.isLocated = NO;
    self.mapView = [[MAMapView alloc] init];
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.distanceFilter = 15.0f;
    [self.mapView setZoomLevel:16 animated:YES];
    self.mapView.delegate = self;
//    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 49);
    }];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    tap.delegate = self; //一定要记得设置代理
//    [self.mapView addGestureRecognizer:tap];
    
    [self.view addSubview:self.mapInfoView];
    [self.mapInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(- SafeAreaBottomHeight - 49 );
        make.left.equalTo(9);
        make.right.equalTo(- 9);
    }];
    [self.view addSubview:self.mineInfoView];
    [self.mineInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- SafeAreaBottomHeight - 49 - 15);
        make.left.equalTo(9);
        make.right.equalTo(- 9);
    }];
    
    UIButton * locBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locBtn setImage:[UIImage imageNamed:@"btn_dingwei"] forState:UIControlStateNormal];
    [locBtn addTarget:self action:@selector(loc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locBtn];
    [locBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(- SafeAreaBottomHeight - 15 * AutoSizeScaleY - 49);
        make.left.equalTo(15 * AutoSizeScaleX);
        make.size.equalTo(CGSizeMake(35 * AutoSizeScaleX, 35 * AutoSizeScaleX));
    }];
    self.locBtn = locBtn;
    
    UIButton * urgentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [urgentBtn setImage:[UIImage imageNamed:@"btn_urgency"] forState:UIControlStateNormal];
    [urgentBtn addTarget:self action:@selector(urgent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:urgentBtn];
    [urgentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.locBtn);
        make.right.equalTo(- 15 * AutoSizeScaleX);
        make.size.equalTo(CGSizeMake(113 * AutoSizeScaleX, 42 * AutoSizeScaleX));
    }];
    self.urgentBtn = urgentBtn;
    
//    UIView *zoomPannelView = [self makeZoomPannelView];
//    [self.view addSubview:zoomPannelView];
//    [zoomPannelView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.equalTo(self.locBtn);
//        make.centerX.equalTo(self.urgentBtn);
//        make.size.equalTo(CGSizeMake(90 * AutoSizeScaleX, 45 * AutoSizeScaleX));
//    }];
    
    [self configSy];
    
}
- (UIView *)makeZoomPannelView
{
    UIView *ret = [[UIView alloc] init];
    
    UIButton *incBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45* AutoSizeScaleX, 45* AutoSizeScaleX)];
    [incBtn setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [incBtn sizeToFit];
    [incBtn addTarget:self action:@selector(zoomPlusAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *decBtn = [[UIButton alloc] initWithFrame:CGRectMake(45* AutoSizeScaleX, 0, 45* AutoSizeScaleX, 45* AutoSizeScaleX)];
    [decBtn setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    [decBtn sizeToFit];
    [decBtn addTarget:self action:@selector(zoomMinusAction) forControlEvents:UIControlEventTouchUpInside];
    [ret addSubview:incBtn];
    [ret addSubview:decBtn];
    
    return ret;
}
#pragma mark ======  缩放地图  ======
- (void)zoomPlusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
}

- (void)zoomMinusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
}

#pragma mark ======  定位  ======
- (void)loc{
    
    [self configData];
}
#pragma mark ======  紧急状态  ======
- (void)urgent{
    
    if (self.homeModel.deviceList.count == 0) {
        
        [BMPopView showWithContent:@"当前群组未添加设备,是否立即添加?" blockTapAction:^(NSInteger index) {
           
            BMClusterModel * model = [[BMClusterModel alloc] init];
            model.Id = self.homeModel.clusterId;
            BMAddDeviceTitlesViewController * add = [[BMAddDeviceTitlesViewController alloc] init];
            add.cluModel = model;
            [self.navigationController pushViewController:add animated:YES];
        }];
        return;
    }
    BMClusterModel * clu = [[BMClusterModel alloc] init];
    clu.Id = self.homeModel.clusterId;
    BMUrgentSetViewController * urgent = [[BMUrgentSetViewController alloc] init];
    urgent.cluModel = clu;
    [self.navigationController pushViewController:urgent animated:YES];
}
#pragma mark ======  自动定位  ======
- (void)locate{
    
    //单次定位
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //设置定位超时时间
    [self.locationManager setLocationTimeout:5];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:5];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
    [self.locationManager requestLocationWithReGeocode:YES   completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
        if (regeocode)
        {
            NSMutableDictionary *addressDic = [NSMutableDictionary dictionary];
            [addressDic setValue:regeocode.province forKey:@"province"];
            [addressDic setValue:regeocode.city forKey:@"city"];
            [addressDic setValue:regeocode.district forKey:@"district"];
            
            BMDeviceModel * device = [[BMDeviceModel alloc] init];
            device.picUrl = [[BMUserInfoManager sharedManager] getUser].picUrl;
            device.name = @"我的位置";
            device.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            device.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            device.position = [NSString stringWithFormat:@"%@%@%@%@%@",regeocode.province,regeocode.city,regeocode.district,regeocode.street,regeocode.number];
            [self.sourceArr addObject:device];
            MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
            a1.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
            a1.title = @"我的位置";
            [self.annotations addObject:a1];
            [self.mapView addAnnotation:a1];
            self.la = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            self.lo = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            [self configDistance];
        }
        
    }];
}
- (void)configDistance{
    
    for (BMDeviceModel * model in self.sourceArr) {
        
        //1.将两个经纬度点转成投影点
        MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake([model.latitude floatValue],[model.longitude floatValue]));
        MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake([self.la floatValue],[self.lo floatValue]));
        //2.计算距离
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
        NSString * distanceStr = @"";
        if (distance < 1000) {
            
            distanceStr = [NSString stringWithFormat:@"%.0fm",distance];
        }else{
            
            distanceStr = [NSString stringWithFormat:@"%.fkm",distance / 1000];
        }
        
        
        model.distance = distanceStr;
//        //第一个坐标
//        CLLocation *current=[[CLLocation alloc] initWithLatitude:[model.latitude floatValue] longitude:[model.longitude floatValue]];
//        //第二个坐标
//        CLLocation *before=[[CLLocation alloc] initWithLatitude:[self.la floatValue] longitude:[self.lo floatValue]];
//        // 计算距离
//        CLLocationDistance meters=[current distanceFromLocation:before];
//        model.distance = [NSString stringWithFormat:@"%.2f",meters / 1000];
    }
 
}

- (void)configData{
    
    [self.mapView removeAnnotations:self.annotations];
    [self.annotations removeAllObjects];
    [self.sourceArr removeAllObjects];
    [self locate];
    [[BMHttpsMethod httpMethodManager] userFrontPageWithId:UserID ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.homeModel = [BMHomeModel mj_objectWithKeyValues:data[@"data"]];
            self.groupPopView.homeModel = self.homeModel;
            
            for (BMClusterModel * cluModel in self.homeModel.clusterList) {
                
                if ([cluModel.Id isEqualToString:self.homeModel.clusterId]) {
                    
                    [self.groupBtn setTitle:cluModel.name forState:UIControlStateNormal];
                }
            }
            if (self.homeModel.clusterList.count > 1) {
                
                [self.groupBtn setImage:[UIImage imageNamed:@"home_sanjiao_xia"] forState:UIControlStateNormal];
                [self.groupBtn setImagePositionWithType:SSImagePositionTypeRight spacing:6];
            }else{
                
                [self.groupBtn setImage:nil forState:UIControlStateNormal];
            }
            if (self.sourceArr.count != 0) {
                
                [self.sourceArr addObjectsFromArray:self.homeModel.deviceList];
            }else{
                
                self.sourceArr = [NSMutableArray arrayWithArray:self.homeModel.deviceList];
            }
            
            [self initAnnotations];
            [self.mapView addAnnotations:self.annotations];

            if (self.selectIndex) {
                
                MAPointAnnotation * point = self.annotations[[self.selectIndex integerValue]];
                [self.mapView selectAnnotation:point animated:YES];
            }
            
            NSArray * titleArr =[NSArray array];
            
            NSString * ower = @"0";
            for (BMClusterModel * clu in self.homeModel.clusterList) {
                
                if ([self.homeModel.clusterId isEqualToString:clu.Id]) {
                    
                    if ([UserID isEqualToString:clu.ownerId]) {
                        
                        ower = @"1";
                        
                    }
                }
            }
            if ([ower isEqualToString:@"1"]) {
                
                titleArr = @[@"添加成员",@"添加设备",@"群组管理",@"创建群组"];
            }else{
                
                titleArr = @[@"群组管理",@"创建群组"];
            }
            PopOverVieConfiguration * config = [[PopOverVieConfiguration alloc] init];
            config.tableBackgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
            config.separatorColor = [UIColor getUsualColorWithString:@"#ECECEC"];
            config.textColor = [UIColor getUsualColorWithString:@"#333333"];
            config.showSpace = - 3;
            config.defaultRowHeight = 40;
            config.triAngelHeight = 5;
            config.triAngelWidth = 8;
            config.textAlignment = NSTextAlignmentCenter;
            self.addPopView = [[CustomPopOverView alloc] initWithBounds:CGRectMake(0, 0, 112, 40 *titleArr.count) titleMenus:titleArr config:config];
            self.addPopView.delegate = self;

        }else{
            
            [self showHint:data[@"errorMsg"]];
        }

    }];
    
}

- (void)configSy{
    
    [[BMHttpsMethod httpMethodManager] settingGetSettingToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            NSLog(@"广告数据 = %@",data[@"data"]);
            self.inviteJoinUrl = data[@"data"][@"inviteJoinUrl"];
        }
        
    }];
}

#pragma mark - Initialization

- (NSMutableArray *)sourceArr{
    
    if (!_sourceArr) {
        
        _sourceArr = [[NSMutableArray alloc] init];
    }
    return _sourceArr;
}
- (NSMutableArray *)annotations{
    
    if (!_annotations) {
        
        _annotations = [[NSMutableArray alloc] init];
    }
    return _annotations;
}

- (BMMapInfoView *)mapInfoView{
    
    if (!_mapInfoView) {
        
        _mapInfoView = [[BMMapInfoView alloc] init];
        _mapInfoView.alpha = 0;
        ZWeakSelf(self);
        _mapInfoView.funcBlock = ^(NSInteger i) {
            
            if (i == 1) {
                
                //刷新
                [weakself configData];
                
                
            }else if(i == 2){
                
                //足迹
                BMFootprintViewController * footprint = [[BMFootprintViewController alloc] init];
                footprint.device = weakself.mapInfoView.device;
                [weakself.navigationController pushViewController:footprint animated:YES];
            }else if(i == 3){
                
              //导航
       
                NSURL * gaode_App = [NSURL URLWithString:@"iosamap://"];
                if ([[UIApplication sharedApplication] canOpenURL:gaode_App]) {
                    
                    
                    BMDeviceModel * device = weakself.sourceArr[[weakself.selectIndex integerValue]];
                    // 起点为“我的位置”，终点为后台返回的address
                    NSString * urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&sname=%@&did=BGVIS2&dname=%@&dev=0&t=0",@"我的位置",device.position] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }else{
                    
                    [weakself showHint:@"您还未安装高德地图"];
                }
            }
            
        };
    }
    return _mapInfoView;
}
- (BMMapMineInfoView *)mineInfoView{
    
    if (!_mineInfoView) {
        
        _mineInfoView = [[BMMapMineInfoView alloc] init];
        _mineInfoView.backgroundColor = [UIColor whiteColor];
        ZViewBorderRadius(_mineInfoView, 15, 0, [UIColor whiteColor]);
        _mineInfoView.alpha = 0;
    }
    return _mineInfoView;
}
- (void)initAnnotations
{
    
    
    CLLocationCoordinate2D coordinates[10] = {
        {39.992520, 116.336170},
        {39.992520, 116.336170},
        {39.998293, 116.352343},
        {40.004087, 116.348904},
        {40.001442, 116.353915},
        {39.989105, 116.353915},
        {39.989098, 116.360200},
        {39.998439, 116.360201},
        {39.979590, 116.324219},
        {39.978234, 116.352792}};
    
    for (int i = 0; i < self.sourceArr.count; ++i)
    {
        BMDeviceModel * device = self.sourceArr[i];
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        a1.coordinate = CLLocationCoordinate2DMake([device.latitude floatValue], [device.longitude floatValue]);
        a1.title      = device.name;
        [self.annotations addObject:a1];
    }
    [self configDistance];
}

- (void)setNav{
    
    UIButton * groupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [groupBtn setTitle:@"智能书包" forState:UIControlStateNormal];
    [groupBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    groupBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [groupBtn setImagePositionWithType:SSImagePositionTypeRight spacing:6];
    [groupBtn addTarget:self action:@selector(showGroup:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:groupBtn];
    [groupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.customNavBar);
        make.bottom.equalTo(- 7);
        make.size.equalTo(CGSizeMake(120, 30));
    }];
    self.groupBtn = groupBtn;
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"home_iocn_jia"]];
    NSArray * titleArr = @[@"添加成员",@"添加设备",@"群组管理",@"创建群组"];
    PopOverVieConfiguration * config = [[PopOverVieConfiguration alloc] init];
    config.tableBackgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    config.separatorColor = [UIColor getUsualColorWithString:@"#ECECEC"];
    config.textColor = [UIColor getUsualColorWithString:@"#333333"];
    config.showSpace = - 3;
    config.defaultRowHeight = 40;
    config.triAngelHeight = 5;
    config.triAngelWidth = 8;
    config.textAlignment = NSTextAlignmentCenter;
    self.addPopView = [[CustomPopOverView alloc] initWithBounds:CGRectMake(0, 0, 112, 40 *titleArr.count) titleMenus:titleArr config:config];
    self.addPopView.containerBackgroudColor = [UIColor whiteColor];
    self.addPopView.delegate = self;
    
    
    ZWeakSelf(self);
    self.customNavBar.onClickRightButton = ^{
      
        
        //pView.containerBackgroudColor = RGBCOLOR(64, 64, 64);
        [weakself.addPopView showFrom:weakself.customNavBar.rightButton alignStyle:CPAlignStyleRight];
    };
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"home_btn_sao"]];
    self.customNavBar.onClickLeftButton = ^{
      
        NSString * ower = @"0";
        for (BMClusterModel * clu in weakself.homeModel.clusterList) {
            
            if ([weakself.homeModel.clusterId isEqualToString:clu.Id]) {
                
                if ([UserID isEqualToString:clu.ownerId]) {
                    
                    ower = @"1";
                }
            }
        }
        BMClusterModel * model = [[BMClusterModel alloc] init];
        model.Id = weakself.homeModel.clusterId;
        BMScanViewController * scan = [[BMScanViewController alloc] init];
        scan.cluModel = model;
        scan.ower = ower;
        [weakself.navigationController pushViewController:scan animated:YES];
    };
    
    
}
- (void)showGroup:(UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"智能书包"]) {
        
        return;
    }
    
    PopOverVieConfiguration * config = [[PopOverVieConfiguration alloc] init];
    config.tableBackgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    config.separatorColor = [UIColor getUsualColorWithString:@"#ECECEC"];
    config.textColor = [UIColor getUsualColorWithString:@"#333333"];
    config.showSpace = 11;
    config.defaultRowHeight = 40;
    config.triAngelHeight = 7;
    config.triAngelWidth = 8;
    self.groupPopView = [[CustomPopOverView alloc] initWithBounds:CGRectMake(0, 0, 152, 40 *self.homeModel.clusterList.count) groupMenus:self.homeModel.clusterList config:config];
    self.groupPopView.containerBackgroudColor = [UIColor whiteColor];
    self.groupPopView.delegate = self;
    self.groupPopView.homeModel = self.homeModel;
    //pView.containerBackgroudColor = RGBCOLOR(64, 64, 64);
    [self.groupPopView showFrom:btn alignStyle:CPAlignStyleCenter];
}


- (void)popOverView:(CustomPopOverView *)pView didClickMenuIndex:(NSInteger)index{
    
    [pView dismiss];
    if (pView == self.addPopView) {
        //右侧下拉
        
        NSString * ower = @"0";
        for (BMClusterModel * clu in self.homeModel.clusterList) {
            
            if ([self.homeModel.clusterId isEqualToString:clu.Id]) {
                
                if ([UserID isEqualToString:clu.ownerId]) {
                    
                    ower = @"1";
                }
            }
        }
        
        
        if ([ower isEqualToString:@"1"]) {
            
            if (index == 0) {
                
                [BMSharePopView showMoreWithTitle:@[@"微信好友",@"QQ好友"] imgNameArray:@[@"fenxiang_btn_weixin",@"fenxiang_btn_qq"] blockTapAction:^(NSInteger index) {
                    
                    [self shareWithIndex:index];
                }];
                
            }else if (index == 1) {
                
                BMClusterModel * model = [[BMClusterModel alloc] init];
                model.Id = self.homeModel.clusterId;
                BMAddDeviceTitlesViewController * add = [[BMAddDeviceTitlesViewController alloc] init];
                add.cluModel = model;
                [self.navigationController pushViewController:add animated:YES];
            }else if (index == 10) {
                
                
                BMClusterModel * model = [[BMClusterModel alloc] init];
                model.Id = self.homeModel.clusterId;
                BMScanViewController * scan = [[BMScanViewController alloc] init];
                scan.cluModel = model;
                scan.ower = ower;
                [self.navigationController pushViewController:scan animated:YES];
            }else if (index == 2) {
                
                BMManageGroupViewController * manage = [[BMManageGroupViewController alloc] init];
                [self.navigationController pushViewController:manage animated:YES];
            }else if (index == 3) {
                
                BMCreateGroupViewController * group = [[BMCreateGroupViewController alloc] init];
                [self.navigationController pushViewController:group animated:YES];
            }
        }else{
            
            if (index == 0) {
                
                BMManageGroupViewController * manage = [[BMManageGroupViewController alloc] init];
                [self.navigationController pushViewController:manage animated:YES];
            }else if (index == 1) {
                
                BMCreateGroupViewController * group = [[BMCreateGroupViewController alloc] init];
                [self.navigationController pushViewController:group animated:YES];
            }
        }

    }else if(pView == self.groupPopView){
        //群组选择
//        [self configData];
        self.selectIndex = nil;
        self.mapInfoView.alpha = 0;
        self.mineInfoView.alpha = 0;
        BMClusterModel * clu = self.homeModel.clusterList[index];
        [[BMHttpsMethod httpMethodManager] deviceDeviceListWithUserId:UserID ClusterId:clu.Id ToGetResult:^(id  _Nonnull data) {
           
            if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                
                [self configData];
                
            }else{
                
                [self showHint:data[@"errorMsg"]];
            }
        }];
        
    }
    
}

#pragma mark ======  分享  ======

- (void)shareWithIndex:(NSInteger)index{
    
    NSString * name;
    NSString * Id;
    for (BMClusterModel * clu in self.homeModel.clusterList) {
        
        if ([self.homeModel.clusterId isEqualToString:clu.Id]) {
            
            name = clu.name;
            Id = clu.Id;
        }
    }
    
    NSArray * typeArr = @[@1,@4];
    NSNumber * i = typeArr[index];
    UserModel * user = [[BMUserInfoManager sharedManager] getUser];
    NSString * shareUrl = [NSString stringWithFormat:@"%@modelView/invite/join/%@/%@",BaseURL,user.phoneNo,Id];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"智能书包邀请加群" descr:[NSString stringWithFormat:@"好友邀请您加入\"%@\"，让我们一起守护您和家人的安全。",name] thumImage:self.inviteJoinUrl];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"%@",shareUrl];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:[i integerValue] messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            //            [self showHint:@"分享失败"];
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                //                [self showHint:@"分享成功"];
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

#pragma mark - action handling
- (void)addAction
{
    
    CLLocationCoordinate2D randomCoordinate = [self.mapView convertPoint:[self randomPoint] toCoordinateFromView:self.view];
    
    [self addAnnotationWithCooordinate:randomCoordinate];
}


#pragma mark - Utility

-(void)addAnnotationWithCooordinate:(CLLocationCoordinate2D)coordinate
{
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title    = @"AutoNavi";
    annotation.subtitle = @"CustomAnnotationView";
    
    [self.mapView addAnnotation:annotation];
}

- (CGPoint)randomPoint
{
    CGPoint randomPoint = CGPointZero;
    
    randomPoint.x = arc4random() % (int)(CGRectGetWidth(self.view.bounds));
    randomPoint.y = arc4random() % (int)(CGRectGetHeight(self.view.bounds));
    
    return randomPoint;
}

#pragma mark - MAMapViewDelegate

- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager {
    [locationManager requestAlwaysAuthorization];
}
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
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        BMCustomAnnotationView *annotationView = (BMCustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[BMCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = NO;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        for (BMDeviceModel * device in self.sourceArr) {
            
            if ([device.name isEqualToString:annotation.title]) {
                
                annotationView.device = device;
            }
        }

        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -40 * AutoSizeScaleX);
        return annotationView;
    }
    
    return nil;
}

/*!
 @brief 当mapView新添加annotation views时调用此接口
 @param mapView 地图View
 @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
        r.showsAccuracyRing = false;///精度圈是否显示，默认YES
        [self.mapView updateUserLocationRepresentation:r];
    }
    
}

/*!
 @brief 当选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    
    BMCustomAnnotationView * customView = (BMCustomAnnotationView *)view;
    if ([customView.device.name isEqualToString:@"我的位置"]) {
        
        self.mineInfoView.alpha = 1;
        self.mineInfoView.device = customView.device;
        self.mapInfoView.alpha = 0;
        [self.view bringSubviewToFront:self.mineInfoView];
        
    }else{
        
        self.mineInfoView.alpha = 0;
        self.mapInfoView.alpha = 1;
        self.mapInfoView.device = customView.device;
        [self.view bringSubviewToFront:self.mapInfoView];
        for (BMDeviceModel * device in self.sourceArr) {
            
            if ([device.Id isEqualToString:self.mapInfoView.device.Id]) {
                self.selectIndex = [NSString stringWithFormat:@"%lu",(unsigned long)[self.sourceArr indexOfObject:device]];
            }
        }
    }
}

/*!
 @brief 当取消选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    
     BMCustomAnnotationView * customView = (BMCustomAnnotationView *)view;
    if (!customView.device.Id || customView.device.Id.length == 0) {
        
        self.mineInfoView.alpha = 0;
        
    }else{
        
        self.mapInfoView.alpha = 0;
        
    }
    
}

/*!
 @brief 标注view的accessory view(必须继承自UIControl)被点击时调用此接口
 @param mapView 地图View
 @param annotationView callout所属的标注view
 @param control 对应的control
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
}

/**
 *  标注view的calloutview整体点击时调用此接口
 *
 *  @param mapView 地图的view
 *  @param view calloutView所属的annotationView
 */
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {
    
}

/*!
 @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 @param mapView 地图View
 @param view annotation view
 @param newState 新状态
 @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
    
}

@end
