//
//  BMMineTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineTableViewCell.h"

@interface BMMineTableViewCell()

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UILabel *contentLb;
@property(nonatomic ,strong)UIImageView *arrowImgView;

@end
@implementation BMMineTableViewCell

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLb.text = title;
    if ([title isEqualToString:@"设置"]) {
        
        [self.imgView setImage:[UIImage imageNamed:@"my_icon_shezhi"]];
    }else if ([title isEqualToString:@"常见问题"]) {
        
        [self.imgView setImage:[UIImage imageNamed:@"my_icon_wetu"]];
    }else if ([title isEqualToString:@"分享应用"]) {
        
        [self.imgView setImage:[UIImage imageNamed:@"my_icon_fenxiag"]];
    }else if ([title isEqualToString:@"设备管理"]) {
        
        [self.imgView setImage:[UIImage imageNamed:@"my_icon_facility"]];
    }
}
- (void)setContent:(NSString *)content{
    
    _content = content;
    self.contentLb.text = content;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.contentLb];
        [self.contentView addSubview:self.arrowImgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(20 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(20 * AutoSizeScaleX, 20 * AutoSizeScaleX));
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
            make.right.equalTo(self.arrowImgView.mas_right).offset(- 12 * AutoSizeScaleX);
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
    }
    return _imgView;
}
- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] init];
        [_arrowImgView setImage:[UIImage imageNamed:@"my_icon_sanjiao1"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImgView.clipsToBounds = YES;
        
    }
    return _arrowImgView;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#000000"];
        _titleLb.font = [UIFont systemFontOfSize:15.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLb;
}
- (UILabel *)contentLb{
    
    if (!_contentLb) {
        
        _contentLb = [[UILabel alloc] init];
        _contentLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
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
