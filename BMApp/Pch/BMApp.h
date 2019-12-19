//
//  BMApp.h
//  BMApp
//
//  Created by Mac on 2019/5/22.
//  Copyright © 2019 BM. All rights reserved.
//

#ifndef BMApp_h
#define BMApp_h

//#define BaseURL @"http://192.168.0.66:8081/"

#define BaseURL @"http://121.40.151.219:8082/"


//https://www.showdoc.cc/519850499813358?page_id=3072742786560147
#define NUD_USER @"user"
#define NUD_USER_INFROMATION @"user_info"
#define NUD_CITY_INFROMATION @"user_city"
#define UserID [[BMUserInfoManager sharedManager] isLoginIn]?[[BMUserInfoManager sharedManager] getUser].userId:@""
#define UserType [[BMUserInfoManager sharedManager] isLoginIn]?[[BMUserInfoManager sharedManager] getUser].type:@""

#define UserInfoManager [BMUserInfoManager sharedManager]
#define USER_DEFAULT  [NSUserDefaults standardUserDefaults]
#define PageSize @"10"

#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

//常用宏定义
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SH ORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS

//1.获取屏幕宽度与高度
//需要横屏或者竖屏，获取屏幕宽度与高度
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define Z_SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define Z_SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define Z_SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define Z_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define Z_SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Z_SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif
//获取不同设备比例尺寸
#define MyUIScreenWidth  375.0
//状态栏加导航栏高度
#define SafeAreaTopHeight (Z_SCREENH_HEIGHT > 812.0 || Z_SCREENH_HEIGHT == 812.0 ? 88 : 64)
//状态栏高度
#define SafeAreaTopStatusHeight (Z_SCREENH_HEIGHT > 812.0 || Z_SCREENH_HEIGHT == 812.0 ? 44 : 20)

#define SafeAreaIphoneXTopHeight (Z_SCREENH_HEIGHT > 812.0 || Z_SCREENH_HEIGHT == 812.0 ? 24 : 0)
//底部高度
#define SafeAreaBottomHeight (Z_SCREENH_HEIGHT > 812.0 || Z_SCREENH_HEIGHT == 812.0 ? 34 : 0)

#define AutoSizeScaleX Z_SCREEN_WIDTH/MyUIScreenWidth
//#define AutoSizeScaleY (Z_SCREENH_HEIGHT == 812.0 ? 1.0 : Z_SCREENH_HEIGHT/667.0)
#define AutoSizeScaleY Z_SCREEN_WIDTH/MyUIScreenWidth
//2.获取通知中心
#define Z_NotificationCenter [NSNotificationCenter defaultCenter]

//3.设置随机颜色
#define Z_RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//4.设置RGB颜色/设置RGBA颜色
#define Z_RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Z_RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// clear背景颜色
#define Z_ClearColor [UIColor clearColor]

//6.弱引用/强引用
#define ZWeakSelf(type)  __weak typeof(type) weak##type = type;
#define ZStrongSelf(type)  __strong typeof(type) type = weak##type;

//7.设置 view 圆角和边框
#define ZViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//8.由角度转换弧度 由弧度转换角度
#define ZDegreesToRadian(x) (M_PI * (x) / 180.0)
#define ZRadianToDegrees(radian) (radian*180.0)/(M_PI)


//10.设置加载提示框（第三方框架：MBProgressHUD）
// 加载
#define ZShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define ZHideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define ZNetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define ZWindow [UIApplication sharedApplication].keyWindow

#define kBackView         for (UIView *item in ZWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[kWindow addSubview:aView]; \
} \
} \

#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:ZWindow animated:YES];kShowNetworkActivityIndicator()


#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:ZWindow animated:YES]

#define kRemoveBackView         for (UIView *item in ZWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \

#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()


//11.获取view的frame/图片资源
//获取view的frame（不建议使用）
//#define kGetViewWidth(view)  view.frame.size.width
//#define kGetViewHeight(view) view.frame.size.height
//#define kGetViewX(view)      view.frame.origin.x
//#define kGetViewY(view)      view.frame.origin.y

//获取图片资源
#define ZGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


//12.获取当前语言
#define ZCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//13.使用 ARC 和 MRC
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif

//14.判断当前的iPhone设备/系统版本
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

//15.判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//16.沙盒目录文件
//获取temp
#define ZPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define ZPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define ZPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//17.GCD 的宏定义
//GCD - 一次性执行
#define ZDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//GCD - 在Main线程上运行
#define ZDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//GCD - 开启异步线程
#define ZDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);


/**Dubug相关*/

#ifdef DEBUG
#define MyLog(format,...)  NSLog((@"[函数名:%s]\n" "[行号:%d]\n" format),__FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define MyLog(...)
#endif
#ifdef DEBUG

#define LHLog( s, ... ) printf("%s\n",  [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] )

#else

#define LHLog( s, ... )

#endif
#define LBXScan_Define_Native  //包含native库
#define LBXScan_Define_ZXing   //包含ZXing库
#define LBXScan_Define_ZBar   //包含ZBar库
#define LBXScan_Define_UI     //包含界面库

#endif /* BMApp_h */


