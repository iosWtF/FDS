//
//  BMGroupInfoTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMGroupInfoTableViewCell.h"

@interface BMGroupInfoTableViewCell()

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UILabel *contentLb;


@end
@implementation BMGroupInfoTableViewCell

- (void)setDeviceModel:(BMDeviceModel *)deviceModel{
    
    _deviceModel = deviceModel;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:deviceModel.picUrl] placeholderImage:[UIImage imageNamed:@"xinxi_touxiang"]];
    self.titleLb.text = deviceModel.name;
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLb.text = title;
 
    
}
- (void)setContent:(NSString *)content{
    
    _content = content;
    self.contentLb.text = content;
}

- (void)setImgHidden:(BOOL)imgHidden{
    
    _imgHidden = imgHidden;
    self.imgView.hidden = imgHidden;
    if (imgHidden) {
        
        
        [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.width.equalTo(0);
        }];
        [self.titleLb mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(15 * AutoSizeScaleX);
        }];
    }else{
        
        [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(35 * AutoSizeScaleX);
        }];
        [self.titleLb mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.imgView.mas_right).offset(12 * AutoSizeScaleX);
        }];
        
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.arrowImgView];
        [self.contentView addSubview:self.contentLb];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(35 * AutoSizeScaleX, 35 * AutoSizeScaleX));
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.imgView.mas_right).offset(12 * AutoSizeScaleX);
            make.height.equalTo(self.contentView);
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(-20 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(7 * AutoSizeScaleX, 13 * AutoSizeScaleX));
        }];
        [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(- 33 * AutoSizeScaleX);
            make.height.equalTo(self.contentView);
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
        [_imgView setImage:[UIImage imageNamed:@"tianjia_icon_shebei"]];
        ZViewBorderRadius(_imgView, 35 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _imgView;
}
- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] init];
        [_arrowImgView setImage:[UIImage imageNamed:@"icon_dianji"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImgView.clipsToBounds = YES;
        
    }
    return _arrowImgView;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#050A1C"];
        _titleLb.font = [UIFont systemFontOfSize:15.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLb;
}
- (UILabel *)contentLb{
    
    if (!_contentLb) {
        
        _contentLb = [[UILabel alloc] init];
        _contentLb.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _contentLb.font = [UIFont systemFontOfSize:14.f];
        _contentLb.textAlignment = NSTextAlignmentRight;
    }
    return _contentLb;
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

