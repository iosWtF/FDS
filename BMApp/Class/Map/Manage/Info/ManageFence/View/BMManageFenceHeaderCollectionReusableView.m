//
//  BMManageFenceHeaderCollectionReusableView.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMManageFenceHeaderCollectionReusableView.h"

@interface BMManageFenceHeaderCollectionReusableView()

@property(nonatomic ,strong)UIImageView * bgImgView;
@property(nonatomic ,strong)UILabel * titleLb;
@property(nonatomic ,strong)UILabel * tipLb;
@end

@implementation BMManageFenceHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.bgImgView];
        [self addSubview:self.titleLb];
        [self addSubview:self.tipLb];
        [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.top.equalTo(self);
            make.height.equalTo(163 * AutoSizeScaleY);
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(50 * AutoSizeScaleY);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.width.equalTo(200 * AutoSizeScaleX);
        }];
        [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.bgImgView.mas_bottom).offset(15 * AutoSizeScaleY);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.width.equalTo(Z_SCREEN_WIDTH - 30 * AutoSizeScaleX);
        }];
    }
    return self;
}
- (UIImageView *)bgImgView{
    
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] init];
        [_bgImgView setImage:[UIImage imageNamed:@"guanli_bg"]];
    }
    return _bgImgView;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#FEFEFE"];
        _titleLb.font = [UIFont systemFontOfSize:13.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.text = @"您可以手动为该群设备电子围栏，当设备进入或离开围栏时您可以接收到相关提示信息。";
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}
- (UILabel *)tipLb{
    
    if (!_tipLb) {
        
        _tipLb = [[UILabel alloc] init];
        _tipLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _tipLb.font = [UIFont systemFontOfSize:12.f];
        _tipLb.textAlignment = NSTextAlignmentLeft;
        _tipLb.text = @"点击下方添加按钮，设置围栏位置、名称，当设备进入或离开围栏范围时，系统将自动通知您。";
        _tipLb.numberOfLines = 0;
    }
    return _tipLb;
}
@end
