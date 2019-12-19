//
//  BMScanViewController.h
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "LBXScanViewController.h"
#import "WRCustomNavigationBar.h"
#import "BMClusterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMScanViewController : LBXScanViewController

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *ower;
@property (nonatomic, strong) BMClusterModel *cluModel;
/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

#pragma mark --增加拉近/远视频界面
@property (nonatomic, assign) BOOL isVideoZoom;

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;
//我的二维码
@property (nonatomic, strong) UIButton *btnMyQR;

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;

@end

NS_ASSUME_NONNULL_END
