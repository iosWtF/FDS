//
//  BMSecurityDetailViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMSecurityDetailViewController.h"

#import "BMCustomAnnotationView.h"
#import "BMSecurityDetailInfoView.h"
#import "BMSecurityMsgDetailModel.h"
#import "BMFootprintViewController.h"
@interface BMSecurityDetailViewController()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) BMSecurityDetailInfoView *infoView;
@property (nonatomic, strong) BMSecurityMsgDetailModel *detailModel;
@end

@implementation BMSecurityDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.customNavBar.title = @"消息明细";
    
    self.mapView = [[MAMapView alloc] init];
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.showsUserLocation = NO;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.distanceFilter = 15.0f;
    [self.mapView setZoomLevel:16 animated:YES];
    self.mapView.delegate = self;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(SafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 50 * AutoSizeScaleY);
    }];
    self.infoView = [[BMSecurityDetailInfoView alloc] init];
    ZWeakSelf(self);
    self.infoView.checkBlock = ^{
        
        BMFootprintViewController * footprint = [[BMFootprintViewController alloc] init];
        BMDeviceModel * device = [[BMDeviceModel alloc] init];
        device.Id = weakself.model.deviceId;
        device.picUrl = weakself.model.devicePic;
        device.refreshTime = weakself.model.createTime;
        footprint.device = device;
        [weakself.navigationController pushViewController:footprint animated:YES];
    };
    self.infoView.backgroundColor = [UIColor whiteColor];
    self.infoView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.infoView.layer.cornerRadius = 4;
    self.infoView.layer.shadowColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:0.22].CGColor;
    self.infoView.layer.shadowOffset = CGSizeMake(0,0);
    self.infoView.layer.shadowOpacity = 1;
    self.infoView.layer.shadowRadius = 12;
    [self.view addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(- 15 * AutoSizeScaleY - SafeAreaBottomHeight);
        make.left.equalTo(15 * AutoSizeScaleX);
        make.width.equalTo(Z_SCREEN_WIDTH - 30 * AutoSizeScaleX);
    }];
    [self configData];
}

- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] messageGetWithId:self.model.messageId ToGetResult:^(id  _Nonnull data) {

        LHLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
    
            self.detailModel = [BMSecurityMsgDetailModel mj_objectWithKeyValues:data[@"data"]];
    
            MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
            a1.coordinate = CLLocationCoordinate2DMake([self.detailModel.latitude floatValue], [self.detailModel.longitude floatValue]);
            [self.mapView addAnnotation:a1];
            [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([self.detailModel.latitude floatValue], [self.detailModel.longitude floatValue]) animated:YES];
            self.infoView.model = self.detailModel;
        }else{

            [self showHint:data[@"errorMsg"]];
        }
    }];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /* Add a annotation on map center. */
//    [self addAnnotationWithCooordinate:self.mapView.centerCoordinate];
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

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

#pragma mark - MAMapViewDelegate

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
        annotationView.msg = self.detailModel;
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -40 * AutoSizeScaleX);
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[BMCustomAnnotationView class]]) {
        BMCustomAnnotationView *cusView = (BMCustomAnnotationView *)view;
        
    }
}

@end
