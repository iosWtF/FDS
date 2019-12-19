//
//  BMMineInfoViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMineInfoViewController.h"

#import "BMMineInfoTableViewCell.h"
#import "UITextView+YLTextView.h"
#import "BMMineInfoModel.h"
#import "BMBottomPopView.h"
#import "BMMineCodeViewController.h"
@interface BMMineInfoViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITextViewDelegate>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)UIButton * keepBtn;

@property(nonatomic ,strong)BMMineInfoModel * infoModel;
@property(nonatomic ,strong)UIImageView * icon;
@property(nonatomic ,strong)UIImage * iconImg;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UITextView *tv;
@end

static NSString * const BMMineInfoTableViewCellID = @"BMMineInfoTableViewCellID";

@implementation BMMineInfoViewController
#pragma mark ======  lazy  ======


- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
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
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F5F5"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMMineInfoTableViewCell class] forCellReuseIdentifier:BMMineInfoTableViewCellID];
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        //        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _tableView;
}
- (UIButton *)keepBtn{
    
    if (!_keepBtn) {
        
        _keepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_keepBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_keepBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_keepBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
        _keepBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [_keepBtn addTarget:self action:@selector(keep) forControlEvents:UIControlEventTouchUpInside];
        ZViewBorderRadius(_keepBtn, 5, 0, [UIColor whiteColor]);
    }
    return _keepBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"个人信息";
    self.view.backgroundColor = [UIColor getUsualColorWithString:@"#F5F5F5"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 80 * AutoSizeScaleY);
    }];
    [self.view addSubview:self.keepBtn];
    [self.keepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(320 * AutoSizeScaleX, 44 * AutoSizeScaleY));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 36 * AutoSizeScaleY);
    }];
    [self configData];
}
- (void)configData{
    
//    [[BMHttpsMethod httpMethodManager] personDataPageWithUserid:UserID ToGetResult:^(id  _Nonnull data) {
//
//        if ([data[@"code"] isEqualToNumber:@0]) {
//
//            self.infoModel = [BMMineInfoModel mj_objectWithKeyValues:data[@"data"]];
//            [self.tableView reloadData];
//        }
//    }];
    
}


#pragma mark ******tableViewDelegate&Datasource******

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10* AutoSizeScaleY;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 10 * AutoSizeScaleY)];
    line.backgroundColor = [UIColor getUsualColorWithString:@"#F8F8F9"];
    return line;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return 146 * AutoSizeScaleY;
    }
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        
        UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Z_SCREEN_WIDTH, 146 * AutoSizeScaleY)];
        footView.backgroundColor = [UIColor whiteColor];
        UILabel * titleLb = [[UILabel alloc] init];
        titleLb.text = @"简介";
        titleLb.textColor = [UIColor getUsualColorWithString:@"#0C0C0C"];
        titleLb.font = [UIFont systemFontOfSize:15.f];
        titleLb.textAlignment = NSTextAlignmentLeft;
        [footView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(16 * AutoSizeScaleY);
            make.left.equalTo(14 * AutoSizeScaleX);
            make.height.equalTo(14 * AutoSizeScaleY);
        }];
        UITextView * tv = [[UITextView alloc] initWithFrame:CGRectMake(16 * AutoSizeScaleX, 46 * AutoSizeScaleY, Z_SCREEN_WIDTH - 32 * AutoSizeScaleX, 81 * AutoSizeScaleY)];
        tv.font = [UIFont systemFontOfSize:15.f];
        ZViewBorderRadius(tv, 0, 0.5, [UIColor getUsualColorWithString:@"#999999"]);
        tv.delegate = self;
        tv.text = self.user.descriptionn;
        tv.placeholder = @"请输入简介信息";
        tv.limitLength = @50;
        tv.limitPlaceColor = [UIColor whiteColor];
        [footView addSubview:tv];
        self.tv = tv;
        return footView;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 70 * AutoSizeScaleY;
    }
    return 45 * AutoSizeScaleY;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }else if (section == 1){
        
        return 2;
    }else if (section == 2){
        
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@[@"头像"],@[@"昵称",@"性别"],@[@"个人二维码",@"手机号码"]];
    BMMineInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMMineInfoTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMMineInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMMineInfoTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = titleArr[indexPath.section][indexPath.row];
    ZWeakSelf(self);
    if (indexPath.section == 0) {
        
        self.icon = cell.iconImgView;
        
    }
    
    
    cell.canEdit = NO;
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        cell.canEdit = YES;
    }
    
    cell.editBlock = ^(UITextField * _Nonnull tf) {
        
        weakself.user.nickName = tf.text;
    };
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        cell.chooseSexBlock = ^(UITextField * _Nonnull tf) {
            
            //性别
            [self.view endEditing:YES];
            NSArray * titleArr = @[@"男",@"女",@"取消"];
            [BMBottomPopView showMoreWithTitle:titleArr imgNameArray:@[] itemHeight:54 * AutoSizeScaleY fontS:18.f showCornerRadius:NO blockTapAction:^(NSInteger index) {
                
                if (index == 2) {
                    
                    
                }else{
                    
                    tf.text = titleArr[index];
                    if (index == 0) {
                        
                        self.user.gender = @"1";
                    }else{
                        
                        self.user.gender = @"2";
                    }
                }
                
            }];
        };
        
    }
    cell.user = self.user;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        //更改头像
        [self chooseIcon];
        
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            BMMineCodeViewController * code = [[BMMineCodeViewController alloc] init];
            [self.navigationController pushViewController:code animated:YES];
        }
    }
}
#pragma mark ======  选择头像  ======
- (void)chooseIcon{
    
    
    [BMBottomPopView showMoreWithTitle:@[@"拍照",@"相册",@"取消"] imgNameArray:@[] itemHeight:50 * AutoSizeScaleX fontS:14.f showCornerRadius:NO blockTapAction:^(NSInteger index){
        
        if (index == 0) {
            
            [self takePhoto];
        }else if (index == 1){
            
            [self pushTZImagePickerController];
        }
        
    }];
    return;
    BMMineInfoTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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

#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:0 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        
    }];
    //
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
        [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                self.iconImg = image;
                [self.icon setImage:image];
            }
        }];
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
    
    self.iconImg = photos[0];
    [self.icon setImage:photos[0]];
    
}
#pragma mark ======  textViewDelegate  ======

- (void)textViewDidChange:(UITextView *)textView{
    
    self.user.descriptionn = textView.text;
}


#pragma mark ======  上传图片  ======
- (void)upLoadImage{
    
    if (!self.iconImg) {
        
        [self keepInfo];
        return;
    }
    [[BMHttpsMethod httpMethodManager] fileUploadFileWithImgArr:@[self.iconImg] ToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.user.picUrl = data[@"data"][@"path"];
            [self keepInfo];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}
#pragma mark ======  保存  ======
- (void)keep{
    
    [self upLoadImage];
    
}
- (void)keepInfo{
    
    if (self.user.nickName.length == 0) {
        
        [self showHint:@"请输入昵称"];
        return;
    }
    
    [[BMHttpsMethod httpMethodManager] userUpdateWithId:UserID IsPush:self.user.isPush NickName:self.user.nickName PicUrl:self.user.picUrl Gender:self.user.gender Description:self.user.descriptionn ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self showHint:@"保存成功"];
            [Z_NotificationCenter postNotificationName:@"mineChange" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
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
