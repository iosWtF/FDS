//
//  BMDeviceInfoViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMDeviceInfoViewController.h"

#import "BMDeviceInfoTableViewCell.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"
@interface BMDeviceInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)BMDeviceModel * infoModel;
@end

static NSString * const BMDeviceInfoTableViewCellID = @"BMDeviceInfoTableViewCellID";

@implementation BMDeviceInfoViewController
#pragma mark ======  lazy  ======

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMDeviceInfoTableViewCell class] forCellReuseIdentifier:BMDeviceInfoTableViewCellID];
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        //        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"设备信息";
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
        make.bottom.equalTo(- SafeAreaBottomHeight );
    }];
    
    [self configData];
}
- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] deviceGetWithId:self.device.Id ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.infoModel = [BMDeviceModel mj_objectWithKeyValues:data[@"data"]];
            [self.tableView reloadData];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];

}


#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 55 * AutoSizeScaleY;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@"设备头像",@"设备名称",@"儿童生日",@"儿童学习阶段",@"设备校检码"];
    NSArray * imgArr = @[@"xinxi_icon_touxiag",@"tianjia_icon_shebei",@"tianjia_icon_shengri",@"xinxi_icon_xuexi",@"xinxi_icon_shouji"];
    BMDeviceInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMDeviceInfoTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMDeviceInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMDeviceInfoTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = titleArr[indexPath.row];
    cell.img = imgArr[indexPath.row];
    cell.iconImgView.hidden = YES;
    if (indexPath.row == 0) {
        
        cell.iconImgView.hidden = NO;
        if (self.infoModel) {
            
            [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.infoModel.picUrl]] placeholderImage:nil];
        }
    }
    if (self.infoModel) {
        
        NSArray * arrayData = @[@"学前班",@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级",@"初中",@"高中",@"其他"];
        NSInteger  i = [self.infoModel.childrenType integerValue];
        NSArray * contentArr = @[@"",self.infoModel.name,self.infoModel.birthday,arrayData[i],self.infoModel.imei];
        cell.contentTf.text = contentArr[indexPath.row];
    }
    
    
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
