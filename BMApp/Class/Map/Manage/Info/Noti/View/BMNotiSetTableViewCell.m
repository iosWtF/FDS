//
//  BMNotiSetTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMNotiSetTableViewCell.h"

@interface BMNotiSetTableViewCell()

@property(nonatomic ,strong)UIImageView *iconImgView;
@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UIImageView *selectImgView;
@property(nonatomic ,strong)UIView *line;
@end
@implementation BMNotiSetTableViewCell

- (void)setUser:(BMClusterUserModel *)user{
    
    _user = user;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",user.picUrl]] placeholderImage:nil];
    self.titleLb.text = user.nickName;
    if ([user.remind isEqualToString:@"1"]) {
        
        [self.selectImgView setImage:[UIImage imageNamed:@"tongzi_xuan_s"]];
    }else{
        
        [self.selectImgView setImage:[UIImage imageNamed:@"tongzi_xuan_n"]];
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.selectImgView];
        [self.contentView addSubview:self.line];
        
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(36 * AutoSizeScaleX, 36 * AutoSizeScaleX));
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.iconImgView.mas_right).offset(12 * AutoSizeScaleX);
            make.height.equalTo(self.contentView);
        }];
        [self.selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(-15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(16 * AutoSizeScaleX, 16 * AutoSizeScaleX));
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
    }
    return self;
}
#pragma mark ======  lazy  ======
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        ZViewBorderRadius(_iconImgView, 36 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _iconImgView;
}
- (UIImageView *)selectImgView{
    
    if (!_selectImgView) {
        
        _selectImgView = [[UIImageView alloc] init];
        
    }
    return _selectImgView;
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
