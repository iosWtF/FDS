//
//  BMOpinionHeaderCollectionReusableView.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMOpinionHeaderCollectionReusableView.h"


@interface BMOpinionHeaderCollectionReusableView ()<UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic ,strong)UIView * line1;
@property(nonatomic ,strong)UIView * line2;
@property(nonatomic ,strong)UIView * line3;
@property(nonatomic ,strong)UILabel * titleLb;
@property(nonatomic ,strong)UITextView * opinionTv;
@property(nonatomic ,strong)UITextField * phoneTf;
@property(nonatomic ,strong)UILabel * uploadLb;

@end

@implementation BMOpinionHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        [self addSubview:self.line3];
        [self addSubview:self.titleLb];
        [self addSubview:self.opinionTv];
        [self addSubview:self.phoneTf];
        [self addSubview:self.uploadLb];
        
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(self);
            make.height.equalTo(10 * AutoSizeScaleY);
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.line1.mas_bottom).offset(14 * AutoSizeScaleY);
            make.left.equalTo(14 * AutoSizeScaleX);
            make.height.equalTo(15 *AutoSizeScaleY);
        }];
        [self.opinionTv mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.titleLb.mas_bottom).offset(16 * AutoSizeScaleY);
            make.left.equalTo(self.titleLb);
            make.height.equalTo(130 * AutoSizeScaleY);
            make.width.equalTo(Z_SCREEN_WIDTH - 28 * AutoSizeScaleX);
        }];
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.opinionTv.mas_bottom).offset(11 * AutoSizeScaleY);
            make.left.right.equalTo(self);
            make.height.equalTo(10 * AutoSizeScaleY);
        }];
        [self.phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.line2.mas_bottom);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.width.equalTo(Z_SCREEN_WIDTH - 30 * AutoSizeScaleX);
            make.height.equalTo(53 * AutoSizeScaleY);
        }];
        [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.phoneTf.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(1);
        }];
        
        [self.uploadLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.line3.mas_bottom).offset(17 * AutoSizeScaleY);
            make.left.equalTo(15 * AutoSizeScaleX);
            make.height.equalTo(15 * AutoSizeScaleY);
        }];
        
    }
    return self;
}

- (UILabel *)titleLb{
    
    if (!_titleLb) {
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.text = @"您的问题或建议：";
        _titleLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _titleLb.font = [UIFont systemFontOfSize:15.f];
        _titleLb.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLb;
}

- (UITextView *)opinionTv{
    
    if (!_opinionTv) {
        
        _opinionTv = [[UITextView alloc] init];
        _opinionTv.font = [UIFont systemFontOfSize:13.f];
        _opinionTv.placeholder = @"请简要描述你在使用产品过程中的问题和意见";
        _opinionTv.placeholdColor = [UIColor getUsualColorWithString:@"#D2D2D2"];
        _opinionTv.placeholdFont = [UIFont systemFontOfSize:14.f];
        _opinionTv.limitLength = @200;
        _opinionTv.limitPlaceColor = [UIColor whiteColor];
        _opinionTv.backgroundColor = [UIColor whiteColor];
        _opinionTv.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _opinionTv.delegate = self;
        ZViewBorderRadius(_opinionTv, 1, 1, [UIColor getUsualColorWithString:@"#D2D2D2"]);
    }
    return _opinionTv;
}
- (UITextField *)phoneTf{
    
    if (!_phoneTf) {
        
        UILabel * leftLb = [[UILabel alloc] init];
        leftLb.text = @"联系电话";
        leftLb.font = [UIFont systemFontOfSize:16.f];
        leftLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        leftLb.frame = CGRectMake(0, 0, 90 * AutoSizeScaleX, 53 * AutoSizeScaleY);
        _phoneTf = [[UITextField alloc] init];
        _phoneTf.backgroundColor = [UIColor whiteColor];
        _phoneTf.placeholder = @"选填，便于我们联系您";
        _phoneTf.font = [UIFont systemFontOfSize:16.f];
        [_phoneTf setValue:[UIColor getUsualColorWithString:@"#E0E0E0"] forKeyPath:@"placeholderLabel.textColor"];
        _phoneTf.leftView = leftLb;
        _phoneTf.leftViewMode = UITextFieldViewModeAlways;
        _phoneTf.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTf.delegate = self;
        [_phoneTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTf;
}

- (UILabel *)uploadLb{
    
    if (!_uploadLb) {
        
        _uploadLb = [[UILabel alloc] init];
        _uploadLb.text = @"上传照片：";
        _uploadLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
        _uploadLb.font = [UIFont systemFontOfSize:15.f];
        _uploadLb.textAlignment = NSTextAlignmentLeft;
        
    }
    return _uploadLb;
}

- (UIView *)line1{
    
    if (!_line1) {
        
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor getUsualColorWithString:@"#F0F0F0"];
    }
    return _line1;
}
- (UIView *)line2{
    
    if (!_line2) {
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor getUsualColorWithString:@"#F0F0F0"];
    }
    return _line2;
}
- (UIView *)line3{
    
    if (!_line3) {
        
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = [UIColor getUsualColorWithString:@"#F0F0F0"];
    }
    return _line3;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (self.opinionTvBlock) {
        
        self.opinionTvBlock(textView);
    }
}

#pragma mark ======  textFieldDelegate  ======

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //    if (textField.tag == 0) {
    //
            if (textField.text.length > 10 && ![string isEqualToString:@""]){
                return NO;
            }
    //    }
    //    if (textField.tag == 1) {
    //
    //        if (textField.text.length > 5 && ![string isEqualToString:@""]){
    //            return NO;
    //        }
    //    }
    if ([NSString isNineKeyBoard:string] ){
        
        return YES;
    }else{
        
        if ([NSString stringContainsEmoji:string]) {
            
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    return YES;
}
-(void)textFieldDidChange:(UITextField *)tf{
    
    if (self.phoneBlock) {
        
        self.phoneBlock(tf);
    }
    
}

@end
