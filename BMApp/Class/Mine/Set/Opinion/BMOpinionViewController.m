//
//  BMOpinionViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMOpinionViewController.h"

#import "BMOpinionHeaderCollectionReusableView.h"
#import "LxGridViewFlowLayout.h"
#import "BMOpinionCollectionViewCell.h"
#import "UIView+Layout.h"

@interface BMOpinionViewController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITextViewDelegate> {
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
}

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) LxGridViewFlowLayout *layout;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, copy) NSString *opinion;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *picUrls;
@end

@implementation BMOpinionViewController
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F0F0F0"];
    self.customNavBar.title = @"反馈与意见";
    
    self.opinion = @"";
    self.tel = @"";
    self.picUrls = @"";
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self configCollectionView];
    
}
#pragma mark ======  提交  ======

- (void)upload{
    
    if (self.opinion.length == 0) {
        
        [self showHint:@"请输入您的意见"];
        return;
    }
    if (self.opinion.length < 15) {
        
        [self showHint:@"意见内容应不少于15字"];
        return;
    }
    if (self.tel.length != 0) {
        
        if (![NSString checkPhone:self.tel]) {
            
            [self showHint:@"手机号不正确"];
            return;
        }
    }
    if (_selectedPhotos.count == 0) {
        
        [self submit];
    }else{
        
        [[BMHttpsMethod httpMethodManager] fileUploadFilesWithImgArr:_selectedPhotos ToGetResult:^(id  _Nonnull data) {
           
            if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                
                self.picUrls = data[@"data"];
                [self submit];
            }else{
                
                [self showHint:data[@"errorMsg"]];
            }
        }];
    }

}
- (void)submit{
    
    [[BMHttpsMethod httpMethodManager] feedbackSaveWithUserId:UserID Content:self.opinion PhoneNo:self.tel PicUrls:self.picUrls ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self showHint:@"反馈成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}

- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    _layout = [[LxGridViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _collectionView.scrollEnabled = NO;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[BMOpinionCollectionViewCell class] forCellWithReuseIdentifier:@"BMOpinionCollectionViewCell"];
    [_collectionView registerClass:[BMOpinionHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _layout.itemSize = CGSizeMake(Z_SCREEN_WIDTH / 3, Z_SCREEN_WIDTH / 3);
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = 15 * AutoSizeScaleY;
    _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.collectionView setCollectionViewLayout:_layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(300 * AutoSizeScaleY + Z_SCREEN_WIDTH / 3);
    }];
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
    [submitBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
    ZViewBorderRadius(submitBtn, 5, 0, [UIColor whiteColor]);
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(- SafeAreaBottomHeight - 10 * AutoSizeScaleY);
        make.left.equalTo(28* AutoSizeScaleX);
        make.right.equalTo(-28* AutoSizeScaleX);
        make.height.equalTo(45* AutoSizeScaleY);
    }];
}
#pragma mark UICollectionView

#pragma mark - 在布局对象的代理协议方法中设置header的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(Z_SCREEN_WIDTH, 300 * AutoSizeScaleY);
}
#pragma mark - 返回header对象 UICollectionViewDataSource的协议方法(也可以用来返回footer对象)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        BMOpinionHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        ZWeakSelf(self);
        header.opinionTvBlock = ^(UITextView * _Nonnull tv) {
          
            weakself.opinion = tv.text;
        };
        header.phoneBlock = ^(UITextField * _Nonnull tf) {
          
            weakself.tel = tf.text;
        };
        return header;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
        
        
        
        return nil;
        
    }
    return nil;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BMOpinionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMOpinionCollectionViewCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.item == _selectedPhotos.count) {
        cell.imageView.image = [UIImage  imageNamed:@"yijian_shangchuan"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == _selectedPhotos.count) {
        
        [BMBottomPopView showMoreWithTitle:@[@"拍照",@"相册",@"取消"] imgNameArray:@[] itemHeight:50 * AutoSizeScaleX fontS:14.f showCornerRadius:NO blockTapAction:^(NSInteger index){
            
            if (index == 0) {
                
                [self takePhoto];
            }else if (index == 1){
                
                [self pushTZImagePickerController];
            }
            
        }];
        return;
        BMOpinionCollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"添加照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        actionSheet.popoverPresentationController.sourceView = self.view;
        actionSheet.popoverPresentationController.sourceRect =
        cell.bounds;
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self takePhoto];
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushTZImagePickerController];
            
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        //把action添加到actionSheet里
        [actionSheet addAction:action1];
        [actionSheet addAction:action2];
        [actionSheet addAction:action3];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
    
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    //    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [_collectionView reloadData];
    [self updateCollectionViewConstraints];
}

#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:0 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.selectedAssets = _selectedAssets;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        
        //[mediaTypes addObject:(NSString *)kUTTypeMovie];
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate =YES;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                
                if (1) { // bu允许裁剪,去裁剪
                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    
                } else{
                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                        [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                    }];
                    imagePicker.allowPickingImage = YES;
                    imagePicker.needCircleCrop = YES;
                    imagePicker.circleCropRadius = 100;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
    [self updateCollectionViewConstraints];
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    [self updateCollectionViewConstraints];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
    
    // 3. 获取原图的示例，用队列限制最大并发为1，避免内存暴增
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 1;
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        // 图片上传operation，上传代码请写到operation内的start方法里，内有注释
        //        TZImageUploadOperation *operation = [[TZImageUploadOperation alloc] initWithAsset:asset completion:^(UIImage * photo, NSDictionary *info, BOOL isDegraded) {
        //            if (isDegraded) return;
        //            NSLog(@"图片获取&上传完成");
        //        } progressHandler:^(double progress, NSError * _Nonnull error, BOOL * _Nonnull stop, NSDictionary * _Nonnull info) {
        //            NSLog(@"获取原图进度 %f", progress);
        //        }];
        //        [self.operationQueue addOperation:operation];
    }
}

// If user picking a video and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    
    [_collectionView reloadData];
    [self updateCollectionViewConstraints];
}

// Decide album show or not't
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    /*
     if ([albumName isEqualToString:@"个人收藏"]) {
     return NO;
     }
     if ([albumName isEqualToString:@"视频"]) {
     return NO;
     }*/
    return YES;
}

// Decide asset show or not't
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    
    
    return YES;
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        [_selectedAssets removeObjectAtIndex:sender.tag];
        [self.collectionView reloadData];
        
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_collectionView reloadData];
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(void)updateCollectionViewConstraints{
    
    CGFloat i = (CGFloat)(_selectedPhotos.count + 1) / 4;
    int row =  (int)ceilf(i);
    if (row > 1) {
        
        row = 1;
    }
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(300 * AutoSizeScaleY + Z_SCREEN_WIDTH / 3);
    }];
}
#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
        // NSLog(@"图片名字:%@",fileName);
    }
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
