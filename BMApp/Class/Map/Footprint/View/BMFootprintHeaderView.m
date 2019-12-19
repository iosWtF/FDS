//
//  BMFootprintHeaderView.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMFootprintHeaderView.h"

@interface BMFootprintHeaderView()

@property(nonatomic ,strong)UIButton * leftBtn;
@property(nonatomic ,strong)UILabel * titleLb;
@property(nonatomic ,strong)UIButton * rightBtn;
@property(nonatomic ,strong)UIView * line1;
@property(nonatomic ,strong)UIImageView * imgView;
@property(nonatomic ,strong)UILabel * infoLb;
@property(nonatomic ,strong)UILabel * infoLb1;
@property(nonatomic ,strong)UIView * line2;
@end

@implementation BMFootprintHeaderView

- (void)leftClick{
    
    if (self.leftBlock) {
        
        self.leftBlock();
    }
    
}
- (void)rightClick{
    
    if ([[CommonMethod dateToHands:self.date] isEqualToString:@"今天"]) {
        
        return;
    }
    if (self.rightBlock) {
        
        self.rightBlock();
    }
}

- (void)setDate:(NSString *)date{
 
    _date = date;
    self.titleLb.text = [CommonMethod dateToHands:date];
}

- (void)setModel:(BMDeviceModel *)model{
 
    _model = model;
    self.titleLb.text = [CommonMethod dateToHands:model.refreshTime];
}

- (void)setIcon:(NSString *)icon{
 
    _icon = icon;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",icon]] placeholderImage:nil];
}

- (void)setCityCount:(NSString *)cityCount{
 
    _cityCount = cityCount;
    
}
- (void)setPositionCount:(NSString *)positionCount{
 
    _positionCount = positionCount;
    
    self.infoLb.attributedText = [CommonMethod changeStrColorWithContent:[NSString stringWithFormat:@"跨越了%@城市",self.cityCount] Str:[NSString stringWithFormat:@"%@",self.cityCount] Color:@"#446EDD" Font:17];
    self.infoLb1.attributedText = [CommonMethod changeStrColorWithContent:[NSString stringWithFormat:@"%@足迹",self.positionCount] Str:[NSString stringWithFormat:@"%@",self.positionCount] Color:@"#446EDD" Font:17];
}
- (instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.titleLb];
        [self addSubview:self.line1];
        [self addSubview:self.imgView];
        [self addSubview:self.infoLb];
        [self addSubview:self.infoLb1];
        [self addSubview:self.line2];
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.equalTo(self);
            make.width.equalTo(Z_SCREEN_WIDTH / 3);
            make.height.equalTo(60 * AutoSizeScaleY);
        }];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.top.equalTo(self);
            make.width.equalTo(Z_SCREEN_WIDTH / 3);
            make.height.equalTo(60 * AutoSizeScaleY);
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.height.equalTo(self.leftBtn);
            make.centerX.equalTo(self);
        }];
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.titleLb.mas_bottom);
            make.width.equalTo(Z_SCREEN_WIDTH);
            make.height.equalTo(10 * AutoSizeScaleY);
        }];
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.bottom.equalTo(self);
            make.width.equalTo(Z_SCREEN_WIDTH);
            make.height.equalTo(10 * AutoSizeScaleY);
        }];
        [self.infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(80 * AutoSizeScaleX);
            
            make.top.equalTo(self.line1.mas_bottom);
            make.bottom.equalTo(self.line2.mas_top);
        }];
        [self.infoLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.infoLb.mas_right);
            make.top.equalTo(self.line1.mas_bottom);
            make.bottom.equalTo(self.line2.mas_top);
        }];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(37 * AutoSizeScaleX, 37 * AutoSizeScaleX));
            make.centerY.equalTo(self.infoLb);
        }];
        
    }
    return self;
}

- (UIButton *)leftBtn{
 
    if (!_leftBtn) {
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"zuji_zuo_s"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
    
}
- (UIButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"zuji_you_s"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
    
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _titleLb.font = [UIFont systemFontOfSize:20.f];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.text = @"今天";
    }
    return _titleLb;
}
- (UIView *)line1{
 
    if (!_line1) {
        
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    }
    return _line1;
}
- (UIView *)line2{
    
    if (!_line2) {
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    }
    return _line2;
}
- (UIImageView *)imgView{
 
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        ZViewBorderRadius(_imgView, 37 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _imgView;
}
- (UILabel *)infoLb{
 
    if (!_infoLb) {
        
        _infoLb = [[UILabel alloc] init];
        _infoLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _infoLb.font = [UIFont systemFontOfSize:14.f weight:3];
        _infoLb.textAlignment = NSTextAlignmentLeft;
    }
    return _infoLb;
}
- (UILabel *)infoLb1{
    
    if (!_infoLb1) {
        
        _infoLb1 = [[UILabel alloc] init];
        _infoLb1.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _infoLb1.font = [UIFont systemFontOfSize:14.f weight:3];
        _infoLb1.textAlignment = NSTextAlignmentLeft;
    }
    return _infoLb1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
