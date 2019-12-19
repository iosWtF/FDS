//
//  BMContentTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMContentTableViewCell.h"

@interface BMContentTableViewCell()

@property(nonatomic ,strong)UILabel * titleLb;

@end

@implementation BMContentTableViewCell

- (void)setSettingModel:(BMDeviceSettingModel *)settingModel{
    
    _settingModel = settingModel;
    self.titleLb.text =[NSString stringWithFormat:@"紧急状态下将更改设备上传数据频率（默认移动状态下为%@分钟一次）%@秒上传一次，开启后%@分钟自动关闭。根据设备的传感器上传频次，存在5~30分钟延迟，还请谅解！",settingModel.sportModeMinute,settingModel.urgencyModeSecond,settingModel.urgencyModeMinute];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        [self.contentView addSubview:self.titleLb];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(15 * AutoSizeScaleX);
            make.width.equalTo(Z_SCREEN_WIDTH - 30 * AutoSizeScaleX);
            make.top.equalTo(10 * AutoSizeScaleY);
            make.bottom.equalTo(- 10 * AutoSizeScaleY);
        }];
        
        
    }
    return self;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        _titleLb.font = [UIFont systemFontOfSize:13.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
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

