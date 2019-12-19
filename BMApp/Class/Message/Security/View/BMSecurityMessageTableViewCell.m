//
//  BMSecurityMessageTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMSecurityMessageTableViewCell.h"

@interface BMSecurityMessageTableViewCell()

@property(nonatomic ,strong)UIView * infoView;
@property(nonatomic ,strong)UIImageView * imgView;
@property(nonatomic ,strong)UILabel * stateLb;
@property(nonatomic ,strong)UILabel * timeLb;
@property(nonatomic ,strong)UIView * line;
@property(nonatomic ,strong)UIImageView * iconImgView;
@property(nonatomic ,strong)UILabel * nameLb;
@property(nonatomic ,strong)UILabel * tipLb;
@property(nonatomic ,strong)UILabel * addressLb;
@property(nonatomic ,strong)UIImageView * addressImgView;
@property(nonatomic ,strong)UILabel * addressDetailLb;

@end

@implementation BMSecurityMessageTableViewCell

- (void)setModel:(BMSecurityMsgModel *)model{
    
    _model = model;
//    消息类型
//    SOS(1, “求救信息”),
//    RETENTION(2, “异常停留”),
//    ARRIVE(3, “进入围栏”),
//    LEAVE(4, “离开围栏”);
    if ([model.type isEqualToString:@"1"]) {
        
        [self.imgView setImage:[UIImage imageNamed:@"xioaxi_bg_sos"]];
        self.stateLb.textColor = [UIColor getUsualColorWithString:@"#D83306"];
        self.stateLb.text = @"紧急求助";
        self.tipLb.text = @"向您请求帮助";
    }else if ([model.type isEqualToString:@"3"]) {
        
        [self.imgView setImage:[UIImage imageNamed:@"xioxi_bg_yuan"]];
        self.stateLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        self.stateLb.text = @"进入电子围栏";
        self.tipLb.text = @"进入";
       
    }else if ([model.type isEqualToString:@"4"]) {
        
        [self.imgView setImage:[UIImage imageNamed:@"xioxi_bg_yuan"]];
        self.stateLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        self.stateLb.text = @"离开电子围栏";
        self.tipLb.text = @"离开";
  
    }else if ([model.type isEqualToString:@"2"]) {
        
        [self.imgView setImage:[UIImage imageNamed:@"xiaoxi_bg_yichang"]];
        self.stateLb.textColor = [UIColor getUsualColorWithString:@"#FFB43E"];
        self.stateLb.text = @"异常停留";
        self.tipLb.text = @"异常停留";
        
    }
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.devicePic]] placeholderImage:nil];
    self.nameLb.text = model.name;
    self.addressDetailLb.text = [NSString stringWithFormat: @"位置：%@",model.position];
    NSString * ampm = @"";
//    if ([model.amPm isEqualToString:@"0"]) {
//
//        ampm = @"上午";
//    }else{
//
//        ampm = @"下午";
//    }
    self.timeLb.text = [NSString stringWithFormat:@"%@%@",[CommonMethod configDateWithDate:model.createTime],ampm];
    if (model.fenceName.length == 0) {
        
        [self.addressLb mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(0);
        }];
    }else{
        
        [self.addressLb mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo([UILabel getWidthWithTitle:model.fenceName font:[UIFont systemFontOfSize:10.f]] + 3);
        }];
    }
    self.addressLb.text = model.fenceName;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        
        [self.contentView addSubview:self.infoView];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.stateLb];
        [self.contentView addSubview:self.timeLb];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.tipLb];
        [self.contentView addSubview:self.addressLb];
        [self.contentView addSubview:self.addressImgView];
        [self.contentView addSubview:self.addressDetailLb];
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(15 * AutoSizeScaleX);
            make.width.equalTo(Z_SCREEN_WIDTH - 30 * AutoSizeScaleX);
            make.top.equalTo(10 * AutoSizeScaleY);
            make.bottom.equalTo(self.contentView);
        }];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.infoView).offset(12 * AutoSizeScaleX);
            make.top.equalTo(self.infoView).offset(10 * AutoSizeScaleY);
            make.size.equalTo(CGSizeMake(16 * AutoSizeScaleX, 16 * AutoSizeScaleX));
        }];
        [self.stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.imgView.mas_right).offset(7 * AutoSizeScaleX);
            make.centerY.equalTo(self.imgView);
            make.height.equalTo(14 * AutoSizeScaleY);
        }];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.infoView).offset(- 10 * AutoSizeScaleX);
            make.centerY.equalTo(self.imgView);
            make.height.equalTo(14 * AutoSizeScaleY);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.equalTo(self.infoView);
            make.top.equalTo(self.stateLb.mas_bottom).offset(10 * AutoSizeScaleY);
            make.height.equalTo(1);
        }];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.line.mas_bottom).offset(8 * AutoSizeScaleY);
            make.left.equalTo(self.infoView).offset(13 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(36 * AutoSizeScaleX, 36 * AutoSizeScaleX));
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.line.mas_bottom).offset(13 * AutoSizeScaleY);
            make.left.equalTo(self.iconImgView.mas_right).offset(13 * AutoSizeScaleX);
            make.height.equalTo(13 * AutoSizeScaleY);
        }];
        [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.nameLb.mas_bottom).offset(7 * AutoSizeScaleY);
            make.left.equalTo(self.nameLb);
            make.height.equalTo(12 * AutoSizeScaleY);
        }];
        
        [self.addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.tipLb);
            make.left.equalTo(self.tipLb.mas_right).offset(7 * AutoSizeScaleX);
            make.height.equalTo(10 * AutoSizeScaleY);
            make.width.equalTo(0);
        }];
        [self.addressDetailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.tipLb.mas_bottom).offset(18 * AutoSizeScaleY);
            make.left.equalTo(41 * AutoSizeScaleX);
            make.width.equalTo(310 * AutoSizeScaleX);
            make.bottom.equalTo(- 13 * AutoSizeScaleY);
        }];
        
        [self.addressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.addressDetailLb);
            make.left.equalTo(self.iconImgView);
            make.size.equalTo(CGSizeMake(10 * AutoSizeScaleX, 12 * AutoSizeScaleX));
        }];
    }
    return self;
}

- (UIView *)infoView{
    
    if (!_infoView) {
        
        _infoView = [[UIView alloc] init];
        _infoView.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        ZViewBorderRadius(_infoView, 5, 0, [UIColor whiteColor]);
    }
    return _infoView;
}
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"xioaxi_bg_sos"]];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
    }
    return _imgView;
}
- (UILabel *)stateLb{
    
    if (!_stateLb) {
        
        _stateLb = [[UILabel alloc] init];
        _stateLb.textColor = [UIColor getUsualColorWithString:@"#D83306"];
        _stateLb.font = [UIFont systemFontOfSize:15.f];
        _stateLb.textAlignment = NSTextAlignmentLeft;
        _stateLb.text = @"紧急求助";
    }
    return _stateLb;
}
- (UILabel *)timeLb{
    
    if (!_timeLb) {
        
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _timeLb.font = [UIFont systemFontOfSize:14.f];
        _timeLb.textAlignment = NSTextAlignmentRight;
        _timeLb.text = @"2分钟前";
    }
    return _timeLb;
}
- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor getUsualColorWithString:@"#EBEBEB"];
    }
    return _line;
}
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        ZViewBorderRadius(_iconImgView, 36 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _iconImgView;
}
- (UILabel *)nameLb{
    
    if (!_nameLb) {
        
        _nameLb = [[UILabel alloc] init];
        _nameLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _nameLb.font = [UIFont systemFontOfSize:13.f];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.text = @"小芸芸";
    }
    return _nameLb;
}
- (UILabel *)tipLb{
    
    if (!_tipLb) {
        
        _tipLb = [[UILabel alloc] init];
        _tipLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        _tipLb.font = [UIFont systemFontOfSize:12.f];
        _tipLb.textAlignment = NSTextAlignmentLeft;
        _tipLb.text = @"向您请求帮助";
    }
    return _tipLb;
}
- (UILabel *)addressLb{
    
    if (!_addressLb) {
        
        _addressLb = [[UILabel alloc] init];
        _addressLb.textColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _addressLb.backgroundColor = [UIColor getUsualColorWithString:@"#446EDD"];
        _addressLb.font = [UIFont systemFontOfSize:10.f];
        _addressLb.textAlignment = NSTextAlignmentCenter;
        _addressLb.text = @"学校";
        ZViewBorderRadius(_addressLb, 5, 0, [UIColor whiteColor]);
    }
    return _addressLb;
}
- (UIImageView *)addressImgView{
    
    if (!_addressImgView) {
        
        _addressImgView = [[UIImageView alloc] init];
        _addressImgView.contentMode = UIViewContentModeScaleAspectFill;
        _addressImgView.clipsToBounds = YES;
        [_addressImgView setImage:[UIImage imageNamed:@"xioaoxi_icon_dizhi"]];
    }
    return _addressImgView;
}
- (UILabel *)addressDetailLb{
    
    if (!_addressDetailLb) {
        
        _addressDetailLb = [[UILabel alloc] init];
        _addressDetailLb.textColor = [UIColor getUsualColorWithString:@"#000000"];
        _addressDetailLb.font = [UIFont systemFontOfSize:12.f];
        _addressDetailLb.textAlignment = NSTextAlignmentLeft;
        _addressDetailLb.text = @"位置：";
        _addressDetailLb.numberOfLines = 0;
    }
    return _addressDetailLb;
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
