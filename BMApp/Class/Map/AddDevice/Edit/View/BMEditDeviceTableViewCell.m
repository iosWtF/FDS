//
//  BMEditDeviceTableViewCell.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMEditDeviceTableViewCell.h"

@interface BMEditDeviceTableViewCell()<UITextFieldDelegate>

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *titleLb;
@property(nonatomic ,strong)UIImageView *arrowImgView;
@property(nonatomic ,strong)UITextField *contentTf;
@property(nonatomic ,strong)UIView *line;
@end
@implementation BMEditDeviceTableViewCell

- (void)setContent:(NSString *)content{
    
    _content = content;
    self.contentTf.text = content;
}


- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLb.text = title;
    self.iconImgView.hidden = YES;
    self.arrowImgView.hidden = YES;
    self.contentTf.hidden = YES;
    if ([title isEqualToString:@"设备头像点击更换/上传"]) {
        
        self.iconImgView.hidden = NO;
        self.arrowImgView.hidden = NO;
    }else{
        
        self.contentTf.hidden = NO;
    }
    if ([title isEqualToString:@"儿童生日"] || [title isEqualToString:@"儿童学习阶段"]) {
        
        self.arrowImgView.hidden = NO;
    }
}
- (void)setImg:(NSString *)img{
    
    _img = img;
    [self.imgView setImage:[UIImage imageNamed:img]];
}
- (void)setPlaceHolder:(NSString *)placeHolder{
    
    _placeHolder = placeHolder;
    self.contentTf.placeholder = placeHolder;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.arrowImgView];
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
            
            make.right.equalTo(-40 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(40 * AutoSizeScaleX, 40 * AutoSizeScaleX));
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 15 * AutoSizeScaleX);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(8 * AutoSizeScaleX, 14 * AutoSizeScaleX));
        }];
        [self.contentTf mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(- 40 * AutoSizeScaleX);
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
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#0C0C0C"];
        _titleLb.font = [UIFont systemFontOfSize:15.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        
    }
    return _titleLb;
}
- (UITextField *)contentTf{
    
    if (!_contentTf) {
        
        _contentTf = [[UITextField alloc] init];
        _contentTf.textColor = [UIColor getUsualColorWithString:@"#343434"];
        [_contentTf setValue:[UIColor getUsualColorWithString:@"#999999"] forKeyPath:@"placeholderLabel.textColor"];
        _contentTf.font = [UIFont systemFontOfSize:14.f];
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
        
        if (self.chooseBlock) {
            
            self.chooseBlock(textField);
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
