//
//  BMManageFenceCollectionViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMManageFenceCollectionViewCell.h"

@interface BMManageFenceCollectionViewCell()


@end
@implementation BMManageFenceCollectionViewCell

- (void)setModel:(BMFenceModel *)model{
    
    _model = model;
    [self.imgView setImage:[UIImage imageNamed:@"bg_weilan"]];
    self.nameLb.text = model.name;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.nameLb];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(88 * AutoSizeScaleX, 88 * AutoSizeScaleX));
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.contentView);
            make.width.equalTo(self.contentView);
            make.height.equalTo(15 * AutoSizeScaleX);
            make.bottom.equalTo(self.contentView);
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
        [_imgView setImage:[UIImage imageNamed:@"bg_weilan"]];
    }
    return _imgView;
}
- (UILabel *)nameLb{
    
    if (!_nameLb) {
        
        _nameLb = [[UILabel alloc] init];
        _nameLb.textColor = [UIColor getUsualColorWithString:@"#000000"];
        _nameLb.font = [UIFont systemFontOfSize:14.f];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        
    }
    return _nameLb;
}



@end
