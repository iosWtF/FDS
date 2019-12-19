//
//  BMAddPeriodViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMAddPeriodViewController.h"

#import "BMAddPeriodTableViewCell.h"
#import "BMBottomPopView.h"


@interface BMAddPeriodViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView * tableView;
@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置

@property(nonatomic ,copy)NSString * starTime;
@property(nonatomic ,copy)NSString * endTime;
@property(nonatomic ,copy)NSString * period;
@end

static NSString * const BMAddPeriodTableViewCellID = @"BMAddPeriodTableViewCellID";

@implementation BMAddPeriodViewController

#pragma mark ======  lazy  ======

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMAddPeriodTableViewCell class] forCellReuseIdentifier:BMAddPeriodTableViewCellID];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"添加时间段";
    self.starTime = @"请选择";
    self.endTime = @"请选择";
    self.period = @"请选择";
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
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
    UIButton * keepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [keepBtn setTitle:@"保存" forState:UIControlStateNormal];
    [keepBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    keepBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [keepBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    ZViewBorderRadius(keepBtn, 5, 0, [UIColor whiteColor]);
    [keepBtn addTarget:self action:@selector(keep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keepBtn];
    [keepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- 25 * AutoSizeScaleY - SafeAreaBottomHeight);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
    }];
    
    //    [self configData];
}
#pragma mark ======  保存  ======
- (void)keep{
    
    if ([self.starTime isEqualToString:@"请选择"] || self.starTime.length == 0) {
        
        [self showHint:@"请选择开始时间"];
        return;
    }
    if ([self.endTime isEqualToString:@"请选择"] || self.endTime.length == 0) {
        
        [self showHint:@"请选择结束时间"];
        return;
    }
    if ([self.period isEqualToString:@"请选择"] || self.period.length == 0) {
        
        [self showHint:@"请选择周期"];
        return;
    }
    
    [[BMHttpsMethod httpMethodManager] retentionSaveWithDeviceId:self.device.Id StartTime:[NSString stringWithFormat:@"%@:00",self.starTime] EndTime:[NSString stringWithFormat:@"%@:00",self.endTime] Period:self.period ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self showHint:@"添加成功"];
            [Z_NotificationCenter postNotificationName:@"retentionChange" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}


#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53 * AutoSizeScaleY;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@"开始时间",@"结束时间",@"周期"];
    NSArray * contentArr = @[self.starTime,self.endTime,[CommonMethod MineWeekDateToHans:self.period]];
    BMAddPeriodTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMAddPeriodTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMAddPeriodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMAddPeriodTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = titleArr[indexPath.row];
    cell.content = contentArr[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        [BMBottomPopView showPeriodDateWithTitle:@"请选择开始时间" BlockTapAction:^(NSString * _Nonnull date) {

            MyLog(@"%@",date);
            self.starTime = date;
            [self.tableView reloadData];
        }];
       
    }else if (indexPath.row == 1){

        [BMBottomPopView showPeriodDateWithTitle:@"请选择结束时间" BlockTapAction:^(NSString * _Nonnull date) {

            MyLog(@"%@",date);
            self.endTime = date;
            [self.tableView reloadData];
        }];
    }else if (indexPath.row == 2){

        [BMBottomPopView showWeekDateBlockTapAction:^(NSString * _Nonnull date) {

            MyLog(@"%@",date);
            if (date.length == 0) {
                
                return;
            }
            self.period = date;
            [self.tableView reloadData];
        }];
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
