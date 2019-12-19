//
//  BMPeriodTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMPeriodTableViewCell.h"

@interface BMPeriodTableViewCell ()

@property(nonatomic ,strong)UIImageView * imgView;
@property(nonatomic ,strong)UILabel * nameLb;
@property(nonatomic ,strong)UILabel * dateLb;
@property(nonatomic ,strong)UILabel * timeLb;
@property(nonatomic ,strong)UIView * line;
@end
@implementation BMPeriodTableViewCell

- (NSString *)configTime:(NSString *)time{
    
    NSArray * timeArr = [time componentsSeparatedByString:@":"];
    return [NSString stringWithFormat:@"%@:%@",timeArr[0],timeArr[1]];
}


- (void)setRetention:(BMRetentionModel *)retention{
    
    _retention = retention;
    self.dateLb.text = [CommonMethod MineWeekDateToHans:retention.period];
    self.timeLb.text = [NSString stringWithFormat:@"%@-%@",[self configTime:retention.startTime],[self configTime:retention.endTime]];
}
- (void)setDevice:(BMDeviceModel *)device{
    
    _device = device;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",device.picUrl]] placeholderImage:nil];
    self.nameLb.text = device.name;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.dateLb];
        [self.contentView addSubview:self.timeLb];
        [self.contentView addSubview:self.line];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(36 * AutoSizeScaleX, 36 * AutoSizeScaleX));
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(12 * AutoSizeScaleY);
            make.left.equalTo(self.imgView.mas_right).offset(13 * AutoSizeScaleX);
            make.height.equalTo(13 * AutoSizeScaleY);
        }];
        [self.dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.nameLb);
            make.left.equalTo(self.nameLb.mas_right).offset(20 * AutoSizeScaleX);
            make.height.equalTo(13 * AutoSizeScaleY);
        }];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(- 10 * AutoSizeScaleY);
            make.left.equalTo(self.nameLb);
            make.height.equalTo(10 * AutoSizeScaleY);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
    }
    return self;
}

#pragma mark ======  lazy  ======
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        ZViewBorderRadius(_imgView, 36 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _imgView;
}

- (UILabel *)nameLb{
    
    if (!_nameLb) {
        
        _nameLb = [[UILabel alloc] init];
        _nameLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _nameLb.font = [UIFont systemFontOfSize:14.f];
        _nameLb.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLb;
}
- (UILabel *)dateLb{
    
    if (!_dateLb) {
        
        _dateLb = [[UILabel alloc] init];
        _dateLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        _dateLb.font = [UIFont systemFontOfSize:14.f];
        _dateLb.textAlignment = NSTextAlignmentRight;
    }
    return _dateLb;
}
- (UILabel *)timeLb{
    
    if (!_timeLb) {
        
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _timeLb.font = [UIFont systemFontOfSize:12.f];
        _timeLb.textAlignment = NSTextAlignmentRight;
    }
    return _timeLb;
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
