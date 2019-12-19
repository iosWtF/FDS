//
//  BMFootprintInfoView.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMFootprintInfoView.h"

@interface BMFootprintInfoView()

@property(nonatomic ,strong)UILabel * timeLb;
@property(nonatomic ,strong)UILabel * addressLb;
@property(nonatomic ,strong)UIButton * leftBtn;
@property(nonatomic ,strong)UIButton * rightBtn;
@end

@implementation BMFootprintInfoView

- (void)setModel:(BMPositionModel *)model{
    
    _model = model;
    self.timeLb.text = [CommonMethod configDateWithDate:model.locationTime];
    self.addressLb.text = model.position;
}

- (void)leftClick{
    
    if (self.leftBlock) {
        
        self.leftBlock();
    }
    
}
- (void)rightClick{
    
    if (self.rightBlock) {
        
        self.rightBlock();
    }
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.addressLb];
        [self addSubview:self.timeLb];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        [self.addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(20 * AutoSizeScaleY);
            make.left.equalTo(42 * AutoSizeScaleX);
            make.right.equalTo(- 42 * AutoSizeScaleX);
            
        }];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.addressLb.mas_bottom).offset(15 * AutoSizeScaleY);
            make.left.equalTo(self.addressLb);
            make.height.equalTo(10 * AutoSizeScaleY);
            make.bottom.equalTo(- 20 * AutoSizeScaleY);
        }];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self);
            make.left.equalTo(8 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(30 * AutoSizeScaleX, 30 * AutoSizeScaleX));
        }];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.right.equalTo(- 8 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(30 * AutoSizeScaleX, 30 * AutoSizeScaleX));
        }];
    }
    return self;
}
- (UILabel *)timeLb{
    
    if (!_timeLb) {
        
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        _timeLb.font = [UIFont systemFontOfSize:12.f];
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.text = @"08:24";
    }
    return _timeLb;
}
- (UILabel *)addressLb{
    
    if (!_addressLb) {
        
        _addressLb = [[UILabel alloc] init];
        _addressLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _addressLb.font = [UIFont systemFontOfSize:14.f];
        _addressLb.textAlignment = NSTextAlignmentLeft;
        _addressLb.text = @"滨江区西兴街道物联网大厦·滨江国际创新园滨江区西兴街道物联网大厦·滨江国际创新园";
        _addressLb.numberOfLines = 0;
    }
    return _addressLb;
}
- (UIButton *)leftBtn{
    
    if (!_leftBtn) {
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"guiji_btn_zuo"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
    
}
- (UIButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"guiji_btn_you"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
