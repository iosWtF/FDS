//
//  BMAnswerViewController.m
//  BMApp
//
//  Created by Mac on 2019/10/24.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMAnswerViewController.h"

#import <WebKit/WebKit.h>

@interface BMAnswerViewController ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic ,strong)WKWebView * webView;
@end

@implementation BMAnswerViewController

- (void)dealloc{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title =self.question.name;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupWebView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setupWebView{
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    wkWebConfig.userContentController = wkUController;
    // 自适应屏幕宽度js
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加js调用
    [wkUController addUserScript:wkUserScript];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaTopHeight) configuration:wkWebConfig];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:self.question.content baseURL:nil];
}
#pragma mark ======  WebViewDelegate  ======
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    //    self.title = webView.title;
    [SVProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
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
