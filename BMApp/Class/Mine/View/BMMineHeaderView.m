//
//  BMMineHeaderView.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineHeaderView.h"

@interface BMMineHeaderView()

@property(nonatomic ,strong)UIImageView *bgImgView;
@property(nonatomic ,strong)UIImageView *editBgImgView;
@property(nonatomic ,strong)UIImageView *arrowImgView;
@property(nonatomic ,strong)UIButton *editBtn;
@property(nonatomic ,strong)UIImageView *iconImgView;
@property(nonatomic ,strong)UILabel *nameLb;
@property(nonatomic ,strong)UILabel *infoLb;

@end
@implementation BMMineHeaderView

- (void)setUser:(UserModel *)user{
    
    _user = user;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",user.picUrl]] placeholderImage:nil];
    self.nameLb.text = user.nickName;
    self.infoLb.text = user.descriptionn;
}

- (void)func:(UIButton *)btn{
    
    if (self.funcBlock) {
        
        self.funcBlock(btn.tag - 10);
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.bgImgView];
        [self addSubview:self.editBgImgView];
        [self addSubview:self.editBtn];
        [self addSubview:self.arrowImgView];
        [self addSubview:self.iconImgView];
        [self addSubview:self.nameLb];
        [self addSubview:self.infoLb];
        
        [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(168 * AutoSizeScaleY + SafeAreaIphoneXTopHeight);
            
        }];
        [self.editBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(SafeAreaIphoneXTopHeight + 58 * AutoSizeScaleY);
            make.right.equalTo(self);
            make.size.equalTo(CGSizeMake(71 * AutoSizeScaleX, 23 * AutoSizeScaleX));
        }];
        [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.editBgImgView);
            make.left.equalTo(self.editBgImgView);
            make.size.equalTo(CGSizeMake(60 * AutoSizeScaleX, 23 * AutoSizeScaleX));
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.editBgImgView);
            make.right.equalTo(self.editBgImgView).offset(- 7 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(6 * AutoSizeScaleX, 10 * AutoSizeScaleX));
        }];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(73 * AutoSizeScaleY + SafeAreaIphoneXTopHeight);
            make.left.equalTo(14 * AutoSizeScaleX);
            make.width.equalTo(70 * AutoSizeScaleX);
            make.height.equalTo(70 * AutoSizeScaleX);
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.iconImgView).offset(11 * AutoSizeScaleY);
            make.left.equalTo(self.iconImgView.mas_right).offset(16 * AutoSizeScaleX);
            make.height.equalTo(16 * AutoSizeScaleY);
        }];
        [self.infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.iconImgView).offset(- 14 * AutoSizeScaleY);
            make.left.height.equalTo(self.nameLb);
            make.right.equalTo(- 20 * AutoSizeScaleX);
        }];
        
    }
    return self;
}

#pragma mark ======  lazy  ======
- (UIImageView *)bgImgView{
    
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_bg"]];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImgView.clipsToBounds = YES;
        
    }
    return _bgImgView;
}
- (UIImageView *)editBgImgView{
    
    if (!_editBgImgView) {
        
        _editBgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_bianji_bg"]];
        _editBgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _editBgImgView.clipsToBounds = YES;
        
    }
    return _editBgImgView;
}
- (UIButton *)editBtn{
    
    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"my_icon_biaji"] forState:UIControlStateNormal];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _editBtn.titleLabel.textColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_editBtn addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
        _editBtn.tag = 12;
        [_editBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:4];
    }
    return _editBtn;
}
- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_icon_sanjiao"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImgView.clipsToBounds = YES;
    }
    return _arrowImgView;
}

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_btn_wechat"]];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        
        //        [_iconImgView setBackgroundColor:[UIColor blueColor]];
        ZViewBorderRadius(_iconImgView, 70 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _iconImgView;
}


- (UILabel *)nameLb{
    
    if (!_nameLb) {
        
        _nameLb = [[UILabel alloc] init];
        _nameLb.text = @"";
        _nameLb.textColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.font = [UIFont systemFontOfSize:17.f];
    }
    return _nameLb;
}
- (UILabel *)infoLb{
    
    if (!_infoLb) {
        
        _infoLb = [[UILabel alloc] init];
        _infoLb.text = @"";
        _infoLb.textColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _infoLb.font = [UIFont systemFontOfSize:14.f];
        _infoLb.textAlignment = NSTextAlignmentLeft;
        
    }
    return _infoLb;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
