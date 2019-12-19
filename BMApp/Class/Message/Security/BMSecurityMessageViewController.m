//
//  BMSecurityMessageViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMSecurityMessageViewController.h"

#import "BMSecurityMessageTableViewCell.h"
#import "BMSecurityDetailViewController.h"
#import "BMSecurityMsgModel.h"
@interface BMSecurityMessageViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)UIView * headerView;
@property(nonatomic ,strong)NSMutableArray * sourceArr;

@property(nonatomic ,assign)NSUInteger  page;

@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置

@end
static NSString * const BMSecurityMessageTableViewCellID = @"BMSecurityMessageTableViewCellID";

@implementation BMSecurityMessageViewController

- (NSMutableArray *)sourceArr{
    
    if (!_sourceArr) {
        
        _sourceArr = [NSMutableArray array];
    }
    return _sourceArr;
}

- (UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 106 * AutoSizeScaleY)];
        _headerView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(15 * AutoSizeScaleX, 0, Z_SCREEN_WIDTH - 30 * AutoSizeScaleX, 106 * AutoSizeScaleY)];
        contentView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:contentView];
        UILabel * titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 12 * AutoSizeScaleY, Z_SCREEN_WIDTH - 30 * AutoSizeScaleX, 16 * AutoSizeScaleY)];
        titleLb.text = @"欢迎使用";
        titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        titleLb.font = [UIFont systemFontOfSize:16.f];
        titleLb.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:titleLb];
        UILabel * tipLb1 = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleLb.frame) + 15 * AutoSizeScaleY, Z_SCREEN_WIDTH - 30 * AutoSizeScaleX, 12 * AutoSizeScaleY)];
        tipLb1.text = @"消息中心主要是接受家人的求助信息和地理围栏的消息提醒";
        tipLb1.textColor = [UIColor getUsualColorWithString:@"#333333"];
        tipLb1.font = [UIFont systemFontOfSize:12.f];
        tipLb1.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:tipLb1];
        UILabel * tipLb2 = [[UILabel alloc] init];
        tipLb2.text = @"您可以通过向左滑动删除消息";
        tipLb2.textColor = [UIColor getUsualColorWithString:@"#666666"];
        tipLb2.font = [UIFont systemFontOfSize:12.f];
        tipLb2.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:tipLb2];
        [tipLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(contentView);
            make.top.equalTo(tipLb1.mas_bottom).offset(19 * AutoSizeScaleY);
            make.height.equalTo(12 * AutoSizeScaleY);
        }];
        UIImageView * imgView = [[UIImageView alloc] init];
        [imgView setImage:[UIImage imageNamed:@"xiaoxi_icon_shoushi"]];
        [contentView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(tipLb2);
            make.right.equalTo(tipLb2.mas_left).offset(- 12 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(32 * AutoSizeScaleX, 23 * AutoSizeScaleX));
        }];
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMSecurityMessageTableViewCell class] forCellReuseIdentifier:BMSecurityMessageTableViewCellID];
        _tableView.tableHeaderView = self.headerView;
        //侧滑删除设置
        _tableView.allowsMultipleSelection = NO;
        _tableView.allowsSelectionDuringEditing = NO;
        _tableView.allowsMultipleSelectionDuringEditing = NO;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [Z_NotificationCenter addObserver:self selector:@selector(refreshData) name:@"raiderChange" object:nil];
    [Z_NotificationCenter addObserver:self selector:@selector(clear) name:@"clearSecMsg" object:nil];
    
    [Z_NotificationCenter addObserver:self selector:@selector(paySuccess) name:@"paySuccess" object:nil];
    [Z_NotificationCenter addObserver:self selector:@selector(payFaild) name:@"payFaild" object:nil];
    [self refreshData];
}


- (void)dealloc{
    
    [Z_NotificationCenter removeObserver:self];
}

#pragma mark 刷新加载
//刷新
- (void)refreshData{
    
    self.page = 1;
    
//    if ([self.status isEqualToString:@"0"]) {
//
//        self.status = @"";
//    }
//
    [[BMHttpsMethod httpMethodManager] messagePageWithPageNow:[NSString stringWithFormat:@"%ld",self.page] Size:@"10" userid:UserID ToGetResult:^(id  _Nonnull data) {
        
        LHLog(@"%@",data);
        [self.tableView .mj_header endRefreshing];
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.sourceArr = [BMSecurityMsgModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"records"]];
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
    [[BMHttpsMethod httpMethodManager] messagePageWithPageNow:[NSString stringWithFormat:@"%ld",self.page] Size:@"10" userid:@"1" ToGetResult:^(id  _Nonnull data) {

        [self.tableView.mj_footer endRefreshing];

        if ([data[@"errorCode"] isEqualToString:@"0000"]) {

            //请求成功
            NSMutableArray * tempArr = [NSMutableArray arrayWithArray:data[@"data"][@"records"]];
            [self.sourceArr addObjectsFromArray:[BMSecurityMsgModel mj_objectArrayWithKeyValuesArray:tempArr]];
            [self.tableView reloadData];
            [CommonMethod LoadDataSetMj_footerHidden:self.sourceArr Page:self.page ScrollView:self.tableView];
        }
        
    }];
}
#pragma mark ======  删除消息  ======
- (void)deleteMessage:(UIButton *)btn{
    
    MyLog(@"%@",self.editingIndexPath);
    BMSecurityMsgModel * model = self.sourceArr[self.editingIndexPath.row];
    self.editingIndexPath = nil;
    [[BMHttpsMethod httpMethodManager] messageUserDeleteWithId:model.Id UserId:UserID ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self showHint:@"删除成功"];
            [self refreshData];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.tableView reloadData];
    }];
}
- (void)clear{
    
    if (self.sourceArr.count == 0) {
        
        return;
    }
    [[BMHttpsMethod httpMethodManager] messageUserDeleteWithId:@"" UserId:UserID ToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self showHint:@"删除成功"];
            [self refreshData];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.tableView reloadData];
    }];
}


#pragma mark - viewDidLayoutSubviews
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.editingIndexPath){
        [self configSwipeButtons];
    }
}
#pragma mark - configSwipeButtons
- (void)configSwipeButtons{
    // 获取选项按钮的reference
    if (@available(iOS 11.0, *)){
        
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.tableView.subviews)
        {
            NSLog(@"%@-----%zd",subview,subview.subviews.count);
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] >= 1)
            {
                // 和iOS 10的按钮顺序相反
                UIButton *deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }
    else{
        // iOS 8-10层级 (Xcode 8编译): UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        BMSecurityMessageTableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews){
            //NSLog(@"subview%@-----%zd",subview,subview.subviews.count);
            
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 1)
            {
                UIButton *deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }
}

- (void)configDeleteButton:(UIButton*)deleteButton{
    if (deleteButton) {
//        [deleteButton setImage:[UIImage imageNamed:@"message_icon_shanchu"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:[UIColor getUsualColorWithString:@"#FF4949"]];
        [deleteButton setTitle:@"删\n除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [deleteButton addTarget:self action:@selector(deleteMessage:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 侧滑删除
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    self.editingIndexPath = nil;
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //title不设为nil 而是空字符串 理由为啥 ？   自己实践 跑到ios11以下的机器上就知道为啥了
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"        " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
    }];
    return @[deleteAction];
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMSecurityMsgModel * model = self.sourceArr[indexPath.row];
    
    return [tableView fd_heightForCellWithIdentifier:BMSecurityMessageTableViewCellID configuration:^(BMSecurityMessageTableViewCell * cell) {
        
        cell.model = model;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMSecurityMsgModel * model = self.sourceArr[indexPath.row];
    BMSecurityMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMSecurityMessageTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMSecurityMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMSecurityMessageTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BMSecurityMsgModel * model = self.sourceArr[indexPath.row];
    BMSecurityDetailViewController * detail = [[BMSecurityDetailViewController alloc] init];
    detail.model = model;
    [self.naviController pushViewController:detail animated:YES];
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
    [self refreshData];
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)listDidDisappear {}



@end
