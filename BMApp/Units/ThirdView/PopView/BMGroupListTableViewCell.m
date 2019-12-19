//
//  BMGroupListTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMGroupListTableViewCell.h"

@interface BMGroupListTableViewCell ()

@property(nonatomic ,strong)UIImageView * selectImgView;
@property(nonatomic ,strong)UILabel * titleLb;
@property(nonatomic ,strong)UILabel * tipLb;
@end
@implementation BMGroupListTableViewCell



- (void)setModel:(BMClusterModel *)model{
    
    _model = model;
    self.tipLb.hidden = YES;
    if ([model.ownerId isEqualToString:UserID]) {
        
        self.tipLb.hidden = NO;
    }
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.picUrl]] placeholderImage:nil];
    self.titleLb.text = model.name;

}
- (void)setIsSelect:(BOOL)isSelect{
    
    _isSelect = isSelect;
    self.selectImgView.hidden = !isSelect;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.selectImgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.tipLb];
        
        [self.selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15);
            make.size.equalTo(CGSizeMake(12, 12));
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
        }];
        [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.titleLb.mas_right).offset(3);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(13);
        }];
    }
    return self;
}
- (UIImageView *)selectImgView{
    
    if (!_selectImgView) {
        
        _selectImgView = [[UIImageView alloc] init];
        _selectImgView.contentMode = UIViewContentModeScaleAspectFill;
        _selectImgView.clipsToBounds = YES;
        [_selectImgView setImage:[UIImage imageNamed:@"icon_xuanze_s"]];
    }
    return _selectImgView;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _titleLb.font = [UIFont systemFontOfSize:16.f];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.text = @"家庭组";
    }
    return _titleLb;
}
- (UILabel *)tipLb{
    
    if (!_tipLb) {
        
        _tipLb = [[UILabel alloc] init];
        _tipLb.backgroundColor = [UIColor getUsualColorWithString:@"#B3B3B3"];
        _tipLb.textColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        _tipLb.font = [UIFont systemFontOfSize:9.f];
        _tipLb.textAlignment = NSTextAlignmentCenter;
        _tipLb.text = @"我创建的";
        ZViewBorderRadius(_tipLb, 5, 0, [UIColor whiteColor]);
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
