//
//  BMMemberInfoTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMemberInfoTableViewCell.h"

@interface BMMemberInfoTableViewCell()


@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UILabel *contentLb;
@property(nonatomic ,strong)UIView *line;
@end
@implementation BMMemberInfoTableViewCell

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
        [self.contentView addSubview:self.contentLb];
        [self.contentView addSubview:self.line];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(16 * AutoSizeScaleX);
            make.height.equalTo(self.contentView);
        }];
        [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(21 * AutoSizeScaleX);
            make.right.equalTo(-17 * AutoSizeScaleX);
            make.width.equalTo(300 * AutoSizeScaleX);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.contentLb.mas_bottom).offset(17 * AutoSizeScaleX);
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
    }
    return self;
}
#pragma mark ======  lazy  ======

- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#050A1C"];
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
        _contentLb.numberOfLines = 0;
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
