//
//  BMPeriodViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMPeriodViewController.h"

#import "BMPeriodTableViewCell.h"
#import "BMAddPeriodViewController.h"

#import "BMRetentionModel.h"

@interface BMPeriodViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)UIView * headerView;
@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置

@property(nonatomic ,strong)NSMutableArray * sourceArr;
@end

static NSString * const BMPeriodTableViewCellID = @"BMPeriodTableViewCellID";

@implementation BMPeriodViewController

#pragma mark ======  lazy  ======

- (UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 120 * AutoSizeScaleY)];
        UILabel * titleLb = [[UILabel alloc] init];
        titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        titleLb.font = [UIFont systemFontOfSize:13.f];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.numberOfLines = 0;
        titleLb.text = @"根据设备的动态感应，设置异常通知时间段，设置时间段内设备出现异常停留，会第一时间通知您";
        [_headerView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(23 * AutoSizeScaleY);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.width.equalTo(Z_SCREEN_WIDTH - 30 * AutoSizeScaleX);
        }];
        UILabel * tipLb = [[UILabel alloc] init];
        tipLb.textColor = [UIColor getUsualColorWithString:@"#D84040"];
        tipLb.font = [UIFont systemFontOfSize:13.f];
        tipLb.textAlignment = NSTextAlignmentLeft;
        tipLb.text = @"(最多添加两个时间段，且时长不超过1个小时)";
        [_headerView addSubview:tipLb];
        [tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(titleLb.mas_bottom).offset(20 * AutoSizeScaleY);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.width.equalTo(Z_SCREEN_WIDTH - 30 * AutoSizeScaleX);
        }];
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        [_headerView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.headerView);
            make.left.right.equalTo(self.headerView);
            make.height.equalTo(10 * AutoSizeScaleY);
        }];
        
        
    }
    return _headerView;
}

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
        
        [_tableView registerClass:[BMPeriodTableViewCell class] forCellReuseIdentifier:BMPeriodTableViewCellID];
        _tableView.tableHeaderView = self.headerView;
        //侧滑删除设置
        _tableView.allowsMultipleSelection = NO;
        _tableView.allowsSelectionDuringEditing = NO;
        _tableView.allowsMultipleSelectionDuringEditing = NO;
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
    self.customNavBar.title = self.device.name;
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    self.sourceArr = [[NSMutableArray alloc] init];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight + 10 * AutoSizeScaleY);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 70 * AutoSizeScaleY);
    }];
    [self configData];
    if (!self.isOwner) {
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {

            make.bottom.equalTo(- SafeAreaBottomHeight );
        }];
        
        return;
    }
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [addBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    ZViewBorderRadius(addBtn, 5, 0, [UIColor whiteColor]);
    [addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- 25 * AutoSizeScaleY - SafeAreaBottomHeight);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
    }];
    
    
}
#pragma mark ======  添加  ======
- (void)add{
    
    BMAddPeriodViewController * add = [[BMAddPeriodViewController alloc] init];
    add.device = self.device;
    [self.navigationController pushViewController:add animated:YES];
}

- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] retentionRetentionListWithDeviceId:self.device.Id ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.sourceArr = [BMRetentionModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark ======  删除异常停留  ======
- (void)delete:(UIButton *)btn{
    
    BMRetentionModel * retention = self.sourceArr[self.editingIndexPath.row];
    self.editingIndexPath = nil;
    [[BMHttpsMethod httpMethodManager] retentionDeleteWithId:retention.Id ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [Z_NotificationCenter postNotificationName:@"retentionChange" object:nil];
            [self showHint:@"删除成功"];
            
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
        BMPeriodTableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
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
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 侧滑删除
//指定行是否可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOwner) {
        
        return YES;
    }
    return NO;
}

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

#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53 * AutoSizeScaleY;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArr.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMRetentionModel * retention = self.sourceArr[indexPath.row];
    BMPeriodTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMPeriodTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMPeriodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMPeriodTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.retention = retention;
    cell.device = self.device;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    NSString *buttonTitle = @"未设置异常时间段";
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
