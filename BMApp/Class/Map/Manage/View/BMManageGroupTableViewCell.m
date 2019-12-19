//
//  BMManageGroupTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMManageGroupTableViewCell.h"

@interface BMManageGroupTableViewCell()

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UIImageView *arrowImgView;

@end
@implementation BMManageGroupTableViewCell

- (void)setModel:(BMClusterModel *)model{
    
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.picUrl]] placeholderImage:[UIImage imageNamed:@"xinxi_touxiang"]];
    self.titleLb.text = model.name;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.arrowImgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(40 * AutoSizeScaleX, 40 * AutoSizeScaleX));
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.imgView.mas_right).offset(14 * AutoSizeScaleX);
            make.height.equalTo(self.contentView);
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(-15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(8 * AutoSizeScaleX, 14 * AutoSizeScaleX));
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
        ZViewBorderRadius(_imgView, 40 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
        [_imgView setImage:[UIImage imageNamed:@"xinxi_touxiang"]];
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
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
        _titleLb.font = [UIFont systemFontOfSize:14.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
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
