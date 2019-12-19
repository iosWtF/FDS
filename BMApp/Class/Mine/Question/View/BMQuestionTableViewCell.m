//
//  BMQuestionTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMQuestionTableViewCell.h"

@interface BMQuestionTableViewCell()
@property(nonatomic ,strong)UIView * bgView;
@property(nonatomic ,strong)UILabel * contentLb;
@property(nonatomic ,strong)UIImageView * arrowImgView;
@end
@implementation BMQuestionTableViewCell

- (void)setQuestion:(BMQuestionModel *)question{
    
    _question = question;
    self.contentLb.text = [NSString stringWithFormat:@"%@、%@",question.sort,question.name];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F5F5"];
        
        [self.contentView addSubview:self.bgView];
        [self.contentView addSubview:self.contentLb];
        [self.contentView addSubview:self.arrowImgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(- 7 * AutoSizeScaleY);
        }];
        
        [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(14 * AutoSizeScaleX);
            make.width.equalTo(Z_SCREEN_WIDTH - 28 * AutoSizeScaleX);
            make.top.equalTo(self.contentView).offset(10 * AutoSizeScaleX);
            make.bottom.equalTo(- 17 * AutoSizeScaleX);
            
        }];
        
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(- 16 * AutoSizeScaleX);
            make.centerY.equalTo(self.bgView);
            make.size.equalTo(CGSizeMake(7 * AutoSizeScaleX, 13 * AutoSizeScaleX));
        }];
    }
    return self;
}
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)contentLb{
    
    if (!_contentLb) {
        
        _contentLb = [[UILabel alloc] init];
        _contentLb.text = @"常见问题常见问题常见问题常见问题";
        _contentLb.textColor = [UIColor getUsualColorWithString:@"#343434"];
        _contentLb.font = [UIFont systemFontOfSize:15.f];
        _contentLb.textAlignment = NSTextAlignmentLeft;
        _contentLb.numberOfLines = 0;
    }
    return _contentLb;
}
- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wenti_icon_dianji"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImgView.clipsToBounds = YES;
    }
    return _arrowImgView;
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
