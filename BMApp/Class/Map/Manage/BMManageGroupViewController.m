//
//  BMManageGroupViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMManageGroupViewController.h"

#import "BMManageGroupTableViewCell.h"
#import "BMCreateGroupViewController.h"

#import "BMGroupInfoViewController.h"
#import "BMMineGroupInfoViewController.h"
#import "BMClusterModel.h"

@interface BMManageGroupViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)NSMutableArray * createClusterList;
@property(nonatomic ,strong)NSMutableArray * joinClusterList;
@end

static NSString * const BMManageGroupTableViewCellID = @"BMManageGroupTableViewCellID";

@implementation BMManageGroupViewController
#pragma mark ======  lazy  ======

- (NSMutableArray *)createClusterList{
    
    if (!_createClusterList) {
        
        _createClusterList = [[NSMutableArray alloc] init];
    }
    return _createClusterList;
}
- (NSMutableArray *)joinClusterList{
    
    if (!_joinClusterList) {
        
        _joinClusterList = [[NSMutableArray alloc] init];
    }
    return _joinClusterList;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMManageGroupTableViewCell class] forCellReuseIdentifier:BMManageGroupTableViewCellID];
        UIImageView *backImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight)];
        [backImageView setImage:[UIImage imageNamed:@"zuji_bg_dis"]];
        self.tableView.backgroundView=backImageView;
    }
    return _tableView;
}
- (void)dealloc{
    
    [Z_NotificationCenter removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZWeakSelf(self);
    self.customNavBar.title = @"群组管理";
    [self.customNavBar wr_setRightButtonWithTitle:@"创建" titleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    self.customNavBar.onClickRightButton = ^{
      
        BMCreateGroupViewController * create = [[BMCreateGroupViewController alloc] init];
        [weakself.navigationController pushViewController:create animated:YES];
    };
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"createGroup" object:nil];
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"changeGroupInfo" object:nil];
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"dissolveClu" object:nil];
    
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
    
    [[BMHttpsMethod httpMethodManager] clusterGetClusterListWithUserId:UserID ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.createClusterList = [BMClusterModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"createClusterList"]];
            self.joinClusterList = [BMClusterModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"joinClusterList"]];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.tableView reloadData];

    }];
    
}

#pragma mark ******tableViewDelegate&Datasource******

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 && self.createClusterList.count == 0) {
        
        return CGFLOAT_MIN;
    }
    if (section == 1 && self.joinClusterList.count == 0) {
        
        return CGFLOAT_MIN;
    }
    return 45* AutoSizeScaleY;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0 && self.createClusterList.count == 0) {
        
        return nil;
    }
    if (section == 1 && self.joinClusterList.count == 0) {
        
        return nil;
    }
    NSArray * titleArr = @[@"我创建的",@"我加入的"];
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 45 * AutoSizeScaleY)];
    bgView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    UILabel * titleLb = [[UILabel alloc] init];
    titleLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
    titleLb.font = [UIFont systemFontOfSize:14.f];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.text = titleArr[section];
    [bgView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(bgView);
        make.left.equalTo(15 * AutoSizeScaleX);
        make.height.equalTo(bgView);
    }];
    return bgView;
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
        
        return self.createClusterList.count;
    }else if (section == 1){
        
        return self.joinClusterList.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BMClusterModel * model;
    if (indexPath.section == 0) {
        
         model= self.createClusterList[indexPath.row];
        
    }
    if (indexPath.section == 1) {
        
         model = self.joinClusterList[indexPath.row];
        
    }
    BMManageGroupTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMManageGroupTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMManageGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMManageGroupTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        BMMineGroupInfoViewController * mine = [[BMMineGroupInfoViewController alloc] init];
        mine.clusterModel = self.createClusterList[indexPath.row];
        [self.navigationController pushViewController:mine animated:YES];
        
    }else{
        
        BMGroupInfoViewController * info = [[BMGroupInfoViewController alloc] init];
        info.clusterModel = self.joinClusterList[indexPath.row];
        [self.navigationController pushViewController:info animated:YES];
    }
    
}
#pragma mark ======  DZNEmptyDataSetSource  ======
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tableView.mj_footer.hidden = YES;
    if (!appDelegate.netStatus) {
        
        return [UIImage imageNamed:@"无网状态"];
    }else{
        
        return [UIImage imageNamed:@"chuku_bg_wu"];
    }
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    
    return 0 * AutoSizeScaleY;
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.netStatus) {
        
        return nil;
    }
    // 设置按钮标题
    NSString *buttonTitle = @"暂无创建/加入群组";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f],NSForegroundColorAttributeName:[UIColor getUsualColorWithString:@"#929292"]
                                 };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}
#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // button clicked...
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
