//
//  BMChooseDeviceTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMChooseDeviceTableViewCell.h"

@interface BMChooseDeviceTableViewCell()

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UILabel *contentLb;
@property(nonatomic ,strong)UIImageView *arrowImgView;
@property(nonatomic ,strong)UIView *line;
@end
@implementation BMChooseDeviceTableViewCell

- (void)setDevice:(BMDeviceModel *)device{
    
    _device = device;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",device.picUrl]] placeholderImage:nil];
    self.titleLb.text = device.name;
    if ([device.retentionCount isEqualToString:@"0"]) {
        
        self.contentLb.text = @"未设置";
    }else{
        
        self.contentLb.text = [NSString stringWithFormat:@"已设置%@个",device.retentionCount];
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.arrowImgView];
        [self.contentView addSubview:self.contentLb];
        [self.contentView addSubview:self.line];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(36 * AutoSizeScaleX, 36 * AutoSizeScaleX));
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
            make.right.equalTo(self.arrowImgView.mas_left).offset(- 10 * AutoSizeScaleX);
            make.height.equalTo(self.contentView);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
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
        ZViewBorderRadius(_imgView, 36 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _imgView;
}
- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] init];
        [_arrowImgView setImage:[UIImage imageNamed:@"xuanze_sanjiao"]];
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
