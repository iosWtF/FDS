//
//  BMChooseDeviceViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMChooseDeviceViewController.h"

#import "BMChooseDeviceTableViewCell.h"
#import "BMPeriodViewController.h"
#import "BMDeviceModel.h"
@interface BMChooseDeviceViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic ,strong)UITableView * tableView;

@property(nonatomic ,strong)NSMutableArray * sourceArr;
@end

static NSString * const BMChooseDeviceTableViewCellID = @"BMChooseDeviceTableViewCellID";

@implementation BMChooseDeviceViewController

#pragma mark ======  lazy  ======

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMChooseDeviceTableViewCell class] forCellReuseIdentifier:BMChooseDeviceTableViewCellID];
    }
    return _tableView;
}

- (void)dealloc{
    
    [Z_NotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"retentionChange" object:nil];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"选择设备";
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
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
    
    
    [[BMHttpsMethod httpMethodManager] deviceDeviceListWithUserId:UserID ClusterId:self.cluModel.Id ToGetResult:^(id  _Nonnull data) {
        
        LHLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.sourceArr = [BMDeviceModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            
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
    
    BMDeviceModel * device = self.sourceArr[indexPath.row];
    BMChooseDeviceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMChooseDeviceTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMChooseDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMChooseDeviceTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.device = device;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMDeviceModel * device = self.sourceArr[indexPath.row];
    BMPeriodViewController * period = [[BMPeriodViewController alloc] init];
    period.device = device;
    period.isOwner = self.isOwner;
    [self.navigationController pushViewController:period animated:YES];
}
#pragma mark ======  DZNEmptyDataSetSource  ======
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tableView.mj_footer.hidden = YES;
    if (!appDelegate.netStatus) {
        
        return [UIImage imageNamed:@"无网状态"];
    }else{
        
        return [UIImage imageNamed:@"shebei_bg_wu"];
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
    NSString *buttonTitle = @"暂无设备";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f],NSForegroundColorAttributeName:[UIColor getUsualColorWithString:@"#666666"]
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
