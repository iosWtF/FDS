//
//  BMMapMineInfoView.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMapMineInfoView.h"

@interface BMMapMineInfoView()

@property(nonatomic ,strong)UILabel * titleLb;
@property(nonatomic ,strong)UILabel * addressLb;

@end

@implementation BMMapMineInfoView

- (void)setDevice:(BMDeviceModel *)device{
 
    _device = device;
    self.addressLb.text = device.position;
}
- (void)setFence:(BMFenceModel *)fence{
 
    _fence = fence;
    self.titleLb.text = fence.name;
    self.addressLb.text = fence.position;
}
- (instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLb];
        [self addSubview:self.addressLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(23 * AutoSizeScaleY);
            make.left.equalTo(17 * AutoSizeScaleX);
            make.height.equalTo(15 * AutoSizeScaleY);
            
        }];
        [self.addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.titleLb.mas_bottom).offset(17 * AutoSizeScaleY);
            make.left.equalTo(self.titleLb);
            make.right.equalTo(- 17 * AutoSizeScaleX);
            make.bottom.equalTo(- 20 * AutoSizeScaleY);
        }];
        
    }
    return self;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#000000"];
        _titleLb.font = [UIFont systemFontOfSize:16.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.text = @"我的位置";
    }
    return _titleLb;
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
