//
//  BMMemberInfoViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMemberInfoViewController.h"

#import "BMMemberInfoTableViewCell.h"
#import "PYPhotoBrowseView.h"
@interface BMMemberInfoViewController ()<UITableViewDelegate,UITableViewDataSource,PYPhotoBrowseViewDelegate, PYPhotoBrowseViewDataSource>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)UserModel * user;
@property(nonatomic ,strong)UIImageView * iconImgView;
@property(nonatomic ,strong)NSMutableArray * titleArr;
@end

static NSString * const BMMemberInfoTableViewCellID = @"BMMemberInfoTableViewCellID";

@implementation BMMemberInfoViewController

#pragma mark ======  lazy  ======

- (NSMutableArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr  = [[NSMutableArray alloc] init];
    }
    return _titleArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled =NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMMemberInfoTableViewCell class] forCellReuseIdentifier:BMMemberInfoTableViewCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    self.customNavBar.backgroundColor = [UIColor clearColor];
    self.customNavBar.barBackgroundImage = nil;
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar setTitle:self.model.nickName];
   
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView setImage:[UIImage imageNamed:@"info"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(172 * AutoSizeScaleY);
    }];
    UIImageView * iconImgView = [[UIImageView alloc] init];
    ZViewBorderRadius(iconImgView, 84 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    iconImgView.clipsToBounds = YES;
    iconImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [iconImgView addGestureRecognizer:tap];
    [imageView addSubview:iconImgView];
    [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(imageView);
        make.bottom.equalTo(- 11 * AutoSizeScaleY);
        make.size.equalTo(CGSizeMake(84 * AutoSizeScaleX, 84 * AutoSizeScaleX));
    }];
    self.iconImgView = iconImgView;
    [self.view bringSubviewToFront:self.customNavBar];

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(imageView.mas_bottom).offset(10 * AutoSizeScaleY);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 140 * AutoSizeScaleY);
    }];
    [self configData];
    if (!self.isOwner) {
        
        return;
    }
    if ([self.model.userId isEqualToString:UserID]) {
        
        return;
    }
    
    
    NSArray * titleArr = @[@"移除本群",@"转让群主"];
    NSArray * colorArr = @[@"#4285F4",@"#B7B7B7"];
    for (int i = 0; i < 2; i ++) {
        
        UIButton * funcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [funcBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [funcBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
        funcBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [funcBtn setBackgroundColor:[UIColor getUsualColorWithString:colorArr[i]]];
        ZViewBorderRadius(funcBtn, 5, 0, [UIColor whiteColor]);
        [funcBtn addTarget:self action:@selector(funcClick:) forControlEvents:UIControlEventTouchUpInside];
        funcBtn.tag = 10 + i;
        [self.view addSubview:funcBtn];
        [funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(- SafeAreaBottomHeight - 35 * AutoSizeScaleY - 60 * AutoSizeScaleY * i);
            make.centerX.equalTo(self.view);
            make.size.equalTo(CGSizeMake(345 * AutoSizeScaleX, 45 * AutoSizeScaleY));
        }];
    }

}
- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] userGetUserDetailByIdWithId:self.model.userId ToGetResult:^(id  _Nonnull data) {
       
        LHLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.user = [UserModel mj_objectWithKeyValues:data[@"data"]];
            [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.user.picUrl]] placeholderImage:nil];
            self.titleArr = [NSMutableArray arrayWithObjects:self.user.nickName,self.user.genderStr,self.user.descriptionn, nil];
            [self.tableView reloadData];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
    
}

- (void)tap{
    
    PYPhotoBrowseView *browseView = [[PYPhotoBrowseView alloc] init];
    browseView.imagesURL = @[self.user.picUrl];
    browseView.frameFormWindow = self.iconImgView.frame;
    browseView.frameToWindow = self.iconImgView.frame;
    [browseView setCurrentIndex:0];
    // 2.设置数据源和代理并实现数据源和代理方法
    browseView.dataSource = self;
    browseView.delegate = self;
    // 3.显示（浏览）
    [browseView show];
}

#pragma mark ======  点击  ======
- (void)funcClick:(UIButton *)btn{
    
    if (btn.tag == 10) {
        
        //移除本群
        
        [BMPopView showWithContent:@"是否确定移除当前成员?" blockTapAction:^(NSInteger index) {
            
            [[BMHttpsMethod httpMethodManager] clusterUserRemoveWithClusterId:self.model.clusterId UserId:self.model.userId ToGetResult:^(id  _Nonnull data) {
                
                if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                    
                    [Z_NotificationCenter postNotificationName:@"changeGroupInfo" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    
                    [self showHint:data[@"errorMsg"]];
                }
            }];
            
        }];

    }else if (btn.tag == 11){
        
        //转让群主
        
        [BMPopView showWithContent:@"是否确定将群组转让给当前成员?" blockTapAction:^(NSInteger index) {
           
            [[BMHttpsMethod httpMethodManager] clusterTransferWithUserId:self.model.userId ClusterId:self.model.clusterId ToGetResult:^(id  _Nonnull data) {
                
                if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                    
                    [Z_NotificationCenter postNotificationName:@"changeGroupInfo" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    
                    [self showHint:data[@"errorMsg"]];
                }
            }];
        }];
    }
}

#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [tableView fd_heightForCellWithIdentifier:BMMemberInfoTableViewCellID configuration:^(BMMemberInfoTableViewCell * cell) {
        
        if (self.user) {
            
            NSString * title = self.titleArr[indexPath.row];
            if (!title || title.length == 0) {
                
                title = @" ";
            }
            cell.content = title;
        }
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@"昵称",@"性别",@"简介"];
    BMMemberInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMMemberInfoTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMMemberInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMMemberInfoTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = titleArr[indexPath.row];
    
    if (self.user) {
        
        NSString * title = self.titleArr[indexPath.row];
        if (!title || title.length == 0) {
            
            title = @"无";
        }
        cell.content = title;
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
