//
//  BMGroupCodeViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMGroupCodeViewController.h"
#import <CoreImage/CoreImage.h>
@interface BMGroupCodeViewController ()

@property(nonatomic ,strong)UIImage * img;

@end

@implementation BMGroupCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"群组二维码";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"ma_btn_dian"]];
    ZWeakSelf(self);
    self.customNavBar.onClickRightButton = ^{
        ZStrongSelf(self);
        
        [self showSheet];
        
    };
    
    self.img = [self generateQRCodeWithString:[NSString stringWithFormat:@"qz:%@",self.model.Id] Size:193 * AutoSizeScaleX];
    
    UIImageView * bgImgView = [[UIImageView alloc] init];
    [bgImgView setImage:[UIImage imageNamed:@"erwrima_bg"]];
    [self.view addSubview:bgImgView];
    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight + 50 * AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(246 * AutoSizeScaleX, 243 * AutoSizeScaleX));
    }];
    
    
    UIImageView * codeImgView = [[UIImageView alloc] init];
    codeImgView.contentMode = UIViewContentModeScaleAspectFill;
    codeImgView.clipsToBounds = YES;
    [codeImgView setImage:self.img];
//    [codeImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.qrcodeUrl]]];
    [self.view addSubview:codeImgView];
    [codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(bgImgView);
        make.size.equalTo(CGSizeMake(193 * AutoSizeScaleX, 194 * AutoSizeScaleX));
    }];
    
    UILabel * nameLb = [[UILabel alloc] init];
    nameLb.text = self.model.name;
    nameLb.textColor = [UIColor getUsualColorWithString:@"#121212"];
    nameLb.textAlignment = NSTextAlignmentLeft;
    nameLb.font = [UIFont systemFontOfSize:17.f];
    [self.view addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.height.equalTo(16 * AutoSizeScaleY);
        make.top.equalTo(bgImgView.mas_bottom).offset(13 * AutoSizeScaleY);
    }];
}

//生成二维码
- (UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size
{
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据<字符串长度893>
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKey:@"inputMessage"];
    //获取二维码过滤器生成二维码
    CIImage *image = [filter outputImage];
    UIImage *img = [self createNonInterpolatedUIImageFromCIImage:image WithSize:size];
    return img;
}
//二维码清晰
- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image WithSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //创建bitmap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
- (void)showSheet{
 
    
    [BMBottomPopView showMoreWithTitle:@[@"保存图片",@"取消"] imgNameArray:@[] itemHeight:50 * AutoSizeScaleX fontS:14.f showCornerRadius:NO blockTapAction:^(NSInteger index) {
        
        if (index == 0) {
            
//            if (self.model.qrcodeUrl.length == 0 || [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.qrcodeUrl]]] == nil) {
//
//                [self showHint:@"二维码不存在"];
//                return;
//            }
            
            if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                [alert addAction:action1];
                [alert addAction:action2];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
                
            } else {
                [self keepImg];
            }

        }else{
            
        }
        
    }];
    
    return;
    
}
- (void)keepImg{
 
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //1,保存图片到系统相册
        
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.img];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (!success) return ;
        
        [self showHint:@"保存成功"];
        NSLog(@"保存成功");
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
