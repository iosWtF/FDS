//
//  BMQuestionViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMQuestionViewController.h"

#import "BMQuestionTableViewCell.h"
#import "BMQuestionModel.h"

#import "BMAnswerViewController.h"
@interface BMQuestionViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)NSMutableArray * sourceArr;
@property(nonatomic ,assign)NSInteger page;

@end

static NSString * const BMQuestionTableViewCellID = @"BMQuestionTableViewCellID";
@implementation BMQuestionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"常见问题";
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F5F5"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo( SafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight);
    }];
    [self refreshData];
   
}

#pragma mark 刷新加载
//刷新
- (void)refreshData{
    
    self.page = 1;
    
    [[BMHttpsMethod httpMethodManager] questionPageWithPageNow:@"1" Size:PageSize ToGetResult:^(id  _Nonnull data) {
       
        
        LHLog(@"%@",data);
        [self.tableView.mj_header endRefreshing];
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.sourceArr = [BMQuestionModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"records"]];
            [CommonMethod RefreshSetMj_footerHidden:self.sourceArr Size:10 ScrollView:self.tableView];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.tableView reloadData];
        
    }];
}
//加载
- (void)loadData{
    
    if (self.sourceArr.count != 0) {
        
        self.page ++;
    }

    [[BMHttpsMethod httpMethodManager] questionPageWithPageNow:[NSString stringWithFormat:@"%ld",self.page] Size:PageSize ToGetResult:^(id  _Nonnull data){
        
        [self.tableView.mj_footer endRefreshing];
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            //请求成功
            NSMutableArray * tempArr = [NSMutableArray arrayWithArray:data[@"data"][@"records"]];
            [self.sourceArr addObjectsFromArray:[BMQuestionModel mj_objectArrayWithKeyValuesArray:tempArr]];
            [self.tableView reloadData];
            [CommonMethod LoadDataSetMj_footerHidden:self.sourceArr Page:self.page ScrollView:self.tableView];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
}

#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMQuestionModel * model = self.sourceArr[indexPath.row];
    
    return [tableView fd_heightForCellWithIdentifier:BMQuestionTableViewCellID configuration:^(BMQuestionTableViewCell * cell) {
        
        cell.question = model;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMQuestionModel * model = self.sourceArr[indexPath.row];
    BMQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMQuestionTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMQuestionTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.question = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMQuestionModel * question = self.sourceArr[indexPath.row];
    BMAnswerViewController * answer = [[BMAnswerViewController alloc] init];
    answer.question = question;
    [self.navigationController pushViewController:answer animated:YES];
}
#pragma mark ======  DZNEmptyDataSetSource  ======
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tableView.mj_footer.hidden = YES;
    if (!appDelegate.netStatus) {
        
        return [UIImage imageNamed:@"无网状态"];
    }else{
        
        return [UIImage imageNamed:@"bg_wujilu"];
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
    NSString *buttonTitle = @"暂无数据";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f],NSForegroundColorAttributeName:[UIColor getUsualColorWithString:@"#929292"]
                                 };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}
#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // button clicked...
}
#pragma mark ======  lazy  ======
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F5F5"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMQuestionTableViewCell class] forCellReuseIdentifier:BMQuestionTableViewCellID];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _tableView;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selecbted object to the new view controller.
 }
 */

@end
