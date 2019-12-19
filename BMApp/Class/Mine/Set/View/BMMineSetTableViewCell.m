//
//  BMMineSetTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineSetTableViewCell.h"

@interface BMMineSetTableViewCell()
@property(nonatomic ,strong)UISwitch * notiSwitch;
@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UILabel *contentLb;
@property(nonatomic ,strong)UIImageView *arrowImgView;
@property(nonatomic ,strong)UIView *line;
@end
@implementation BMMineSetTableViewCell

- (void)switchAction:(UISwitch *)noti{
    
    UserModel * user = [UserInfoManager getUser];
    NSString * message;
    if (noti.isOn) {
        
        message = @"1";
    }else{
        
        message = @"0";
    }
    [[BMHttpsMethod httpMethodManager] userUpdateWithId:UserID IsPush:message NickName:user.nickName PicUrl:user.picUrl Gender:user.gender Description:user.descriptionn ToGetResult:^(id  _Nonnull data) {

        if ([data[@"errorCode"] isEqualToString:@"0000"]) {

            user.isPush = message;
            [[BMUserInfoManager sharedManager] saveUser:user];
        }
    }];
    
//    [[BMHttpsMethod httpMethodManager] personSaveEquipmentSetWithUserid:UserID Wifi:model.wifi DoNotDisturb:model.doNotDisturb Shake:model.shake Voice:model.voice Ringtone:@"" MessagePush:message ToGetResult:^(id  _Nonnull data) {
//
//        if ([data[@"code"] isEqualToNumber:@0]) {
//
//            model.messagePush = message;
//            [[BMUserInfoManager sharedManager] saveUser:model];
//        }
//    }];
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLb.text = title;
    
}
- (void)setCache:(NSString *)cache{
    
    _cache = cache;
    if (!cache || cache.length == 0) {
        
        self.contentLb.hidden = YES;
    }else{
        self.contentLb.hidden = NO;
        self.contentLb.text = cache;
        
    }
}
- (void)setArrowHide:(BOOL)arrowHide{
    
    _arrowHide = arrowHide;
    self.notiSwitch.hidden = YES;
    self.arrowImgView.hidden = YES;
    if (arrowHide) {
        
        self.notiSwitch.hidden = NO;
        UserModel * model = [UserInfoManager getUser];
        if ([model.isPush isEqualToString:@"1"]) {
            
            self.notiSwitch.on = YES;
        }else{
            
            self.notiSwitch.on = NO;
        }
    }else{
        
        self.arrowImgView.hidden = NO;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.notiSwitch];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.contentLb];
        [self.contentView addSubview:self.arrowImgView];
        [self.contentView addSubview:self.line];
        
        [self.notiSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(- 14 * AutoSizeScaleY);
            make.size.mas_equalTo(CGSizeMake(53 * AutoSizeScaleX, 29 * AutoSizeScaleX));
        }];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(14 * AutoSizeScaleX);
            make.height.equalTo(53 * AutoSizeScaleY);
        }];
        [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(- 25 * AutoSizeScaleX);
            make.height.equalTo(53 * AutoSizeScaleY);
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(-12 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(6 * AutoSizeScaleX, 11 * AutoSizeScaleX));
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
    }
    return self;
}
#pragma mark ======  lazy  ======
- (UISwitch *)notiSwitch{
    
    if (!_notiSwitch) {
        
        _notiSwitch = [[UISwitch alloc] init];
        [_notiSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _notiSwitch;
}
- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] init];
        [_arrowImgView setImage:[UIImage imageNamed:@"my_icon_dianji"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImgView.clipsToBounds = YES;
        
    }
    return _arrowImgView;
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
- (UILabel *)contentLb{
    
    if (!_contentLb) {
        
        _contentLb = [[UILabel alloc] init];
        _contentLb.textColor = [UIColor getUsualColorWithString:@"#A4A4A4"];
        _contentLb.font = [UIFont systemFontOfSize:16.f];
        _contentLb.textAlignment = NSTextAlignmentRight;
        
    }
    return _contentLb;
}
- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor getUsualColorWithString:@"#F8F8F9"];
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
