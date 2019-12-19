//
//  BMMineSetViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineSetViewController.h"

#import "BMMineSetTableViewCell.h"
#import "BMOpinionViewController.h"
#import "BMChangePhoneCheckViewController.h"
#import "BMAboutUsViewController.h"
@interface BMMineSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView * tableView;

@end

static NSString * const BMMineSetTableViewCellID = @"BMMineSetTableViewCellID";

@implementation BMMineSetViewController
#pragma mark ======  lazy  ======

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F5F5"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[BMMineSetTableViewCell class] forCellReuseIdentifier:BMMineSetTableViewCellID];
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        //        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _tableView;
}
-(void)loginOut{
    
    [BMPopView showWithContent:@"确定退出登录?" blockTapAction:^(NSInteger index) {
       
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
            MyLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, @"tag" , iAlias);
        } seq:0];
        [[BMUserInfoManager sharedManager] removeUser];
        [CommonMethod setupBaseUI];
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"设置";
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F5F5"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 136 * AutoSizeScaleY);
    }];
    
    UIButton * loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOutBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    [loginOutBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    ZViewBorderRadius(loginOutBtn, 5, 0, [UIColor getUsualColorWithString:@"#FF5445"]);
    [loginOutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOutBtn];
    [loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 20 * AutoSizeScaleY);
        make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
    }];
    
}

#pragma mark ******tableViewDelegate&Datasource******

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10* AutoSizeScaleY;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 10 * AutoSizeScaleY)];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    return line;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 54 * AutoSizeScaleY;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2;
    }else if (section == 1) {
        
        return 2;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@[@"消息推送设置",@"意见反馈"],@[@"更改手机号",@"关于我们"]];
    BMMineSetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMMineSetTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMMineSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMMineSetTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = titleArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0 ) {
        
        cell.arrowHide = YES;
    }else{
        
        cell.arrowHide = NO;
    }
    
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            NSString * cache = @"";
            NSUInteger tmpSize = [[SDImageCache sharedImageCache] getSize];
            if (tmpSize >= 1024*1024*1024) {
                cache = [NSString stringWithFormat:@"%.2fG",tmpSize /(1024.f*1024.f*1024.f)];
            }else if (tmpSize >= 1024*1024) {
                cache = [NSString stringWithFormat:@"%.2fMB",tmpSize /(1024.f*1024.f)];
            }else{
                cache = [NSString stringWithFormat:@"%.2fKB",tmpSize / 1024.f];
            }
            cell.cache = cache;
        }
    }else{
        
        cell.cache = @"";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
           
        }else if (indexPath.row == 1) {
            
            BMOpinionViewController * opinion = [[BMOpinionViewController alloc] init];
            [self.navigationController pushViewController:opinion animated:YES];
        }
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            BMChangePhoneCheckViewController * check = [[BMChangePhoneCheckViewController alloc] init];
            [self.navigationController pushViewController:check animated:YES];
            
        }else if (indexPath.row == 1) {
            
            BMAboutUsViewController * us = [[BMAboutUsViewController alloc] init];
            [self.navigationController pushViewController:us animated:YES];
        }
    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            NSString * cache = @"";
            NSUInteger tmpSize = [[SDImageCache sharedImageCache] getSize];
            if (tmpSize >= 1024*1024*1024) {
                cache = [NSString stringWithFormat:@"%.2fG",tmpSize /(1024.f*1024.f*1024.f)];
            }else if (tmpSize >= 1024*1024) {
                cache = [NSString stringWithFormat:@"%.2fMB",tmpSize /(1024.f*1024.f)];
            }else{
                
                cache = [NSString stringWithFormat:@"%.2fKB",tmpSize / 1024.f];
            }
            
//            [BMPopView showWithContent:[NSString stringWithFormat:@"确定清除%@缓存 ？",@""] blockTapAction:^(NSInteger index) {
//
//                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
//
//                    [self showHint:@"清除成功"];
//                    [self.tableView reloadData];
//                }];
//
//            }];
        }else if (indexPath.row == 1) {
            
            
        }
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
