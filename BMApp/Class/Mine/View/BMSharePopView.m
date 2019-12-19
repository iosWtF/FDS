//
//  BMSharePopView.m
//  BMApp
//
//  Created by Mac on 2019/9/16.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMSharePopView.h"

@interface BMSharePopView()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imgNameArray;
@property (nonatomic ,strong)NSMutableArray * buttonArray;
@property (nonatomic, copy) void (^blockTapAction)(NSInteger index);
@property (nonatomic, strong) UIView *contentView;

@end

@implementation BMSharePopView

+ (void)showMoreWithTitle:(NSArray *)titleArray
             imgNameArray:(NSArray *)imgNameArray
           blockTapAction:( void(^)(NSInteger index) )blockTapAction{
    //    if (titleArray.count != imgNameArray.count || !titleArray.count) {
    //        return;
    //    }
    if (!titleArray.count) {
        return;
    }
    BMSharePopView *modeView = [[BMSharePopView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaBottomHeight)];
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
//    modeView.alpha = 0;
    modeView.titleArray = titleArray;
    modeView.imgNameArray = imgNameArray;
    modeView.blockTapAction = blockTapAction;
    [[UIApplication sharedApplication].keyWindow addSubview:modeView];
    
    // 创建内容
    [modeView bulidContentView];
    [modeView show];
    [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
}

- (void)bulidContentView{
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Z_SCREENH_HEIGHT, Z_SCREEN_WIDTH, 170 * AutoSizeScaleY)];
    self.contentView.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    [self addSubview:self.contentView];
    [self bulidContent];
    [self bulidCancle];
}

- (void)bulidContent{
    
    self.buttonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        button.frame = CGRectMake(Z_SCREEN_WIDTH / 4 * i, 0, Z_SCREEN_WIDTH/ 4, 110 * AutoSizeScaleY);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor getUsualColorWithString:@"#828282"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.imgNameArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        [button setImagePositionWithType:SSImagePositionTypeTop spacing:10];
        // button标题/图片的偏移量
        //        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.bounds.size.height + kw(10), -button.imageView.bounds.size.width, 0,0);
        //        button.imageEdgeInsets = UIEdgeInsetsMake(kw(5), button.titleLabel.bounds.size.width/2, button.titleLabel.bounds.size.height + kw(5), -button.titleLabel.bounds.size.width/2);
        [self.buttonArray addObject:button];
        button.alpha = 0;
        button.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showButton];
    });
}

- (void)showButton{
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        UIButton *button = self.buttonArray[i];
        
        [UIView animateWithDuration:0.7 delay:i*0.05 - i/4*0.2 usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            button.alpha = 1;
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

// 取消按钮
- (void)bulidCancle{
    
        UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleButton.frame = CGRectMake(15, 110 * AutoSizeScaleY, self.contentView.bounds.size.width - 30, 45 * AutoSizeScaleY);
        cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancleButton setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
        [cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [cancleButton setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
        ZViewBorderRadius(cancleButton, 5, 0, [UIColor whiteColor]);
//        CALayer *layer = [CALayer layer];
//        layer.frame = CGRectMake(0, 0, cancleButton.bounds.size.width, 1);
//        layer.backgroundColor = [UIColor getUsualColorWithString:@"#336FF0"].CGColor;
//        [cancleButton.layer addSublayer:layer];
    
        [self.contentView addSubview:cancleButton];
}

- (void)addLineWithFrame:(CGRect)frame color:(UIColor *)color{
    
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -170 * AutoSizeScaleY - SafeAreaBottomHeight);
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

- (void)tapAction:(UIButton *)button{
    
    [self dismiss];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.blockTapAction) {
            self.blockTapAction(button.tag);
        }
    });
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


