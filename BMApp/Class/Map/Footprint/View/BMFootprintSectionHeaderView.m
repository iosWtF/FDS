//
//  BMFootprintSectionHeaderView.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMFootprintSectionHeaderView.h"
#import "BMPositionModel.h"
@interface BMFootprintSectionHeaderView()

@property(nonatomic ,strong)UIView * line1;
@property(nonatomic ,strong)UIImageView * imgView;
@property(nonatomic ,strong)UIImageView * bgImgView;
@property(nonatomic ,strong)UILabel * titleLb;
@property(nonatomic ,strong)UIView * line2;
@end

@implementation BMFootprintSectionHeaderView


- (void)setModel:(BMPositionModel *)model{
 
    _model = model;
    self.titleLb.text = model.city;
    CGFloat width = [UILabel getWidthWithTitle:model.city font:[UIFont systemFontOfSize:12.f]];
    [self.bgImgView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.width.equalTo(width + 8);
    }];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
 
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.bgImgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.line1];
        [self.contentView addSubview:self.line2];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(17 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(14 * AutoSizeScaleX, 15 * AutoSizeScaleX));
        }];
        
        [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.imgView.mas_right).offset(10 * AutoSizeScaleX);
            make.height.equalTo(20 * AutoSizeScaleX);
            
        }];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.center.equalTo(self.bgImgView);
            make.height.equalTo(12 * AutoSizeScaleY);
        }];
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(66 * AutoSizeScaleX);
            make.bottom.equalTo(self.bgImgView.mas_top);
            make.top.equalTo(self.contentView);
            make.width.equalTo(1);
        }];
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(66 * AutoSizeScaleX);
            make.top.equalTo(self.bgImgView.mas_bottom);
            make.bottom.equalTo(self.contentView);
            make.width.equalTo(1);
        }];
        
    }
    return self;
    
}
- (UIImageView *)imgView{
 
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"zuji_btn_dizhi"]];
    }
    return _imgView;
}
- (UIImageView *)bgImgView{
    
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] init];
        [_bgImgView setImage:[UIImage imageNamed:@"zuji_icon_dizhi"]];
    }
    return _bgImgView;
}
- (UILabel *)titleLb{
 
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _titleLb.font = [UIFont systemFontOfSize:12.f];
        _titleLb.textAlignment = NSTextAlignmentCenter;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
