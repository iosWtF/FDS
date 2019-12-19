//
//  BMMineGroupInfoViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineGroupInfoViewController.h"

#import "BMMineGroupInfoHeaderView.h"
#import "BMGroupInfoTableViewCell.h"
#import "BMChangeGroupNameViewController.h"
#import "BMGroupCodeViewController.h"
#import "BMManageFenceViewController.h"
#import "BMUrgentSetViewController.h"
#import "BMNotiSetViewController.h"
#import "BMChooseDeviceViewController.h"
#import "BMChangeDeviceInfoViewController.h"
#import "BMAddDeviceTitlesViewController.h"
#import "BMGroupModel.h"

#import "BMMemberInfoViewController.h"
#import "BMClusterUserModel.h"

@interface BMMineGroupInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)BMMineGroupInfoHeaderView * headerView;
@property(nonatomic ,strong)UIView * footerView;
@property(nonatomic ,strong)BMGroupModel * groupModel;
@property(nonatomic ,strong)NSMutableArray * sourceArr;

@property (nonatomic ,copy)NSString * inviteJoinUrl;
@end

static NSString * const BMGroupInfoTableViewCellID = @"BMGroupInfoTableViewCellID";

@implementation BMMineGroupInfoViewController
#pragma mark ======  lazy  ======
- (BMMineGroupInfoHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[BMMineGroupInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 130 * AutoSizeScaleY)];
        
        ZWeakSelf(self);
        _headerView.checkAllBlock = ^{
          
            [weakself.tableView beginUpdates];
            [weakself.tableView setTableHeaderView:weakself.headerView];
            [weakself.tableView endUpdates];
            
        };
        
        _headerView.typeBlock = ^(NSInteger i) {
            ZStrongSelf(self);
            if ((self.groupModel.clusterUserList.count + 1) > 10) {
                
                if (i == 9) {
                    //邀请
                    [BMSharePopView showMoreWithTitle:@[@"微信好友",@"QQ好友"] imgNameArray:@[@"fenxiang_btn_weixin",@"fenxiang_btn_qq"] blockTapAction:^(NSInteger index) {
                        
                        [self shareWithIndex:index];
                    }];
                }else{
                    //信息
                    BMClusterUserModel * model = weakself.groupModel.clusterUserList[i];
                    BMMemberInfoViewController * info = [[BMMemberInfoViewController alloc] init];
                    info.isOwner = YES;
                    info.model = model;
                    [weakself.navigationController pushViewController:info animated:YES];
                }
            }else{
                
    
                if (i == self.groupModel.clusterUserList.count) {
                    
                    //邀请
                    [BMSharePopView showMoreWithTitle:@[@"微信好友",@"QQ好友"] imgNameArray:@[@"fenxiang_btn_weixin",@"fenxiang_btn_qq"] blockTapAction:^(NSInteger index) {
                        
                        [self shareWithIndex:index];
                    }];
                }else{
                    
                    //信息
                    BMClusterUserModel * model = weakself.groupModel.clusterUserList[i];
                    BMMemberInfoViewController * info = [[BMMemberInfoViewController alloc] init];
                    info.isOwner = YES;
                    info.model = model;
                    [weakself.navigationController pushViewController:info animated:YES];
                }
            }
        };
    }
    return _headerView;
}
- (UIView *)footerView{
    
    if (!_footerView) {
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 65 * AutoSizeScaleY)];
        _footerView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        UIButton * disbandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [disbandBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
        [disbandBtn setTitle:@"解散群" forState:UIControlStateNormal];
        [disbandBtn setTitleColor:[UIColor getUsualColorWithString:@"#F44242"] forState:UIControlStateNormal];
        disbandBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [disbandBtn addTarget:self action:@selector(disband) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:disbandBtn];
        [disbandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.width.equalTo(self.footerView);
            make.bottom.equalTo(self.footerView);
            make.height.equalTo(55 * AutoSizeScaleY);
        }];
    }
    return _footerView;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[BMGroupInfoTableViewCell class] forCellReuseIdentifier:BMGroupInfoTableViewCellID];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

#pragma mark ======  分享  ======

- (void)shareWithIndex:(NSInteger)index{
    
    NSArray * typeArr = @[@1,@4];
    NSNumber * i = typeArr[index];
    UserModel * user = [[BMUserInfoManager sharedManager] getUser];
    NSString * shareUrl = [NSString stringWithFormat:@"%@modelView/invite/join/%@/%@",BaseURL,user.phoneNo,self.groupModel.cluster.Id];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"智能书包邀请加群" descr:[NSString stringWithFormat:@"好友邀请您加入\"%@\"，让我们一起守护您和家人的安全。",self.groupModel.cluster.name] thumImage:self.inviteJoinUrl];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = self.clusterModel.name;
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"changeGroupInfo" object:nil];
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"deviceChange" object:nil];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight + 10 * AutoSizeScaleY);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight);
    }];
    [self configData];
    [self configSy];
}
- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] clusterGetClusterInfoWithUserId:UserID ClusterId:self.clusterModel.Id ToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.groupModel = [BMGroupModel mj_objectWithKeyValues:data[@"data"]];
            
            self.headerView.sourceArr = self.groupModel.clusterUserList;
            self.customNavBar.title = self.groupModel.cluster.name;
//            [self.tableView beginUpdates];
            self.tableView.tableHeaderView = self.headerView;
//            [self.tableView endUpdates];
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
            self.inviteJoinUrl = data[@"data"][@"inviteJoinUrl"];
        }
        
    }];
}

#pragma mark ======  添加设备  ======
- (void)addDevice{
    
    BMAddDeviceTitlesViewController * add = [[BMAddDeviceTitlesViewController alloc] init];
    add.cluModel = self.groupModel.cluster;
    [self.navigationController pushViewController:add animated:YES];
    
}
#pragma mark ======  解散群  ======
- (void)disband{
    
    [BMPopView showWithContent:@"是否解散当前群组?" blockTapAction:^(NSInteger index) {
       
        [[BMHttpsMethod httpMethodManager] clusterDissolveWithClusterId:self.groupModel.cluster.Id ToGetResult:^(id  _Nonnull data) {
            
            if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                
                [self showHint:@"解散成功"];
                [Z_NotificationCenter postNotificationName:@"dissolveClu" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
                [self showHint:data[@"errorMsg"]];
            }
        }];

    }];

}
#pragma mark ******tableViewDelegate&Datasource******

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGFLOAT_MIN;
    }else if (section == 1) {
        
        return 10 * AutoSizeScaleY;
    }else{
        return 45* AutoSizeScaleY;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {

        return nil;
    }else if (section == 1) {
        
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 10 * AutoSizeScaleY)];
        bgView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        return bgView;
    }else{
        
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 45 * AutoSizeScaleY)];
        bgView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        UILabel * titleLb = [[UILabel alloc] init];
        titleLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        titleLb.font = [UIFont systemFontOfSize:16.f];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.text = @"设备信息";
        [bgView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(bgView);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.height.equalTo(bgView);
        }];
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitle:@"添加设备" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor getUsualColorWithString:@"#000000"] forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [addBtn addTarget:self action:@selector(addDevice) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.height.equalTo(bgView);
            make.width.equalTo(80 * AutoSizeScaleX);
            make.right.equalTo(bgView);
        }];
        
        return bgView;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 55 * AutoSizeScaleY;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 3;
    }else if (section == 1){
        
        return 3;
    }else if (section == 2){
        
        return self.groupModel.deviceList.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@[@"群名称",@"群组二维码",@"围栏管理"],@[@"紧急状态",@"异常停留",@"通知设置"]];
    BMGroupInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMGroupInfoTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMGroupInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMGroupInfoTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.content = @"";
    cell.title = @"";
    if (indexPath.section == 0 || indexPath.section == 1) {
        
        cell.title = titleArr[indexPath.section][indexPath.row];
        cell.imgHidden = YES;
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            cell.content = self.groupModel.cluster.name;
        }
    }else{
        
        cell.imgHidden = NO;
        BMDeviceModel * device = self.groupModel.deviceList[indexPath.row];
        cell.deviceModel = device;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            //修改群名称
            BMChangeGroupNameViewController * change = [[BMChangeGroupNameViewController alloc] init];
            change.model = self.clusterModel;
            [self.navigationController pushViewController:change animated:YES];
        }else if (indexPath.row == 1) {
            
            //群组二维码
            BMGroupCodeViewController * code = [[BMGroupCodeViewController alloc] init];
            code.model = self.groupModel.cluster;
            [self.navigationController pushViewController:code animated:YES];
        }else if (indexPath.row == 2) {
            
            //围栏管理
            BMManageFenceViewController * fence = [[BMManageFenceViewController alloc] init];
            fence.isOwner = YES;
            fence.cluModel = self.groupModel.cluster;
            [self.navigationController pushViewController:fence animated:YES];
        }
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            //紧急状态
            if (self.groupModel.deviceList.count == 0) {
                
                [BMPopView showWithContent:@"当前群组未添加设备,是否立即添加?" blockTapAction:^(NSInteger index) {

                    BMAddDeviceTitlesViewController * add = [[BMAddDeviceTitlesViewController alloc] init];
                    add.cluModel = self.groupModel.cluster;
                    [self.navigationController pushViewController:add animated:YES];
                }];
                return;
            }
            
            
            BMUrgentSetViewController * urgent = [[BMUrgentSetViewController alloc] init];
            urgent.cluModel = self.groupModel.cluster;
            [self.navigationController pushViewController:urgent animated:YES];
        }else if (indexPath.row == 1) {
            
            //异常状态
            if (self.groupModel.deviceList.count == 0) {
                
                [BMPopView showWithContent:@"当前群组未添加设备,是否立即添加?" blockTapAction:^(NSInteger index) {
                    
                    BMAddDeviceTitlesViewController * add = [[BMAddDeviceTitlesViewController alloc] init];
                    add.cluModel = self.groupModel.cluster;
                    [self.navigationController pushViewController:add animated:YES];
                }];
                return;
            }
            
            
            BMChooseDeviceViewController * choose = [[BMChooseDeviceViewController alloc] init];
            choose.cluModel = self.groupModel.cluster;
            choose.isOwner = YES;
            [self.navigationController pushViewController:choose animated:YES];
        }else if (indexPath.row == 2) {
            
            //通知设置
            BMNotiSetViewController * noti = [[BMNotiSetViewController alloc] init];
            noti.cluModel = self.groupModel.cluster;
            [self.navigationController pushViewController:noti animated:YES];
        }
    }else{
        
        //设备信息
        BMChangeDeviceInfoViewController * change = [[BMChangeDeviceInfoViewController alloc] init];
        change.device = self.groupModel.deviceList[indexPath.row];
        [self.navigationController pushViewController:change animated:YES];
    }
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
