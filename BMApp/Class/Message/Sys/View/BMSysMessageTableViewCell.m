//
//  BMSysMessageTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMSysMessageTableViewCell.h"

@interface BMSysMessageTableViewCell()

@property(nonatomic ,strong)UIImageView * iconImgView;
@property(nonatomic ,strong)UILabel * nameLb;
@property(nonatomic ,strong)UILabel * tipLb;
@property(nonatomic ,strong)UILabel * timeLb;
@property(nonatomic ,strong)UIView * line;

@end

@implementation BMSysMessageTableViewCell

- (void)setNotice:(BMNoticeModel *)notice{
    
    _notice = notice;
    
    if ([notice.type isEqualToString:@"1"] || [notice.type isEqualToString:@"5"]) {
        
        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",notice.userPic]] placeholderImage:nil];
    }else{
        
        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",notice.picUrl]] placeholderImage:nil];
    }

    if ([notice.type isEqualToString:@"1"]) {
        
        self.nameLb.text = notice.nickName;
        self.tipLb.text = [NSString stringWithFormat:@"%@：%@",notice.title,notice.content];
        
    }else if ([notice.type isEqualToString:@"2"]              ) {
        //退出
        self.nameLb.text = notice.title;
        self.tipLb.text = [NSString stringWithFormat:@"已退出群-%@",notice.clusterName];
        
    }else if ([notice.type isEqualToString:@"3"]) {
        //加入
        self.nameLb.text = notice.title;
        self.tipLb.text = [NSString stringWithFormat:@"已加入群-%@",notice.clusterName];
    }else if ([notice.type isEqualToString:@"4"]) {
        //成为群主
        self.nameLb.text = notice.title;
        self.tipLb.text = [NSString stringWithFormat:@"已成为群主-%@",notice.clusterName];
    }else if ([notice.type isEqualToString:@"5"]) {
        //反馈回复通知
        self.nameLb.text = notice.nickName;
        self.tipLb.text = [NSString stringWithFormat:@"%@：%@",notice.title,notice.content];
    }else if ([notice.type isEqualToString:@"6"]) {
        //解散
        self.nameLb.text = notice.title;
        self.tipLb.text = [NSString stringWithFormat:@"已解散群-%@",notice.clusterName];
    }else if ([notice.type isEqualToString:@"7"]) {
        //紧急求助回复
        self.nameLb.text = notice.nickName;
        self.tipLb.text = [NSString stringWithFormat:@"%@：%@",notice.title,notice.content];
    }
    
    self.timeLb.text = [CommonMethod configDateWithDate:notice.publishTime];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.tipLb];
        [self.contentView addSubview:self.timeLb];
        [self.contentView addSubview:self.line];
       
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(36 * AutoSizeScaleX, 36 * AutoSizeScaleX));
        }];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 15 * AutoSizeScaleX);
            make.top.equalTo(12 * AutoSizeScaleY);
            make.height.equalTo(14 * AutoSizeScaleY);
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.timeLb);
            make.left.equalTo(self.iconImgView.mas_right).offset(13 * AutoSizeScaleX);
            make.height.equalTo(14 * AutoSizeScaleY);
            make.right.equalTo(self.timeLb.mas_left).offset(- 10 * AutoSizeScaleX);
        }];
        [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.nameLb.mas_bottom).offset(7);
            make.left.equalTo(self.nameLb);
            make.width.equalTo(Z_SCREEN_WIDTH - 65 * AutoSizeScaleX);
            make.bottom.equalTo(self.contentView).offset(- 7);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
    }
    return self;
}

- (UILabel *)timeLb{
    
    if (!_timeLb) {
        
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _timeLb.font = [UIFont systemFontOfSize:14.f];
        _timeLb.textAlignment = NSTextAlignmentRight;
        _timeLb.text = @"6:15 下午";
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
        _nameLb.font = [UIFont systemFontOfSize:14.f];
        _nameLb.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLb;
}
- (UILabel *)tipLb{
    
    if (!_tipLb) {
        
        _tipLb = [[UILabel alloc] init];
        _tipLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        _tipLb.font = [UIFont systemFontOfSize:12.f];
        _tipLb.textAlignment = NSTextAlignmentLeft;
        _tipLb.numberOfLines = 0;
    }
    return _tipLb;
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

