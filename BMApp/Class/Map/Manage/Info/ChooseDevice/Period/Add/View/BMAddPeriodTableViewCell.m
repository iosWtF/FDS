//
//  BMAddPeriodTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMAddPeriodTableViewCell.h"

@interface BMAddPeriodTableViewCell()<UITextFieldDelegate>

@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UIImageView *arrowImgView;
@property(nonatomic ,strong)UILabel *contentLb;
@property(nonatomic ,strong)UIView *line;
@end
@implementation BMAddPeriodTableViewCell

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLb.text = title;
    
}
- (void)setContent:(NSString *)content{
    
    _content = content;
    self.contentLb.text = content;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.arrowImgView];
        [self.contentView addSubview:self.contentLb];
        [self.contentView addSubview:self.line];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(15 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 15 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(7 * AutoSizeScaleX, 12 * AutoSizeScaleX));
        }];
        [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.arrowImgView.mas_left).offset(- 9 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentLb);
           
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
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _titleLb.font = [UIFont systemFontOfSize:16.f];
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
