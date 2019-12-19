//
//  BMWeekTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMWeekTableViewCell.h"

@interface BMWeekTableViewCell()

@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UIImageView *selectImgView;
@property(nonatomic ,strong)UIView *line;
@end
@implementation BMWeekTableViewCell

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLb.text = title;
}
- (void)setSelect:(BOOL)select{
    
    _select = select;
    if (select) {
        
        [self.selectImgView setImage:[UIImage imageNamed:@"xuanze_btn_s"]];
    }else{
        
        [self.selectImgView setImage:[UIImage imageNamed:@"xuanze_btn_n"]];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.selectImgView];
        [self.contentView addSubview:self.line];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15 * AutoSizeScaleX);
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
        _titleLb.font = [UIFont systemFontOfSize:15.f];
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
