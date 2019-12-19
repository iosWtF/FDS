//
//  BMNotiSetViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMNotiSetViewController.h"

#import "BMNotiSetTableViewCell.h"
#import "BMClusterUserModel.h"
@interface BMNotiSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)UIView * headerView;
@property(nonatomic ,strong)NSMutableArray * sourceArr;
@end

static NSString * const BMNotiSetTableViewCellID = @"BMNotiSetTableViewCellID";

@implementation BMNotiSetViewController

#pragma mark ======  lazy  ======

- (UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 40 * AutoSizeScaleY)];
        UILabel * titleLb = [[UILabel alloc] initWithFrame:CGRectMake(15 * AutoSizeScaleX, 0, Z_SCREEN_WIDTH - 30 * AutoSizeScaleX, 40 * AutoSizeScaleY)];
        titleLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        titleLb.font = [UIFont systemFontOfSize:13.f];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.text = @"选择设备发送SOS及出入电子围栏、异常停留通知对象";
        [_headerView addSubview:titleLb];
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[BMNotiSetTableViewCell class] forCellReuseIdentifier:BMNotiSetTableViewCellID];
    }
    return _tableView;
}

#pragma mark ======  完成  ======
- (void)finish{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"通知设置";
    [self.customNavBar wr_setRightButtonWithTitle:@"完成" titleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    self.customNavBar.rightButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    ZWeakSelf(self);
    self.customNavBar.onClickRightButton = ^{
        
        ZStrongSelf(self);
        [self finish];
    };
    self.sourceArr = [[NSMutableArray alloc] init];
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
    
    [[BMHttpsMethod httpMethodManager] clusterGetUserListWithClusterId:self.cluModel.Id ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.sourceArr = [BMClusterUserModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.tableView reloadData];
    }];
    
}

#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53 * AutoSizeScaleY;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArr.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMClusterUserModel * user = self.sourceArr[indexPath.row];
    BMNotiSetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMNotiSetTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMNotiSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMNotiSetTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.user = user;
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BMClusterUserModel * user = self.sourceArr[indexPath.row];
    NSString * remind;
    if ([user.remind isEqualToString:@"1"]) {
        
        remind = @"0";
    }else{
        
        remind = @"1";
    }
    
    [[BMHttpsMethod httpMethodManager] clusterUserRemindWithId:user.userClusterId Remind:remind ToGetResult:^(id  _Nonnull data) {
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            if ([user.remind isEqualToString:@"1"]) {
                
                user.remind = @"0";
            }else{
                
                user.remind = @"1";
            }
            BMNotiSetTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.user = user;
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
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
