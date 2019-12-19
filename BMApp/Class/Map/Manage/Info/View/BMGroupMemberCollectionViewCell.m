//
//  BMGroupMemberCollectionViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMGroupMemberCollectionViewCell.h"

@interface BMGroupMemberCollectionViewCell()



@end
@implementation BMGroupMemberCollectionViewCell


- (void)setUserModel:(BMClusterUserModel *)userModel{
    
    _userModel = userModel;
    [self.nameBtn setTitle:userModel.nickName forState:UIControlStateNormal];
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:userModel.picUrl] placeholderImage:[UIImage imageNamed:@"xinxi_touxiang"]];
    if ([userModel.isOwner isEqualToString:@"1"]) {
        
        [self.nameBtn setImage:[UIImage imageNamed:@"chenguan_icon_qunzhu"] forState:UIControlStateNormal];
        [self.nameBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:2];
    }else{
        
        [self.nameBtn setImage:nil forState:UIControlStateNormal];
        [self.nameBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:0];
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.nameBtn];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(48 * AutoSizeScaleX, 48 * AutoSizeScaleX));
        }];
        [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.contentView);
            make.width.equalTo(self.contentView);
            make.height.equalTo(15 * AutoSizeScaleX);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark ======  lazy  ======
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        ZViewBorderRadius(_iconImgView, 24 * AutoSizeScaleX, 0, [UIColor whiteColor]);
//        [_iconImgView setImage:[UIImage imageNamed:@"xinxi_touxiang"]];
    }
    return _iconImgView;
}
- (UIButton *)nameBtn{
    
    if (!_nameBtn) {
        
        _nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nameBtn.titleLabel.font =[UIFont systemFontOfSize:12.f];
        [_nameBtn setTitleColor:[UIColor getUsualColorWithString:@"#262B3A"] forState:UIControlStateNormal];
//        [_nameBtn setTitle:@"蓝可可可" forState:UIControlStateNormal];
    }
    return _nameBtn;
}



@end
