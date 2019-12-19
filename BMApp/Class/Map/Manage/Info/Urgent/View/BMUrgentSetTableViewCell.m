//
//  BMUrgentSetTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMUrgentSetTableViewCell.h"
#import "BMUrgentPopView.h"
@interface BMUrgentSetTableViewCell()

@property(nonatomic ,strong)UILabel * titleLb;

@property(nonatomic ,retain)UISwitch * funcSwitch;
@property(nonatomic ,strong)UIView * funcView;
@property(nonatomic ,strong)UIView * line;
@end

@implementation BMUrgentSetTableViewCell

- (void)setSettingModel:(BMDeviceSettingModel *)settingModel{
    
    _settingModel = settingModel;
}

- (void)func{
    
    if ([self.model.emergency isEqualToString:@"1"]) {
        
        [[CommonMethod getCurrentVC] showHint:[NSString stringWithFormat:@"设备紧急状态开启后%@分钟自动关闭",self.settingModel.urgencyModeMinute]];
    }else{
        
        [BMUrgentPopView showWithContent:@"" blockTapAction:^(NSInteger index) {
            
            if (index == 0) {
                
                
                
            }else if (index == 1){
                
                if (self.switchBlock) {
                    
                    self.switchBlock(self.funcSwitch);
                }
            }
        }];
    }
}

- (void)funcSwitch:(UISwitch *)swich{
    
    if (swich.on == NO) {
        
        
        
//        swich.on = YES;
    }else{
        
        
        
    }

}

- (void)setModel:(BMDeviceModel *)model{
    
    _model = model;
    self.titleLb.text = model.name;
    if ([model.emergency isEqualToString:@"0"]) {
        
        self.funcSwitch.on = NO;
    }else{
        
        self.funcSwitch.on = YES;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.funcSwitch];
        [self.contentView addSubview:self.funcView];
        [self.contentView addSubview:self.line];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(14 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(53 * AutoSizeScaleY);
        }];
        
        [self.funcSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 14 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(53 * AutoSizeScaleX, 29 * AutoSizeScaleY));
        }];
        [self.funcView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.funcSwitch);
            make.centerY.equalTo(self.funcSwitch);
            make.size.equalTo(self.funcSwitch);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(1);
        }];
    }
    return self;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _titleLb.font = [UIFont systemFontOfSize:16.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLb;
}
- (UISwitch *)funcSwitch{
    
    if (!_funcSwitch) {
        
        _funcSwitch = [[UISwitch alloc] init];
        _funcSwitch.onTintColor = [UIColor getUsualColorWithString:@"#FF5445"];
        [_funcSwitch addTarget:self action:@selector(funcSwitch:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _funcSwitch;
}
- (UIView *)funcView{
    
    if (!_funcView) {
        
        _funcView = [[UIView alloc] init];
        _funcView.backgroundColor = [UIColor clearColor];
        _funcView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(func)];
        [_funcView addGestureRecognizer:tap];
    }
    return _funcView;
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
    }
    return _line;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

