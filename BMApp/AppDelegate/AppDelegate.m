//
//  AppDelegate.m
//  BMApp
//
//  Created by Mac on 2019/5/21.
//  Copyright © 2019 BM. All rights reserved.
//

#import "AppDelegate.h"
#import "BMSecurityDetailViewController.h"
#import "BMSecurityMsgModel.h"
#import <AdSupport/AdSupport.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate>

@end
static NSString *appKey = @"b9f83855a6cd2c5b9a0de1c8";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
#pragma mark ======  极光推送配置  ======
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    
    
    if (@available(iOS 12.0, *)) {
        
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"0d2f444a998f66a2931bd531"
                          channel:@""
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
#pragma mark ======  高德地图配置  ======
    [AMapServices sharedServices].apiKey =@"122c1f7923c70d8b6168ea50844b2c3e";
#pragma mark ======  友盟分享配置  ======
    
    [UMConfigure initWithAppkey:@"5daff4fc570df39e4b000026" channel:@"App Store"]; // required
    [UMConfigure setLogEnabled:YES];
    [self confitUShareSettings];
    
    [self monitorNetworking];
    [self loadAd];
    [self configBaseUI];
    [WXApi registerApp:@"wxe11286cb8fffc514"];

    return YES;
}

#pragma mark ======  友盟注册APP  ======
- (void)confitUShareSettings{
    
    /* 设置微信的appKey和appSecret */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxe86c0beaf6b71775" appSecret:@"9b7b7b3c18c5053fc7511ef1ef14b281" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxe86c0beaf6b71775" appSecret:@"9b7b7b3c18c5053fc7511ef1ef14b281" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    //    b0f0af267290092e41e1cae1312152c3
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101813583"/*设置QQ平台的appID*/  appSecret:@"e5a613889214c2df68ce16c473776cd7" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"101813583"/*设置QQ平台的appID*/  appSecret:@"e5a613889214c2df68ce16c473776cd7" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3910476009"  appSecret:@"e482cdf68c5a51023b6413003050911d" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}
#pragma mark ======  回调  ======
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            
            return YES;
        }else{
            
            return [WXApi handleOpenURL:url delegate:self];
        }
    }
    return result;
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            
            return YES;
        }else{
            
            return [WXApi handleOpenURL:url delegate:self];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
           
            return YES;
        }else{
            
            return [WXApi handleOpenURL:url delegate:self];
        }
    }
    return result;
}
-(void)onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuccess" object:nil];
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"您取消本次交易"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"payFaild" object:nil];
                break;
        }
    }
    
}


- (void)configBaseUI{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [CommonMethod setupBaseUI];
    [self setNavBarAppearence];
}
- (void)loadAd{
    
#pragma mark ======  加载广告页面  ======
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3 .数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    
    [[BMHttpsMethod httpMethodManager] settingGetSettingToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            NSLog(@"广告数据 = %@",data[@"data"]);
            //配置广告数据
            XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
            imageAdconfiguration.customSkipView = [self customSkipView];
            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
            imageAdconfiguration.imageNameOrURLString = [NSString stringWithFormat:@"%@",data[@"data"][@"lunchAdUrl"]];
            //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
            //                imageAdconfiguration.openModel = model.openUrl;
            //显示开屏广告
            [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        }
        
    }];

}
- (void)setNavBarAppearence
{
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:                     [UIColor getUsualColorWithString:@"#1D1C1C"], NSForegroundColorAttributeName,
                                                           [UIFont boldSystemFontOfSize:18.0f], NSFontAttributeName, nil]];
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    // 设置是 广泛使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是广泛使用
    [WRNavigationBar wr_widely];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    
    [WRNavigationBar wr_setBlacklist:@[@"SpecialController",
                                       @"TZPhotoPickerController",
                                       @"TZGifPhotoPreviewController",
                                       @"TZAlbumPickerController",
                                       @"TZPhotoPreviewController",
                                       @"TZVideoPlayerController",
                                       @"TZImagePickerController"]];
}



#pragma mark - ------------- 监测网络状态 -------------
- (void)monitorNetworking
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                
                self.netStatus = NO;
                self.net = @"";
                break;
            case 0:
                self.net = @"";
                self.netStatus = NO;
                break;
            case 1:
            {
                
                self.netStatus = YES;
                //发通知，带头搞事
                //                [[NSNotificationCenter defaultCenter] postNotificationName:@"monitorNetworking" object:@"1" userInfo:nil];
                self.net = @"3G|4G";
            }
                break;
            case 2:
            {
                
                self.netStatus = YES;
                self.net = @"wifi";
                //发通知，搞事情
                //                [[NSNotificationCenter defaultCenter] postNotificationName:@"monitorNetworking" object:@"2" userInfo:nil];
            }
                break;
            default:
                break;
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"有网");
        }else{
            NSLog(@"没网");
        }
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark ======  推送相关  ======

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    const unsigned int *tokenBytes = [deviceToken bytes];
    NSString *tokenString = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                             ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                             ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                             ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"Device Token: %@", tokenString);
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册device token失败" message:error.description delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    //    [alert show];
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);

    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        
//        NSDictionary *extras = [userInfo valueForKey:@"extras"];
        NSString * messageId = [NSString stringWithFormat:@"%@",[userInfo valueForKey:@"messageId"]];
        if (messageId && messageId.length != 0) {
            
            [self pushMsgDetailWithMessageId:messageId];
        }
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

#ifdef __IPHONE_12_0
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification {
    NSString *title = nil;
    if (notification) {
        title = @"从通知界面直接进入应用";
    }else{
        title = @"从系统设置界面进入应用";
    }
    UIAlertView *test = [[UIAlertView alloc] initWithTitle:title
                                                   message:@"pushSetting"
                                                  delegate:self
                                         cancelButtonTitle:@"yes"
                                         otherButtonTitles:nil, nil];
    [test show];
    
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

-(UIView *)customSkipView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor getUsualColorWithString:@"#000000"];
    button.alpha = 0.2;
    button.layer.cornerRadius = 15;
    button.layer.borderWidth = 0;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    CGFloat y = XH_IPHONEX ? 73 : 49;
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-84,y, 62, 30);
    [button addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)skipAction
{
    //移除广告
    [XHLaunchAd removeAndAnimated:YES];
}

/**
 *  代理方法 - 倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration
{
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    //设置自定义跳过按钮倒计时
    [button setTitle:[NSString stringWithFormat:@"跳过%lds",duration] forState:UIControlStateNormal];
}

- (void)pushMsgDetailWithMessageId:(NSString *)messageId{
    
    MyLog(@"接收到");
    BMSecurityDetailViewController * detail = [[BMSecurityDetailViewController alloc] init];
    BMSecurityMsgModel * model = [[BMSecurityMsgModel alloc] init];
    model.Id = messageId;
    detail.model = model;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[CommonMethod getCurrentVC].navigationController pushViewController:detail animated:YES];
        
    });
    
}


@end

