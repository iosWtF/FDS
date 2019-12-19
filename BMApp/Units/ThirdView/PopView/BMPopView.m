//
//  BMDeleteAddressPopView.m
//  BMApp
//
//  Created by Mac on 2019/6/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMPopView.h"

@interface BMPopView()

@property(nonatomic ,strong)UIView * contentView;

@property(nonatomic ,strong)UILabel * contentLb;
@property (nonatomic, copy) void (^blockTapAction)(NSInteger index);
@property(nonatomic ,strong)UIButton * leftBtn;
@property(nonatomic ,strong)UIButton * rightBtn;

@property(nonatomic ,copy)NSString * title;

@end

@implementation BMPopView
+ (void)showWithContent:(NSString *)content blockTapAction:(void(^)(NSInteger index))blockTapAction{
    BMPopView *modeView = [[BMPopView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT)];
    modeView.blockTapAction = blockTapAction;
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    modeView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:modeView];
    // 创建内容
    modeView.title = content;
    [modeView bulidContentView];
    [modeView show];
    //    [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
    
}

- (void)bulidContentView{
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(38 * AutoSizeScaleX, Z_SCREENH_HEIGHT, Z_SCREEN_WIDTH - 76 * AutoSizeScaleX, 167 * AutoSizeScaleY)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    ZViewBorderRadius(self.contentView, 6, 0, [UIColor whiteColor]);
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    [self bulidContent];
    [self bulidBtn];
}

-(void)bulidContent{
    
    self.contentLb = [UILabel new];
    self.contentLb.text = self.title;
    self.contentLb.textColor = [UIColor getUsualColorWithString:@"#333333"];
    self.contentLb.font = [UIFont systemFontOfSize:18.f];
    self.contentLb.textAlignment = NSTextAlignmentCenter;
    self.contentLb.numberOfLines = 0;
    [self.contentView addSubview:self.contentLb];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).offset(41 * AutoSizeScaleY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10 * AutoSizeScaleX);
        make.right.mas_equalTo(self.contentView.mas_right).offset(- 10 * AutoSizeScaleX);
    }];
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#E9E9E9"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(- 44 * AutoSizeScaleY);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(1);
    }];
    
}
- (void)bulidBtn{
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor getUsualColorWithString:@"#333333"] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [self.leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    ZViewBorderRadius(self.leftBtn, 2, 0, [UIColor getUsualColorWithString:@"#07BFD9"]);
    [self.contentView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width / 2, 44 * AutoSizeScaleY));
        make.left.mas_equalTo(self.contentView);
    }];
    
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFEFE"] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    ZViewBorderRadius(self.rightBtn, 2, 0, [UIColor getUsualColorWithString:@"#07BFD9"]);
    [self.contentView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.leftBtn);
        make.size.mas_equalTo(self.leftBtn);
        make.right.mas_equalTo(self.contentView);
    }];
    
}

- (void)leftBtnClick:(UIButton *)submitBtn{
    
    [self dismiss];
    
    
}

- (void)rightBtnClick:(UIButton *)submitBtn{
    
    [self dismiss];
    if (self.blockTapAction) {
        
        self.blockTapAction(1);
    }
    
}
- (void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeTranslation(0,- Z_SCREENH_HEIGHT / 2 - 83 * AutoSizeScaleX);
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
