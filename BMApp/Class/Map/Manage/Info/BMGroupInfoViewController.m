//
//  BMGroupInfoViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMGroupInfoViewController.h"
#import "BMGroupInfoHeaderView.h"
#import "BMGroupInfoTableViewCell.h"
#import "BMMemberInfoViewController.h"
#import "BMDeviceInfoViewController.h"
#import "BMManageFenceViewController.h"
#import "BMChooseDeviceViewController.h"

#import "BMGroupModel.h"
@interface BMGroupInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)BMGroupInfoHeaderView * headerView;
@property(nonatomic ,strong)UIView * footerView;
@property(nonatomic ,strong)NSMutableArray * sourceArr;
@property(nonatomic ,strong)BMGroupModel * groupModel;
@end

static NSString * const BMGroupInfoTableViewCellID = @"BMGroupInfoTableViewCellID";

@implementation BMGroupInfoViewController
#pragma mark ======  lazy  ======
- (BMGroupInfoHeaderView *)headerView{
    
    if (!_headerView) {
        
        
        _headerView = [[BMGroupInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 130 * AutoSizeScaleY)];
        ZWeakSelf(self);
        _headerView.typeBlock = ^(NSInteger i) {
          
            //信息
            BMClusterUserModel * model = weakself.groupModel.clusterUserList[i];
            BMMemberInfoViewController * info = [[BMMemberInfoViewController alloc] init];
            info.isOwner = NO;
            info.model = model;
            [weakself.navigationController pushViewController:info animated:YES];
        };
        _headerView.checkAllBlock = ^{
            
            [weakself.tableView beginUpdates];
            [weakself.tableView setTableHeaderView:weakself.headerView];
            [weakself.tableView endUpdates];
            
        };
    }
    return _headerView;
}
- (UIView *)footerView{
    
    if (!_footerView) {
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 65 * AutoSizeScaleY)];
        _footerView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        UIButton * quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [quitBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
        [quitBtn setTitle:@"退出群组" forState:UIControlStateNormal];
        [quitBtn setTitleColor:[UIColor getUsualColorWithString:@"#4285F4"] forState:UIControlStateNormal];
        quitBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [quitBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:quitBtn];
        [quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
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

- (void)dealloc{
    
    [Z_NotificationCenter removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = self.clusterModel.name;
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"changeGroupInfo" object:nil];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight);
    }];
    [self configData];
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

#pragma mark ======  退出群组  ======

- (void)quit{
    
    [BMPopView showWithContent:@"是否确定退出当前群组?" blockTapAction:^(NSInteger index) {
       
        [[BMHttpsMethod httpMethodManager] clusterUserRemoveWithClusterId:self.groupModel.cluster.Id UserId:UserID ToGetResult:^(id  _Nonnull data) {
            
            
            if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                
                [self showHint:@"退出成功"];
                [Z_NotificationCenter postNotificationName:@"changeGroupInfo" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
                [self showHint:data[@"errorMsg"]];
            }
            
        }];
    }];

}

#pragma mark ******tableViewDelegate&Datasource******

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGFLOAT_MIN;
    }else{
        return 45* AutoSizeScaleY;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return nil;
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
        
        return self.groupModel.deviceList.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@"群名称",@"围栏信息",@"异常停留"];
    BMGroupInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMGroupInfoTableViewCellID forIndexPath:indexPath];
    if (!cell) {

        cell = [[BMGroupInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMGroupInfoTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.content = @"";
    cell.arrowImgView.hidden = NO;
    if (indexPath.section == 0) {
        
        cell.title = titleArr[indexPath.row];
        cell.imgHidden = YES;
        if (indexPath.row == 0) {
            
            cell.content = self.groupModel.cluster.name;
            cell.arrowImgView.hidden = YES;
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
        
        if (indexPath.row == 1) {
            
            //围栏信息
            BMManageFenceViewController * fence = [[BMManageFenceViewController alloc] init];
            fence.cluModel = self.groupModel.cluster;
            [self.navigationController pushViewController:fence animated:YES];
        }else if (indexPath.row == 2){
            
            //异常停留
            if (self.groupModel.deviceList.count == 0) {
                
                [self showHint:@"当前群组暂无设备"];
                return;
            }
            
            BMChooseDeviceViewController * choose = [[BMChooseDeviceViewController alloc] init];
            choose.cluModel = self.groupModel.cluster;
            [self.navigationController pushViewController:choose animated:YES];
        }
    }else{
        
        //设备信息
        BMDeviceInfoViewController * info = [[BMDeviceInfoViewController alloc] init];
        info.device = self.groupModel.deviceList[indexPath.row];
        [self.navigationController pushViewController:info animated:YES];
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
