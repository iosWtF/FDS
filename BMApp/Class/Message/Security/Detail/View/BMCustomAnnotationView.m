//
//  BMCustomAnnotationView.m
//  BMApp
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMCustomAnnotationView.h"

@interface BMCustomAnnotationView ()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIImageView *iconImgView;

@end

@implementation BMCustomAnnotationView

- (void)setMsg:(BMSecurityMsgDetailModel *)msg{
 
    _msg = msg;
    [self.bgImgView setImage:[UIImage imageNamed:@"home_icon_shebi"]];
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",msg.devicePic]] placeholderImage:nil];
}

- (void)setDevice:(BMDeviceModel *)device{
 
    _device = device;
    if ([device.name isEqualToString:@"我的位置"]) {
        
        [self.bgImgView setImage:[UIImage imageNamed:@"home_icon_ren"]];
    }else{
     
        [self.bgImgView setImage:[UIImage imageNamed:@"home_icon_shebi"]];
    }
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",device.picUrl]] placeholderImage:nil];
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 63 * AutoSizeScaleX, 80 * AutoSizeScaleX);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self addSubview:self.bgImgView];
        
        self.iconImgView = [[UIImageView alloc] init];
//        self.iconImgView.backgroundColor = [UIColor redColor];
        self.iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImgView.clipsToBounds = YES;
        ZViewBorderRadius(self.iconImgView, 37 * AutoSizeScaleX / 2, 0, [UIColor whiteColor]);
        [self addSubview:self.iconImgView];

        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self);
            make.top.equalTo(12 * AutoSizeScaleX);
            make.size.equalTo(CGSizeMake(37 * AutoSizeScaleX, 37 * AutoSizeScaleX));
        }];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
