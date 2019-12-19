//
//  BMSecurityDetailInfoView.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMSecurityDetailInfoView.h"

@interface BMSecurityDetailInfoView()

@property(nonatomic ,strong)UIImageView * iconImgView;
@property(nonatomic ,strong)UILabel * nameLb;
@property(nonatomic ,strong)UILabel * timeLb;
@property(nonatomic ,strong)UILabel * stateLb;
@property(nonatomic ,strong)UILabel * tipLb;
@property(nonatomic ,strong)UILabel * addressLb;
@property(nonatomic ,strong)UIImageView * addressImgView;
@property(nonatomic ,strong)UILabel * addressDetailLb;
@property(nonatomic ,strong)UIButton * checkBtn;
@end

@implementation BMSecurityDetailInfoView

- (void)check{
    
    if (self.checkBlock) {
        
        self.checkBlock();
    }
}

- (void)setModel:(BMSecurityMsgDetailModel *)model{
    
    _model = model;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.devicePic]] placeholderImage:nil];
    self.nameLb.text = model.name;
    NSString *ampm = @"";
//    if ([model.amPm isEqualToString:@"0"]) {
//
//        ampm = @"上午";
//    }else{
//
//        ampm = @"下午";
//    }
    self.timeLb.text = [NSString stringWithFormat:@"%@%@",ampm,[CommonMethod configDateWithDate:model.createTime]];
    self.tipLb.hidden = YES;
    self.addressDetailLb.text = model.position;
    if ([model.type isEqualToString:@"1"]) {
        
        self.stateLb.textColor = [UIColor getUsualColorWithString:@"#C92B2B"];
        self.stateLb.text = @"请求帮助";
        self.tipLb.hidden = NO;
    }else if ([model.type isEqualToString:@"3"]) {
        
        self.stateLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        self.stateLb.text = @"进入电子围栏";
    }else if ([model.type isEqualToString:@"4"]) {
        
        self.stateLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        self.stateLb.text = @"离开电子围栏";
        
    }else if ([model.type isEqualToString:@"2"]) {
        
        self.stateLb.textColor = [UIColor getUsualColorWithString:@"#C92B2B"];
        self.stateLb.text = @"出现异常停留";
    }
    if (model.fenceName.length == 0) {
        
        [self.addressLb mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(0);
        }];

    }else{
        
        [self.addressLb mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo([UILabel getWidthWithTitle:model.fenceName font:[UIFont systemFontOfSize:10.f]] + 3);
        }];
    }
    self.addressLb.text = model.fenceName;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.iconImgView];
        [self addSubview:self.nameLb];
        [self addSubview:self.timeLb];
        [self addSubview:self.checkBtn];
        [self addSubview:self.stateLb];
        [self addSubview:self.tipLb];
        [self addSubview:self.addressLb];
        [self addSubview:self.addressImgView];
        [self addSubview:self.addressDetailLb];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(15 * AutoSizeScaleY);
            make.left.equalTo(20 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(43 * AutoSizeScaleX, 43 * AutoSizeScaleX));
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(18 * AutoSizeScaleY);
            make.left.equalTo(self.iconImgView.mas_right).offset(12 * AutoSizeScaleX);
            make.height.equalTo(18 * AutoSizeScaleY);
        }];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.nameLb.mas_right).offset(10 * AutoSizeScaleX);
            make.centerY.equalTo(self.nameLb);
            make.height.equalTo(11 * AutoSizeScaleY);
        }];
        [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.timeLb);
            make.right.equalTo(- 12 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(90 * AutoSizeScaleX, 12 * AutoSizeScaleY));
        }];
        [self.stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.nameLb);
            make.top.equalTo(self.nameLb.mas_bottom).offset(10 * AutoSizeScaleY);
            make.height.equalTo(12 * AutoSizeScaleY);
        }];
        [self.addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.stateLb);
            make.left.equalTo(self.stateLb.mas_right).offset(7 * AutoSizeScaleX);
            make.height.equalTo(10 * AutoSizeScaleY);
            make.width.equalTo(0);
        }];
        [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.addressLb.mas_right).offset(5 * AutoSizeScaleX);
            make.centerY.equalTo(self.stateLb);
            make.height.equalTo(12 * AutoSizeScaleY);
        }];
        
        [self.addressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.stateLb.mas_bottom).offset(15 * AutoSizeScaleY);
            make.left.equalTo(self.iconImgView);
            make.size.equalTo(CGSizeMake(10 * AutoSizeScaleX, 12 * AutoSizeScaleX));
        }];
        [self.addressDetailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.addressImgView);
            make.left.equalTo(self.addressImgView.mas_right).offset(4 * AutoSizeScaleX);
            make.right.equalTo(- 10 * AutoSizeScaleX);
            make.bottom.equalTo(- 10 * AutoSizeScaleY);
        }];
    }
    return self;
}


- (UILabel *)stateLb{
    
    if (!_stateLb) {
        
        _stateLb = [[UILabel alloc] init];
        _stateLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        _stateLb.font = [UIFont systemFontOfSize:12.f];
        _stateLb.textAlignment = NSTextAlignmentLeft;
        _stateLb.text = @"离开";
    }
    return _stateLb;
}
- (UILabel *)tipLb{
    
    if (!_tipLb) {
        
        _tipLb = [[UILabel alloc] init];
        _tipLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _tipLb.font = [UIFont systemFontOfSize:12.f];
        _tipLb.textAlignment = NSTextAlignmentLeft;
        _tipLb.text = @"上次定位信息";
    }
    return _tipLb;
}

- (UILabel *)timeLb{
    
    if (!_timeLb) {
        
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _timeLb.font = [UIFont systemFontOfSize:12.f];
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.text = @"下午6:14";
    }
    return _timeLb;
}
- (UIButton *)checkBtn{
    
    if (!_checkBtn) {
        
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setImage:[UIImage imageNamed:@"mingxi_icon_sanjiao"] forState:UIControlStateNormal];
        [_checkBtn setTitle:@"查看最近足迹" forState:UIControlStateNormal];
        [_checkBtn setTitleColor:[UIColor getUsualColorWithString:@"#999999"] forState:UIControlStateNormal];
        _checkBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_checkBtn setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        [_checkBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}


- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        ZViewBorderRadius(_iconImgView, 43 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _iconImgView;
}
- (UILabel *)nameLb{
    
    if (!_nameLb) {
        
        _nameLb = [[UILabel alloc] init];
        _nameLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _nameLb.font = [UIFont systemFontOfSize:19.f];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.text = @"小芸芸";
    }
    return _nameLb;
}
- (UILabel *)addressLb{
    
    if (!_addressLb) {
        
        _addressLb = [[UILabel alloc] init];
        _addressLb.textColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _addressLb.backgroundColor = [UIColor getUsualColorWithString:@"#446EDD"];
        _addressLb.font = [UIFont systemFontOfSize:10.f];
        _addressLb.textAlignment = NSTextAlignmentCenter;
        _addressLb.text = @"学校";
        ZViewBorderRadius(_addressLb, 5, 0, [UIColor whiteColor]);
    }
    return _addressLb;
}
- (UIImageView *)addressImgView{
    
    if (!_addressImgView) {
        
        _addressImgView = [[UIImageView alloc] init];
        _addressImgView.contentMode = UIViewContentModeScaleAspectFill;
        _addressImgView.clipsToBounds = YES;
        [_addressImgView setImage:[UIImage imageNamed:@"xioaoxi_icon_dizhi"]];
    }
    return _addressImgView;
}
- (UILabel *)addressDetailLb{
    
    if (!_addressDetailLb) {
        
        _addressDetailLb = [[UILabel alloc] init];
        _addressDetailLb.textColor = [UIColor getUsualColorWithString:@"#515151"];
        _addressDetailLb.font = [UIFont systemFontOfSize:14.f];
        _addressDetailLb.textAlignment = NSTextAlignmentLeft;
        _addressDetailLb.text = @"地址：滨江区西兴街道物联网大厦·滨江国际创新园大厦·滨江国际大厦·滨江国际";
        _addressDetailLb.numberOfLines = 0;
    }
    return _addressDetailLb;
}


@end
