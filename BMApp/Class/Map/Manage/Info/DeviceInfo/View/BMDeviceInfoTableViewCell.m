//
//  BMDeviceInfoTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMDeviceInfoTableViewCell.h"

@interface BMDeviceInfoTableViewCell()

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *titleLb;

@property(nonatomic ,strong)UIView *line;
@end
@implementation BMDeviceInfoTableViewCell

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLb.text = title;
    
}
- (void)setImg:(NSString *)img{
    
    _img = img;
    [self.imgView setImage:[UIImage imageNamed:img]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.contentTf];
        [self.contentView addSubview:self.line];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(15 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(14 * AutoSizeScaleX, 14 * AutoSizeScaleX));
        }];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.imgView.mas_right).offset(8 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
        }];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(-15 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(40 * AutoSizeScaleX, 40 * AutoSizeScaleX));
        }];
        [self.contentTf mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 17 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.width.equalTo(Z_SCREEN_WIDTH / 2);
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

- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        //        _iconImgView.backgroundColor = [UIColor redColor];
        ZViewBorderRadius(_iconImgView, 40 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _iconImgView;
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
- (UITextField *)contentTf{
    
    if (!_contentTf) {
        
        _contentTf = [[UITextField alloc] init];
        _contentTf.textColor = [UIColor getUsualColorWithString:@"#343434"];
        _contentTf.font = [UIFont systemFontOfSize:14.f];
        _contentTf.textAlignment = NSTextAlignmentRight;
        _contentTf.userInteractionEnabled = NO;
    }
    return _contentTf;
}


- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor getUsualColorWithString:@"#F1F1F1"];
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
