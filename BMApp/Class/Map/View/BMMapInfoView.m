//
//  BMMapInfoView.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMapInfoView.h"
#import "BMBatteryView.h"
@interface BMMapInfoView()

@property(nonatomic ,strong)UIImageView * bgImgView;
@property(nonatomic ,strong)UIButton * footprintBtn;
@property(nonatomic ,strong)UIButton * naviBtn;
@property(nonatomic ,strong)UIView * line;
@property(nonatomic ,strong)UILabel * refreshLb;
@property(nonatomic ,strong)UIButton * refreshBtn;
@property(nonatomic ,strong)UILabel * addressLb;
@property(nonatomic ,strong)UIImageView * iconImgView;
@property(nonatomic ,strong)UILabel * distanceLb;
@property(nonatomic ,strong)UIView * circleView;
@property(nonatomic ,strong)UILabel * nameLb;
@property(nonatomic ,strong)BMBatteryView * batteryView;
@property(nonatomic ,strong)UILabel * batteryLabel;
@property(nonatomic ,strong)UILabel * stateLb;
@end

@implementation BMMapInfoView

- (void)setDevice:(BMDeviceModel *)device{
 
    _device = device;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",device.picUrl]] placeholderImage:nil];
    self.nameLb.text = device.name;
    self.distanceLb.text = [NSString stringWithFormat:@"距离 %@",device.distance];
    self.addressLb.text = device.position;
    self.refreshLb.text =[NSString stringWithFormat:@"最后一次更新时间  %@",[CommonMethod configDateWithDate:device.refreshTime]];
    [self.batteryView setBatteryValue:[device.battery intValue]];
    self.batteryLabel.text = [NSString stringWithFormat:@"%@%%",device.battery];
    if ([device.status isEqualToString:@"0"]) {
        
        self.stateLb.text = @"已离线";
    }else{
        
        self.stateLb.text = @"";
    }
    [self.addressLb mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(CGRectGetWidth(self.addressLb.frame) + 5);
    }];
}

- (void)func:(UIButton *)btn{
 
    if (self.funcBlock) {
        
        self.funcBlock(btn.tag);
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.bgImgView];
        [self addSubview:self.footprintBtn];
        [self addSubview:self.naviBtn];
        [self addSubview:self.line];
        [self addSubview:self.refreshLb];
        [self addSubview:self.refreshBtn];
        [self addSubview:self.addressLb];
        [self addSubview:self.iconImgView];
        [self addSubview:self.distanceLb];
        [self addSubview:self.circleView];
        [self addSubview:self.nameLb];
        [self addSubview:self.batteryLabel];
        [self addSubview:self.batteryView];
        [self addSubview:self.stateLb];
        
        [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(19 * AutoSizeScaleY);
            make.left.equalTo(35 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(43 * AutoSizeScaleX, 43 * AutoSizeScaleX));
            
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(22 * AutoSizeScaleY);
            make.left.equalTo(self.circleView);
            make.height.equalTo(18 * AutoSizeScaleY);
        }];
        [self.batteryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.nameLb);
            make.right.equalTo(- 27 * AutoSizeScaleX);
            make.height.equalTo(10 * AutoSizeScaleY);
        }];
        [self.batteryView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.batteryLabel.mas_left).offset(- 5);
            make.centerY.equalTo(self.batteryLabel);
            make.size.equalTo(CGSizeMake(21, 12));
        }];
        [self.stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.batteryView);
            make.top.equalTo(self.batteryView.mas_bottom).offset(3);
            make.height.equalTo(12 * AutoSizeScaleY);
        }];
        [self.distanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconImgView.mas_right).offset(21 * AutoSizeScaleX);
            make.top.equalTo(self.nameLb.mas_bottom).offset(8 * AutoSizeScaleY);
            make.height.equalTo(12 * AutoSizeScaleY);
        }];
        [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.distanceLb.mas_left).offset(- 3 * AutoSizeScaleX);
            make.centerY.equalTo(self.distanceLb);
            make.size.equalTo(CGSizeMake(5 * AutoSizeScaleX, 5 * AutoSizeScaleX));
        }];
        [self.addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.distanceLb.mas_bottom).offset(15 * AutoSizeScaleY);
            make.left.equalTo(23 * AutoSizeScaleX);
            make.right.equalTo(- 26 * AutoSizeScaleX);
        }];
        
        [self.refreshLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.addressLb.mas_bottom).offset(10 * AutoSizeScaleY);
            make.left.equalTo(23 * AutoSizeScaleX);
            make.height.equalTo(12 * AutoSizeScaleY);
        }];
        [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.refreshLb);
            make.left.equalTo(self.refreshLb.mas_right).offset(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(43 * AutoSizeScaleX, 30 * AutoSizeScaleX));
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.refreshLb.mas_bottom).offset(19 * AutoSizeScaleY);
            make.left.equalTo(6 * AutoSizeScaleX);
            make.right.equalTo(-12 * AutoSizeScaleX);
            make.height.equalTo(1);
        }];
        [self.footprintBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.line.mas_bottom).offset(9 * AutoSizeScaleY);
            make.left.equalTo(44 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(105 * AutoSizeScaleX, 35 * AutoSizeScaleX));
            make.bottom.equalTo(- 25 * AutoSizeScaleY);
        }];
        [self.naviBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.footprintBtn);
            make.right.equalTo(- 49 * AutoSizeScaleX);
            make.size.equalTo(self.footprintBtn);
        }];
        
    }
    return self;
}

- (UIImageView *)bgImgView{
 
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImgView.clipsToBounds = YES;
        [_bgImgView setImage:[UIImage imageNamed:@"xinxi_bg_dis"]];
    }
    return _bgImgView;
}
- (UIButton *)footprintBtn{
    
    if (!_footprintBtn) {
        
        _footprintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_footprintBtn setImage:[UIImage imageNamed:@"xinxi_icon_zuji"] forState:UIControlStateNormal];
        [_footprintBtn setTitle:@"足迹" forState:UIControlStateNormal];
        [_footprintBtn setTitleColor:[UIColor getUsualColorWithString:@"#212121"] forState:UIControlStateNormal];
        _footprintBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_footprintBtn setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        ZViewBorderRadius(_footprintBtn, 18 * AutoSizeScaleY, 1, [UIColor getUsualColorWithString:@"#CDCDCD"]);
        _footprintBtn.tag = 2;
        [_footprintBtn addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footprintBtn;
}
- (UIButton *)naviBtn{
    
    if (!_naviBtn) {
        
        _naviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_naviBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
        [_naviBtn setImage:[UIImage imageNamed:@"xinxi_icon_daohang"] forState:UIControlStateNormal];
        [_naviBtn setTitle:@"导航" forState:UIControlStateNormal];
        [_naviBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
        _naviBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_naviBtn setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        ZViewBorderRadius(_naviBtn, 18 * AutoSizeScaleY, 0, [UIColor getUsualColorWithString:@"#CDCDCD"]);
        _naviBtn.tag = 3;
        [_naviBtn addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBtn;
}
- (UIView *)line{
 
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor getUsualColorWithString:@"#E0E0E0"];
    }
    return _line;
}
- (UILabel *)refreshLb{
    
    if (!_refreshLb) {
        
        _refreshLb = [[UILabel alloc] init];
        _refreshLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _refreshLb.font = [UIFont systemFontOfSize:12.f];
        _refreshLb.textAlignment = NSTextAlignmentLeft;
        _refreshLb.text = @"最后一次更新时间";
    }
    return _refreshLb;
}
- (UIButton *)refreshBtn{
 
    if (!_refreshBtn) {
        
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [_refreshBtn setTitleColor:[UIColor getUsualColorWithString:@"#4285F4"] forState:UIControlStateNormal];
        _refreshBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _refreshBtn.tag = 1;
        [_refreshBtn addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}
- (UILabel *)addressLb{
    
    if (!_addressLb) {
        
        _addressLb = [[UILabel alloc] init];
        _addressLb.textColor = [UIColor getUsualColorWithString:@"#515151"];
        _addressLb.font = [UIFont systemFontOfSize:14.f];
        _addressLb.textAlignment = NSTextAlignmentLeft;
        _addressLb.text = @"滨江区西兴街道物联网大厦·滨江国际创新园滨江区西兴街道物联网大厦·滨江国际创新园";
        _addressLb.numberOfLines = 0;
    }
    return _addressLb;
}

- (UILabel *)distanceLb{
    
    if (!_distanceLb) {
        
        _distanceLb = [[UILabel alloc] init];
        _distanceLb.textColor = [UIColor getUsualColorWithString:@"#515151"];
        _distanceLb.font = [UIFont systemFontOfSize:12.f];
        _distanceLb.textAlignment = NSTextAlignmentLeft;
        _distanceLb.text = @"距离 km";
    }
    return _distanceLb;
}
- (UIView *)circleView{
 
    if (!_circleView) {
        
        _circleView = [[UIView alloc] init];
        _circleView.backgroundColor = [UIColor getUsualColorWithString:@"#487ED6"];
        ZViewBorderRadius(_circleView, 5 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _circleView;
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
- (UILabel *)batteryLabel{
    
    if (!_batteryLabel) {
        
        _batteryLabel = [[UILabel alloc] init];
        _batteryLabel.textColor = [UIColor getUsualColorWithString:@"#515151"];
        _batteryLabel.font = [UIFont systemFontOfSize:12.f];
        _batteryLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _batteryLabel;
}
- (BMBatteryView *)batteryView{
 
    if (!_batteryView) {

        _batteryView = [[BMBatteryView alloc] initWithFrame:CGRectMake(0, 0, 21, 12)];
        
    }
    return _batteryView;
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
- (UILabel *)stateLb{
    
    if (!_stateLb) {
        
        _stateLb = [[UILabel alloc] init];
        _stateLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _stateLb.font = [UIFont systemFontOfSize:12.f];
        _stateLb.textAlignment = NSTextAlignmentLeft;
        
    }
    return _stateLb;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
