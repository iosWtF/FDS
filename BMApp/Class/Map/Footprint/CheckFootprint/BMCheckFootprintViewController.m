//
//  BMCheckFootprintViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMCheckFootprintViewController.h"
#import "BMFootPrintAnnotationView.h"

#import "BMFootprintHeaderView.h"
#import "BMFootprintInfoView.h"

#import "BMPositionModel.h"

@interface BMCheckFootprintViewController()<MAMapViewDelegate>

@property(nonatomic ,strong)NSMutableArray * sourceArr;

@property (nonatomic, strong) BMFootprintHeaderView *headerView;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) BMFootprintInfoView *infoView;
@property (nonatomic, strong) MAPolyline *line;
@property (nonatomic, strong) NSMutableArray *positionArr;
@property (nonatomic, assign) NSInteger selectRow;

@property(nonatomic ,copy)NSString * cityCount;
@property(nonatomic ,copy)NSString * positionCount;


@end

@implementation BMCheckFootprintViewController

- (NSMutableArray *)sourceArr{
    
    if (!_sourceArr) {
        
        _sourceArr = [[NSMutableArray alloc] init];
    }
    return _sourceArr;
}

- (NSMutableArray *)positionArr{
    
    if (!_positionArr) {
        
        _positionArr = [[NSMutableArray alloc] init];
    }
    return _positionArr;
}
- (BMFootprintHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[BMFootprintHeaderView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, Z_SCREEN_WIDTH, 140 * AutoSizeScaleY)];
        _headerView.icon = self.device.picUrl;
        _headerView.date = self.currentDate;
        ZWeakSelf(self);
        _headerView.leftBlock = ^{
            
            weakself.currentDate = [CommonMethod fontDate:weakself.currentDate];
            weakself.headerView.date = weakself.currentDate;
            [weakself configData];
        };
        _headerView.rightBlock = ^{
            
            weakself.currentDate = [CommonMethod nextDate:weakself.currentDate];
            weakself.headerView.date = weakself.currentDate;
            [weakself configData];
        };
    }
    return _headerView;
}

- (BMFootprintInfoView *)infoView{
    
    if (!_infoView) {
        
        _infoView = [[BMFootprintInfoView alloc] init];
        _infoView.backgroundColor = [UIColor whiteColor];
        
        ZViewBorderRadius(_infoView, 15, 0, [UIColor whiteColor]);
        ZWeakSelf(self);
        _infoView.leftBlock = ^{
          
            if (weakself.selectRow > 0) {
                
                weakself.selectRow -=1;
            }
            weakself.infoView.model = weakself.positionArr[weakself.selectRow];
        };
        _infoView.rightBlock = ^{
            
            if (weakself.selectRow < weakself.positionArr.count - 1) {
                
                weakself.selectRow +=1;
            }
            weakself.infoView.model = weakself.positionArr[weakself.selectRow];
        };
    }
    return _infoView;
}
#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customNavBar.title = @"轨迹";
    self.selectRow = 0;
    [self.view addSubview:self.headerView];
    
    self.mapView = [[MAMapView alloc] init];
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.showsUserLocation = NO;
    //    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.distanceFilter = 15.0f;
    [self.mapView setZoomLevel:14 animated:YES];
    self.mapView.delegate = self;
//    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight + 140 * AutoSizeScaleY);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight);
    }];
    
    [self.view addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- SafeAreaBottomHeight - 15);
        make.left.equalTo(9);
        make.right.equalTo(- 9);
    }];
    [self configData];
}
- (void)configData{
    
    [self.mapView removeOverlay:self.line];
    [self.mapView removeAnnotations:self.annotations];
    [self.positionArr removeAllObjects];
    [self.annotations removeAllObjects];
    [self.sourceArr removeAllObjects];
    self.selectRow = 0;
    self.headerView.userInteractionEnabled = NO;
    [[BMHttpsMethod httpMethodManager] positionGetListWithDate:[CommonMethod configYear:self.currentDate] DeviceId:self.device.Id ToGetResult:^(id  _Nonnull data) {
        
        LHLog(@"%@",data);
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.headerView.cityCount = data[@"data"][@"cityCount"];
            self.cityCount =data[@"data"][@"cityCount"];
            self.headerView.positionCount = data[@"data"][@"positionCount"];
            self.positionCount =data[@"data"][@"positionCount"];
            self.sourceArr = [NSMutableArray arrayWithArray:data[@"data"][@"positionList"]];
            [self initAnnotations];
            if (self.positionArr.count == 0) {
                
                self.infoView.alpha = 0;
            }else{
                self.infoView.alpha = 1;
                self.infoView.model = self.positionArr[self.selectRow];
                [self.mapView addAnnotations:self.annotations];
                //    [self.mapView showAnnotations:self.annotations animated:YES];
                [self.mapView addOverlay:self.line];
            }
            
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        self.headerView.userInteractionEnabled = YES;
    }];
    
}

- (void)initAnnotations
{
    self.annotations = [NSMutableArray array];
    
    if (self.sourceArr.count == 0) {
        
        return;
    }
//    CLLocationCoordinate2D coordinates[10] = {
//        {39.992520, 116.336170},
//        {39.992520, 116.336170},
//        {39.998293, 116.352343},
//        {40.004087, 116.348904},
//        {40.001442, 116.353915},
//        {39.989105, 116.353915},
//        {39.989098, 116.360200},
//        {39.998439, 116.360201},
//        {39.979590, 116.324219},
//        {39.978234, 116.352792}};
    
    
    int totalCount = 0;
    
    for (NSArray * arr in self.sourceArr) {
        
        totalCount += arr.count;
        
        for (int i = 0; i < arr.count; i ++) {
            
            BMPositionModel * position = [BMPositionModel mj_objectWithKeyValues:arr[i]];
            [self.positionArr addObject:position];
        }
    }
    CLLocationCoordinate2D  * coors = malloc(totalCount * sizeof(CLLocationCoordinate2D));
    for (int i = 0; i < self.positionArr.count; i ++) {
        
        BMPositionModel * position = self.positionArr[i];
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        a1.coordinate = CLLocationCoordinate2DMake([position.latitude floatValue], [position.longitude floatValue]);
        a1.title      = [NSString stringWithFormat:@"anno: %d", i];
        [self.annotations addObject:a1];
        coors[i].latitude = [position.latitude floatValue];
        coors[i].longitude = [position.longitude floatValue];
        if (i == 0) {
            
            [self.mapView setCenterCoordinate:coors[i] animated:YES];
        }
    }
    
    self.line = [MAPolyline polylineWithCoordinates:coors count:totalCount];
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

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.strokeColor = [UIColor getUsualColorWithString:@"#74BBFC"];
        polylineRenderer.lineWidth   = 5.f;
        polylineRenderer.lineCapType = kCGLineCapSquare;
        polylineRenderer.lineDashType = kMALineDashTypeNone;
        polylineRenderer.lineJoinType = kMALineJoinRound;
        
        return polylineRenderer;
    }
    
    return nil;
}
#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        CLLocationCoordinate2D  * coors = malloc(self.positionArr.count * sizeof(CLLocationCoordinate2D));
        for (int i = 0; i < self.positionArr.count; i ++) {
            
            BMPositionModel * position =self.positionArr[i];
            coors[i].latitude = [position.latitude floatValue];
            coors[i].longitude = [position.longitude floatValue];;
        }

        BMFootPrintAnnotationView *annotationView = (BMFootPrintAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[BMFootPrintAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = NO;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        annotationView.frontImgView.hidden = YES;
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        a1.coordinate = coors[0];
        if (annotation.coordinate.longitude == a1.coordinate.longitude && annotation.coordinate.latitude == a1.coordinate.latitude) {
            
            annotationView.frontImgView.hidden = NO;
            [annotationView.frontImgView setImage:[UIImage imageNamed:@"guiji_icon_zhog"]];
        }
        MAPointAnnotation *a10 = [[MAPointAnnotation alloc] init];
        a10.coordinate = coors[self.positionArr.count - 1];
        
        if (annotation.coordinate.longitude == a10.coordinate.longitude && annotation.coordinate.latitude == a10.coordinate.latitude) {
            
            annotationView.frontImgView.hidden = NO;
            [annotationView.frontImgView setImage:[UIImage imageNamed:@"guiji_icon_qi"]];
            
        }
        
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
    
}

/*!
 @brief 当选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {

}

/*!
 @brief 当取消选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    
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
