//
//  BMMineInfoTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineInfoTableViewCell.h"

@interface BMMineInfoTableViewCell()<UITextFieldDelegate>

@property(nonatomic ,strong)UILabel *titleLb;

@property(nonatomic ,strong)UIImageView *arrowImgView;
@property(nonatomic ,strong)UITextField *contentTf;
@property(nonatomic ,strong)UIView *line;
@end
@implementation BMMineInfoTableViewCell


- (void)setUser:(UserModel *)user{
    
    if ([self.title isEqualToString:@"头像"]) {
        
        self.iconImgView.hidden = NO;
        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",user.picUrl]] placeholderImage:nil];
    }
    
    if ([self.title isEqualToString:@"昵称"]) {
        self.contentTf.text = user.nickName;
        self.contentTf.hidden = NO;
        [self.contentTf mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 15 * AutoSizeScaleX);
        }];
    }else if ([self.title isEqualToString:@"手机号码"]) {
        
        self.contentTf.text = user.phoneNo;
        self.contentTf.hidden = NO;
        [self.contentTf mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 15 * AutoSizeScaleX);
        }];
    }else if ([self.title isEqualToString:@"性别"]){
        
        if ([user.gender isEqualToString:@"1"]) {
            
            self.contentTf.text = @"男";
        }else if ([user.gender isEqualToString:@"2"]) {
            
            self.contentTf.text = @"女";
        }else{
            
            self.contentTf.text = @"未设置";
        }
        
        self.contentTf.hidden = NO;
        [self.contentTf mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 29 * AutoSizeScaleX);
        }];
    }
    
    if ([self.title isEqualToString:@"头像"] || [self.title isEqualToString:@"性别"] || [self.title isEqualToString:@"个人二维码"]) {
        
        self.arrowImgView.hidden = NO;
    }
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLb.text = title;
    self.iconImgView.hidden = YES;
    self.arrowImgView.hidden = YES;
    self.contentTf.hidden = YES;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.arrowImgView];
        [self.contentView addSubview:self.contentTf];
        [self.contentView addSubview:self.line];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(15 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(14 * AutoSizeScaleY);
        }];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(-28 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(45 * AutoSizeScaleX, 45 * AutoSizeScaleX));
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 15 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(5 * AutoSizeScaleX, 10 * AutoSizeScaleX));
        }];
        [self.contentTf mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 15 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(45 * AutoSizeScaleY);
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

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        //        _iconImgView.backgroundColor = [UIColor redColor];
        ZViewBorderRadius(_iconImgView, 45 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
    }
    return _iconImgView;
}
- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] init];
        [_arrowImgView setImage:[UIImage imageNamed:@"my_icon_sanjiao1"]];
    }
    return _arrowImgView;
}
- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#0C0C0C"];
        _titleLb.font = [UIFont systemFontOfSize:15.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        
    }
    return _titleLb;
}
- (UITextField *)contentTf{
    
    if (!_contentTf) {
        
        _contentTf = [[UITextField alloc] init];
        _contentTf.textColor = [UIColor getUsualColorWithString:@"#999999"];
        _contentTf.font = [UIFont systemFontOfSize:15.f];
        _contentTf.textAlignment = NSTextAlignmentRight;
        _contentTf.delegate = self;
        [_contentTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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

#pragma mark - textFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (!self.canEdit) {
        
        if (self.chooseSexBlock) {
            
            self.chooseSexBlock(textField);
        }
    }

    return self.canEdit;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }
    if ([NSString isNineKeyBoard:string] ){
        
        return YES;
    }else{
        
        if ([NSString stringContainsEmoji:string]) {
            
            return NO;
        }
    }
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField{
    
    
    NSUInteger maxLength = 10;
    // text field 的内容
    NSString *contentText = textField.text;
    // 获取高亮内容的范围
    UITextRange *selectedRange = [textField markedTextRange];
    // 这行代码 可以认为是 获取高亮内容的长度
    NSInteger markedTextLength = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
    // 没有高亮内容时,对已输入的文字进行操作
    if (markedTextLength == 0) {
        // 如果 text field 的内容长度大于我们限制的内容长度
        if (contentText.length > maxLength) {
            
            NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
            textField.text = [contentText substringWithRange:rangeRange];
        }
    }
    if (self.editBlock) {
        
        self.editBlock(textField);
    }
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
