//
//  BMFootPrintAnnotationView.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMFootPrintAnnotationView.h"

@interface BMFootPrintAnnotationView ()

@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation BMFootPrintAnnotationView

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 44 * AutoSizeScaleX, 72 * AutoSizeScaleX);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(17.5* AutoSizeScaleX, 31.5* AutoSizeScaleX, 9 * AutoSizeScaleX, 9 * AutoSizeScaleX)];
        [self.bgImgView setImage:[UIImage imageNamed:@"guiji_icon_bai"]];
        [self addSubview:self.bgImgView];
        self.frontImgView = [[UIImageView alloc] initWithFrame:CGRectMake(6 * AutoSizeScaleX, 20* AutoSizeScaleX, 32 * AutoSizeScaleX, 32 * AutoSizeScaleX)];
        [self addSubview:self.frontImgView];
        
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
