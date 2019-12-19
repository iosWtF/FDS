//
//  BMFootprintViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMFootprintViewController.h"

#import "BMFootprintHeaderView.h"
#import "BMFootprintTableViewCell.h"
#import "BMFootprintSectionHeaderView.h"
#import "BMCheckFootprintViewController.h"
#import "BMFootprintModel.h"
@interface BMFootprintViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)NSMutableArray * sourceArr;
@property(nonatomic ,strong)UITableView * tableView;

@property(nonatomic ,strong)BMFootprintHeaderView * headerView;
@property(nonatomic ,copy)NSString * cityCount;
@property(nonatomic ,copy)NSString * positionCount;
@property(nonatomic ,copy)NSString * currentDate;
@end

static NSString * const BMFootprintTableViewCellID = @"BMFootprintTableViewCellID";
static NSString * const BMFootprintSectionHeaderViewID = @"BMFootprintSectionHeaderViewID";
@implementation BMFootprintViewController
#pragma mark ======  lazy  ======

- (NSMutableArray *)sourceArr{
    
    if (!_sourceArr) {
        
        _sourceArr = [[NSMutableArray alloc] init];
    }
    return _sourceArr;
}

- (BMFootprintHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[BMFootprintHeaderView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 140 * AutoSizeScaleY)];
        _headerView.icon = self.device.picUrl;
        _headerView.date = self.device.refreshTime;
        ZWeakSelf(self);
        _headerView.leftBlock = ^{
          
            weakself.currentDate = [CommonMethod fontDate:weakself.currentDate];
            weakself.headerView.date = weakself.currentDate;
            [weakself configData];
        };
        _headerView.rightBlock = ^{
            
            weakself.currentDate = [CommonMethod nextDate:weakself.currentDate];
            weakself.headerView.date = weakself.currentDate;
            [weakself configData];
        };
        
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMFootprintTableViewCell class] forCellReuseIdentifier:BMFootprintTableViewCellID];
        [_tableView registerClass:[BMFootprintSectionHeaderView class] forHeaderFooterViewReuseIdentifier:BMFootprintSectionHeaderViewID];
        _tableView.tableHeaderView = self.headerView;
        UIImageView *backImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight)];
        [backImageView setImage:[UIImage imageNamed:@"zuji_bg_dis"]];
        _tableView.backgroundView=backImageView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"足迹";
    [self.customNavBar wr_setRightButtonWithTitle:@"轨迹查看" titleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    self.customNavBar.rightButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    ZWeakSelf(self);
    self.customNavBar.onClickRightButton = ^{
        
        if (weakself.sourceArr.count == 0) {
            
            [weakself showHint:@"暂无轨迹"];
            return;
        }
        
        BMCheckFootprintViewController * check = [[BMCheckFootprintViewController alloc] init];
        check.device = weakself.device;
        check.currentDate = weakself.currentDate;
        [weakself.navigationController pushViewController:check animated:YES];
    };
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
    self.currentDate = self.device.refreshTime;
    [self configData];
}
- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] positionGetListWithDate:[CommonMethod configYear:self.currentDate] DeviceId:self.device.Id ToGetResult:^(id  _Nonnull data) {
       
        LHLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.headerView.cityCount = data[@"data"][@"cityCount"];
            self.cityCount =data[@"data"][@"cityCount"];
            self.headerView.positionCount = data[@"data"][@"positionCount"];
            self.positionCount =data[@"data"][@"positionCount"];
            self.sourceArr = data[@"data"][@"positionList"];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.tableView reloadData];
        
    }];
    
}

#pragma mark ******tableViewDelegate&Datasource******

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 70 * AutoSizeScaleY;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BMPositionModel * model = [BMPositionModel mj_objectWithKeyValues:self.sourceArr[section][0]];
    BMFootprintSectionHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:BMFootprintSectionHeaderViewID];
    if (!header) {
        
        header = [[BMFootprintSectionHeaderView alloc] initWithReuseIdentifier:BMFootprintSectionHeaderViewID];
    }
    header.model = model;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMPositionModel * model = [BMPositionModel mj_objectWithKeyValues:self.sourceArr[indexPath.section][indexPath.row]];

    MyLog(@"%f",[tableView fd_heightForCellWithIdentifier:BMFootprintTableViewCellID configuration:^(BMFootprintTableViewCell * cell) {
        
        cell.model = model;
    }]);
    
    return [tableView fd_heightForCellWithIdentifier:BMFootprintTableViewCellID configuration:^(BMFootprintTableViewCell * cell) {
        
        cell.model = model;
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray * arr = self.sourceArr[section];
    return arr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMPositionModel * model = [BMPositionModel mj_objectWithKeyValues:self.sourceArr[indexPath.section][indexPath.row]];
    BMFootprintTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMFootprintTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMFootprintTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMFootprintTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
