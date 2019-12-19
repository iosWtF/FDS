//
//  BMMineGroupInfoHeaderView.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineGroupInfoHeaderView.h"

#import "BMGroupMemberCollectionViewCell.h"
#import "BMClusterUserModel.h"
@interface BMMineGroupInfoHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UICollectionView *collectionView;
@property(nonatomic ,strong)UIButton *checkAllBtn;
@property(nonatomic ,strong)UIView *line;

@end
@implementation BMMineGroupInfoHeaderView

- (void)checkAll{
    
    self.checkAllBtn.selected = YES;
    
    NSInteger row = (self.sourceArr.count + 1) / 5 ;
    if ((self.sourceArr.count + 1) % 5 != 0) {
        
        row += 1;
    }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(85 * AutoSizeScaleY * row);
    }];
    [self.checkAllBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(0);
    }];
    self.checkAllBtn.hidden = YES;
    CGFloat height = 70 * AutoSizeScaleY + 85 * AutoSizeScaleY * row;
    self.frame = CGRectMake(0, 0, Z_SCREEN_WIDTH, height);
    
    [self.collectionView reloadData];
    
    if (self.checkAllBlock) {
        
        self.checkAllBlock();
    }
    
}

- (void)setSourceArr:(NSMutableArray *)sourceArr{
    
    _sourceArr = sourceArr;
    NSInteger row = (self.sourceArr.count + 1) / 5 ;
    if ((self.sourceArr.count + 1) % 5 != 0) {
        
        row += 1;
    }
    if (row == 2 || row > 2) {
        
        row = 2;
    }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(85 * AutoSizeScaleY * row);
    }];
    if ((self.sourceArr.count + 1) < 10 || (self.sourceArr.count + 1) == 10) {
        
        [self.checkAllBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(0);
        }];
        self.checkAllBtn.hidden = YES;
        CGFloat height = 70 * AutoSizeScaleY + 85 * AutoSizeScaleY * row;
        self.frame = CGRectMake(0, 0, Z_SCREEN_WIDTH, height);
    }else{
        
        CGFloat height = 110 * AutoSizeScaleY + 85 * AutoSizeScaleY * row;
        self.frame = CGRectMake(0, 0, Z_SCREEN_WIDTH, height);
    }
    
    [self.collectionView reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor  getUsualColorWithString:@"#FFFFFF"];
        
        [self addSubview:self.titleLb];
        [self addSubview:self.collectionView];
        [self addSubview:self.checkAllBtn];
        [self addSubview:self.line];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(21 * AutoSizeScaleY);
            make.left.equalTo(16 * AutoSizeScaleX);
            make.height.equalTo(17 * AutoSizeScaleY);
        }];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.titleLb.mas_bottom).offset(20 * AutoSizeScaleY);
            make.left.right.equalTo(self);
            make.height.equalTo(0 * AutoSizeScaleY);
        }];
        [self.checkAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.collectionView.mas_bottom);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(40 * AutoSizeScaleY);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.checkAllBtn.mas_bottom);
            make.left.equalTo(self);
            make.height.equalTo(10 * AutoSizeScaleY);
            make.width.equalTo(Z_SCREEN_WIDTH);
        }];
    }
    return self;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.text = @"群成员";
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#050A1C"];
        _titleLb.font = [UIFont systemFontOfSize:17.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        
    }
    return _titleLb;
}
- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    }
    return _line;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(Z_SCREEN_WIDTH / 5, 70 * AutoSizeScaleY);
        flowLayout.minimumLineSpacing = 15 * AutoSizeScaleY;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[BMGroupMemberCollectionViewCell class] forCellWithReuseIdentifier:@"BMGroupMemberCollectionViewCellID"];
        
    }
    return _collectionView;
}
- (UIButton *)checkAllBtn{
    
    if (!_checkAllBtn) {
        
        _checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkAllBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
        [_checkAllBtn setTitle:@"查看全部成员" forState:UIControlStateNormal];
        [_checkAllBtn setTitleColor:[UIColor getUsualColorWithString:@"#999999"] forState:UIControlStateNormal];
        _checkAllBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_checkAllBtn setImage:[UIImage imageNamed:@"qunzhu_icon_xia"] forState:UIControlStateNormal];
        [_checkAllBtn setImagePositionWithType:SSImagePositionTypeRight spacing:3];
        [_checkAllBtn addTarget:self action:@selector(checkAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkAllBtn;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.typeBlock) {
        
        self.typeBlock(indexPath.row);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.sourceArr.count + 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // 1个区
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BMGroupMemberCollectionViewCell *cell = (BMGroupMemberCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BMGroupMemberCollectionViewCellID" forIndexPath:indexPath];
    
    if ((self.sourceArr.count + 1) > 10) {
        
        if (self.checkAllBtn.selected) {
            
            if (indexPath.row == self.sourceArr.count) {
                
                [cell.iconImgView setImage:[UIImage imageNamed:@"qunzhu_btn_jia"]];
                [cell.nameBtn setTitle:@"邀请" forState:UIControlStateNormal];
                [cell.nameBtn setImage:nil forState:UIControlStateNormal];
                [cell.nameBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:0];
            }else{
                
                BMClusterUserModel * user = self.sourceArr[indexPath.row];
                cell.userModel = user;
                
            }
            
            
        }else{
            
            if (indexPath.row == 9) {
                
                [cell.iconImgView setImage:[UIImage imageNamed:@"qunzhu_btn_jia"]];
                [cell.nameBtn setTitle:@"邀请" forState:UIControlStateNormal];
                [cell.nameBtn setImage:nil forState:UIControlStateNormal];
                [cell.nameBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:0];
            }else{
                
                BMClusterUserModel * user = self.sourceArr[indexPath.row];
                cell.userModel = user;
            }
        }
        
        
        
    }else{
        
        if (indexPath.row == self.sourceArr.count) {
            
            [cell.iconImgView setImage:[UIImage imageNamed:@"qunzhu_btn_jia"]];
            [cell.nameBtn setTitle:@"邀请" forState:UIControlStateNormal];
            [cell.nameBtn setImage:nil forState:UIControlStateNormal];
            [cell.nameBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:0];
        }else{
            
            BMClusterUserModel * user = self.sourceArr[indexPath.row];
            cell.userModel = user;
            
        }
    }
   
    return cell;
}

@end

