//
//  BMFootprintTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMFootprintTableViewCell.h"

@interface BMFootprintTableViewCell()

@property(nonatomic ,strong)UILabel * addressLb;
@property(nonatomic ,strong)UIImageView * imgView;
@property(nonatomic ,strong)UILabel * timeLb;
@property(nonatomic ,strong)UIView * line1;
@property(nonatomic ,strong)UIView * line2;
@end

@implementation BMFootprintTableViewCell


- (void)setModel:(BMPositionModel *)model{
    
    _model = model;
    self.addressLb.text = model.position;
    self.timeLb.text = [CommonMethod HourAndMinuteWithDate:model.locationTime];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.addressLb];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.timeLb];
        [self.contentView addSubview:self.line1];
        [self.contentView addSubview:self.line2];
        
        [self.addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(15);
            make.bottom.equalTo(-15);
            make.left.equalTo(83 * AutoSizeScaleX);
            make.width.equalTo(Z_SCREEN_WIDTH - 93 * AutoSizeScaleX);
        }];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.addressLb.mas_left).offset( -10 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(15 * AutoSizeScaleX, 15 * AutoSizeScaleX));
        }];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.imgView.mas_left);
            make.height.equalTo(self.contentView);
            make.centerY.equalTo(self.addressLb);
        }];
        
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(66 * AutoSizeScaleX);
            make.bottom.equalTo(self.imgView.mas_top);
            make.top.equalTo(self.contentView);
            make.width.equalTo(1);
        }];
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(66 * AutoSizeScaleX);
            make.top.equalTo(self.imgView.mas_bottom);
            make.bottom.equalTo(self.contentView);
            make.width.equalTo(1);
        }];
        
    }
    return self;
    
}

- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"zuji_icon_yua"]];
    }
    return _imgView;
}

- (UILabel *)timeLb{
    
    if (!_timeLb) {
        
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = [UIColor getUsualColorWithString:@"#465469"];
        _timeLb.font = [UIFont systemFontOfSize:12.f];
        _timeLb.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLb;
}
- (UILabel *)addressLb{
    
    if (!_addressLb) {
        
        _addressLb = [[UILabel alloc] init];
        _addressLb.textColor = [UIColor getUsualColorWithString:@"#465469"];
        _addressLb.font = [UIFont systemFontOfSize:15.f];
        _addressLb.textAlignment = NSTextAlignmentLeft;
        _addressLb.numberOfLines = 0;
    }
    return _addressLb;
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
