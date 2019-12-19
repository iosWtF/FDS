//
//  BMUrgentSetViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMUrgentSetViewController.h"

#import "BMUrgentSetTableViewCell.h"
#import "BMContentTableViewCell.h"
#import "BMDeviceModel.h"
#import "BMDeviceSettingModel.h"
@interface BMUrgentSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)NSMutableArray * sourceArr;
@property(nonatomic ,strong)BMDeviceSettingModel * settingModel;

@end

static NSString * const BMUrgentSetTableViewCellID = @"BMUrgentSetTableViewCellID";
static NSString * const BMContentTableViewCellID = @"BMContentTableViewCellID";
@implementation BMUrgentSetViewController

#pragma mark ======  lazy  ======

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[BMUrgentSetTableViewCell class] forCellReuseIdentifier:BMUrgentSetTableViewCellID];
        [_tableView registerClass:[BMContentTableViewCell class] forCellReuseIdentifier:BMContentTableViewCellID];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"紧急状态";
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
    [[BMHttpsMethod httpMethodManager] deviceSettingGetSettingToGetResult:^(id  _Nonnull data) {
        
        LHLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.settingModel = [BMDeviceSettingModel mj_objectWithKeyValues:data[@"data"]];
            [self.tableView reloadData];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
}

#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.sourceArr.count) {
        
        return [tableView fd_heightForCellWithIdentifier:BMContentTableViewCellID configuration:^(BMContentTableViewCell * cell) {
            
            cell.settingModel = self.settingModel;
        }];
    }
    
    return 53 * AutoSizeScaleY;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.sourceArr.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < self.sourceArr.count) {
        
        BMDeviceModel * model = self.sourceArr[indexPath.row];
        BMUrgentSetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMUrgentSetTableViewCellID forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[BMUrgentSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMUrgentSetTableViewCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        cell.settingModel = self.settingModel;
        __block BMUrgentSetTableViewCell * blockCell = cell;
        cell.switchBlock = ^(UISwitch * _Nonnull swich) {
          
            NSString * status;
            if ([model.emergency isEqualToString:@"1"]) {
                
                status = @"0";
                [[BMHttpsMethod httpMethodManager] deviceOutburstWithDeviceId:model.Id Status:status ToGetResult:^(id  _Nonnull data) {
                   
                    
                    if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                        
                        model.emergency = @"0";
                        
                    }else{
                        
                        [self showHint:data[@"errorMsg"]];
                    }
                    blockCell.model  = model;
                }];
            }else{
                status = @"1";
                [[BMHttpsMethod httpMethodManager] deviceOutburstWithDeviceId:model.Id Status:status ToGetResult:^(id  _Nonnull data) {
                    
                    if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                        
                        model.emergency = @"1";
                        
                    }else{
                        
                        [self showHint:data[@"errorMsg"]];
                    }
                    blockCell.model  = model;
                }];
                
            }
        };
        return cell;
    }else{
        BMContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMContentTableViewCellID forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[BMContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMContentTableViewCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.settingModel = self.settingModel;
        return cell;
        
    }
    
    
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
