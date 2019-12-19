//
//  BMMineViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineViewController.h"

#import "BMMineHeaderView.h"
#import "BMMineTableViewCell.h"

#import "BMMineInfoViewController.h"
#import "BMMineSetViewController.h"
#import "BMQuestionViewController.h"
#import "BMSharePopView.h"

#import "BMManageFenceViewController.h"
#import "BMChooseDeviceViewController.h"
#import "BMNotiSetViewController.h"
#import "BMAddDeviceTitlesViewController.h"

#import "BMHomeModel.h"
#import "BMChooseGroupPopView.h"
@interface BMMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UIButton * setBtn;
@property(nonatomic ,strong)UIButton * messageBtn;

@property(nonatomic ,strong)UITableView * tableView;

@property(nonatomic ,strong)BMMineHeaderView * headerView;
@property(nonatomic ,strong)UserModel * user;

@property (nonatomic, strong) BMHomeModel *homeModel;
@property (nonatomic, strong) BMClusterModel *cluModel;
@property (nonatomic ,copy)NSString * inviteAdUrl;
@end

static NSString * const BMMineTableViewCellID = @"BMMineTableViewCellID";

@implementation BMMineViewController
#pragma mark ======  lazy  ======
- (BMMineHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[BMMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 168 * AutoSizeScaleY + SafeAreaIphoneXTopHeight)];
        
        ZWeakSelf(self);
        _headerView.funcBlock = ^(NSInteger i) {
            
            if (i == 1) {
                
                BMMineInfoViewController * info = [[BMMineInfoViewController alloc] init];
                info.user = weakself.user;
                [weakself.navigationController pushViewController:info animated:YES];
            }else if (i == 2){
                
                BMMineInfoViewController * info = [[BMMineInfoViewController alloc] init];
                info.user = weakself.user;
                [weakself.navigationController pushViewController:info animated:YES];
            }
        };
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[BMMineTableViewCell class] forCellReuseIdentifier:BMMineTableViewCellID];
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self configData];
    [self configGroupData];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    
    [Z_NotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"mineChange" object:nil];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 49);
    }];
    [self configSy];
    
}
- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] userMyInfoWithUserId:UserID ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.user = [UserModel mj_objectWithKeyValues:data[@"data"]];
            self.headerView.user = self.user;
            [[BMUserInfoManager sharedManager] saveUser:self.user];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];

}
- (void)configGroupData{
    
    [[BMHttpsMethod httpMethodManager] userFrontPageWithId:UserID ToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.homeModel = [BMHomeModel mj_objectWithKeyValues:data[@"data"]];
            for (BMClusterModel * cluModel in self.homeModel.clusterList) {
                
                if ([cluModel.Id isEqualToString:self.homeModel.clusterId]) {
                    
                    self.cluModel = cluModel;
                }
            }
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.tableView reloadData];
    }];
}

- (void)configSy{
    
    [[BMHttpsMethod httpMethodManager] settingGetSettingToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            NSLog(@"广告数据 = %@",data[@"data"]);
            self.inviteAdUrl = data[@"data"][@"inviteAdUrl"];
        }
        
    }];
}
#pragma mark ******tableViewDelegate&Datasource******

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1){
        
        return 70 * AutoSizeScaleY;
        
    }else if (section == 2){
        
        return 10 * AutoSizeScaleY;
    }else{
        
        return CGFLOAT_MIN;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 70 * AutoSizeScaleY)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        NSArray * titleArr = [NSArray array];
        BOOL isOwner = NO;
        for (BMClusterModel * clu in self.homeModel.clusterList) {
            
            if ([self.homeModel.clusterId isEqualToString:clu.Id]) {
                
                if ([UserID isEqualToString:clu.ownerId]) {
                    
                    isOwner = YES;
                }
            }
        }
        if (isOwner) {
            
            titleArr = @[@"电子围栏",@"异常停留",@"通知设置"];
        }else{
            
            titleArr = @[@"电子围栏",@"异常停留"];
        }
        NSArray * imgArr = @[@"my_btn_rail",@"my_btn_unusual",@"my_btn_inform"];
        CGFloat width = 70 * AutoSizeScaleX;
        CGFloat height = 60 * AutoSizeScaleX;
        for (int i = 0; i < titleArr.count; i ++) {
            
            UIButton * funcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [funcBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
            [funcBtn setTitle:titleArr[i] forState:UIControlStateNormal];
            [funcBtn setTitleColor:[UIColor getUsualColorWithString:@"#666666"] forState:UIControlStateNormal];
            funcBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            [funcBtn addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
            [funcBtn setImagePositionWithType:SSImagePositionTypeTop spacing:5 * AutoSizeScaleX];
            funcBtn.tag = 500 + i;
            [headerView addSubview:funcBtn];
            [funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(headerView);
                make.size.equalTo(CGSizeMake(width, height));
                make.left.equalTo(15 * AutoSizeScaleX + width * i);
            }];
        }
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 60 * AutoSizeScaleX, Z_SCREEN_WIDTH, 10 * AutoSizeScaleY)];
        line.backgroundColor = [UIColor getUsualColorWithString:@"#F8F8F8"];
        [headerView addSubview:line];
        return headerView;
    }else if (section == 2){
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 10 * AutoSizeScaleY)];
        line.backgroundColor = [UIColor getUsualColorWithString:@"#F8F8F8"];
        return line;
    }else{
        
        return nil;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 53 * AutoSizeScaleY;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }else if (section == 1){
        
        return 2;
    }else if (section == 2){
        
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@[@"设备管理"],@[@"设置",@"常见问题"],@[@"分享应用"]];
    BMMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMMineTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMMineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMMineTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = titleArr[indexPath.section][indexPath.row];
    cell.content = @"";
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        cell.content = self.cluModel.name;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0){
        
        [BMChooseGroupPopView showWithGroupArr:self.homeModel.clusterList blockTapAction:^(BMClusterModel * _Nonnull cluModel) {
           
            [[BMHttpsMethod httpMethodManager] deviceDeviceListWithUserId:UserID ClusterId:cluModel.Id ToGetResult:^(id  _Nonnull data) {
                
                if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                    
                    [self configGroupData];
                    
                }else{
                    
                    [self showHint:data[@"errorMsg"]];
                }
            }];
        }];
        
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            BMMineSetViewController *  set = [[BMMineSetViewController alloc] init];
            set.user = self.user;
            [self.navigationController pushViewController:set animated:YES];
        }else if (indexPath.row == 1){
            
            BMQuestionViewController * question = [[BMQuestionViewController alloc] init];
            [self.navigationController pushViewController:question animated:YES];
        }
    }else{
        
        [BMSharePopView showMoreWithTitle:@[@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"] imgNameArray:@[@"fenxiang_btn_weixin",@"fenxiang_btn_pengyiiu",@"fenxiang_btn_qq",@"fenxiang_btn_kongjian"] blockTapAction:^(NSInteger index) {
            
            [self shareWithIndex:index];
            
        }];
    }
}
#pragma mark ======  设备管理  ===

- (void)func:(UIButton *)btn{
    
    BOOL isOwner = NO;
    for (BMClusterModel * clu in self.homeModel.clusterList) {
        
        if ([self.homeModel.clusterId isEqualToString:clu.Id]) {
            
            if ([UserID isEqualToString:clu.ownerId]) {
                
                isOwner = YES;
            }
        }
    }
   
    
    
    if (btn.tag == 500) {
        
        //电子围栏
        BMManageFenceViewController * fence = [[BMManageFenceViewController alloc] init];
        fence.isOwner = isOwner;
        fence.cluModel = self.cluModel;
        [self.navigationController pushViewController:fence animated:YES];
    }else if (btn.tag == 501){
        
        //异常停留
        
        
        
        if (self.homeModel.deviceList.count == 0) {
            
            if (isOwner) {
                
                [BMPopView showWithContent:@"当前群组未添加设备,是否立即添加?" blockTapAction:^(NSInteger index) {
                    
                    BMAddDeviceTitlesViewController * add = [[BMAddDeviceTitlesViewController alloc] init];
                    add.cluModel = self.cluModel;
                    [self.navigationController pushViewController:add animated:YES];
                }];
            }else{
                
                [self showHint:@"当前群组暂无设备"];
            }
            return;
        }
        BMChooseDeviceViewController * choose = [[BMChooseDeviceViewController alloc] init];
        choose.cluModel = self.cluModel;
        BOOL isOwner = NO;
        for (BMClusterModel * clu in self.homeModel.clusterList) {
            
            if ([self.homeModel.clusterId isEqualToString:clu.Id]) {
                
                if ([UserID isEqualToString:clu.ownerId]) {
                    
                    isOwner = YES;
                }
            }
        }
        choose.isOwner = isOwner;
        [self.navigationController pushViewController:choose animated:YES];
    }else if (btn.tag == 502){
        
        //通知设置
        BMNotiSetViewController * noti = [[BMNotiSetViewController alloc] init];
        noti.cluModel = self.cluModel;
        [self.navigationController pushViewController:noti animated:YES];
    }
}

#pragma mark ======  分享  ======

- (void)shareWithIndex:(NSInteger)index{
    
    NSArray * typeArr = @[@1,@2,@4,@5];
    NSNumber * i = typeArr[index];
    UserModel * user = [[BMUserInfoManager sharedManager] getUser];
    NSString * shareUrl = [NSString stringWithFormat:@"%@modelView/invite/register/%@",BaseURL,user.phoneNo];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象

    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"智能书包邀请注册" descr:[NSString stringWithFormat:@"好友邀请您注册智能书包App，让我们一起守护您和家人的安全。"] thumImage:self.inviteAdUrl];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
