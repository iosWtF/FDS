//
//  BMChangeDeviceInfoViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/12.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMChangeDeviceInfoViewController.h"

#import "BMEditDeviceTableViewCell.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"
@interface BMChangeDeviceInfoViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,STPickerSingleDelegate,STPickerDateDelegate>

@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)UIButton * submitBtn;
@property(nonatomic ,strong)UIButton * deleteBtn;
@property(nonatomic ,strong)UIImageView * icon;
@property(nonatomic ,strong)UIImage * iconImg;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) STPickerSingle *pickerSingle;
@property (nonatomic, strong) STPickerDate *datePicker;
@property (nonatomic, strong) BMDeviceModel *infoModel;
@end

static NSString * const BMEditDeviceTableViewCellID = @"BMEditDeviceTableViewCellID";

@implementation BMChangeDeviceInfoViewController
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
- (STPickerSingle *)pickerSingle{
    
    if (!_pickerSingle) {
        
        NSArray * arrayData = @[@"学前班",@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级",@"初中",@"高中",@"其他"];
        STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
        pickerSingle.widthPickerComponent = Z_SCREEN_WIDTH;
        [pickerSingle setArrayData:[NSMutableArray arrayWithArray:arrayData]];
        [pickerSingle setTitle:@"请选择学习阶段"];
        //        [pickerSingle setTitleUnit:@"人民币"];
        [pickerSingle setContentMode:STPickerContentModeBottom];
        [pickerSingle setDelegate:self];
        [pickerSingle.buttonLeft setTitle:@"取消" forState:UIControlStateNormal];
        [pickerSingle.buttonRight setTitle:@"完成" forState:UIControlStateNormal];
        pickerSingle.borderButtonColor = [UIColor whiteColor];
        _pickerSingle = pickerSingle;
    }
    return _pickerSingle;
}
- (STPickerDate *)datePicker{
    
    if (!_datePicker) {
        
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setYearLeast:2000];
        [pickerDate setYearSum:50];
        [pickerDate.buttonLeft setTitle:@"取消" forState:UIControlStateNormal];
        [pickerDate.buttonRight setTitle:@"完成" forState:UIControlStateNormal];
        pickerDate.borderButtonColor = [UIColor whiteColor];
        [pickerDate setDelegate:self];
        _datePicker = pickerDate;
    }
    return _datePicker;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor getUsualColorWithString:@"#F5F6FA"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BMEditDeviceTableViewCell class] forCellReuseIdentifier:BMEditDeviceTableViewCellID];
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        //        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _tableView;
}
- (UIButton *)submitBtn{
    
    if (!_submitBtn) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#4285F4"]];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        ZViewBorderRadius(_submitBtn, 5, 0, [UIColor whiteColor]);
    }
    return _submitBtn;
}
- (UIButton *)deleteBtn{
    
    if (!_deleteBtn) {
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除设备" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor getUsualColorWithString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_deleteBtn setBackgroundColor:[UIColor getUsualColorWithString:@"#B7B7B7"]];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        ZViewBorderRadius(_deleteBtn, 5, 0, [UIColor whiteColor]);
    }
    return _deleteBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"设备信息";
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
        make.bottom.equalTo(- SafeAreaBottomHeight - 140 * AutoSizeScaleY);
    }];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(320 * AutoSizeScaleX, 44 * AutoSizeScaleY));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight - 40 * AutoSizeScaleY);
    }];
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(CGSizeMake(320 * AutoSizeScaleX, 44 * AutoSizeScaleY));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(- 10 * AutoSizeScaleY);
    }];
    [self configData];
}
- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] deviceGetWithId:self.device.Id ToGetResult:^(id  _Nonnull data) {
        
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.infoModel = [BMDeviceModel mj_objectWithKeyValues:data[@"data"]];
            [self.tableView reloadData];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}
#pragma mark ******tableViewDelegate&Datasource******

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 55 * AutoSizeScaleY;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = @[@"设备头像点击更换/上传",@"设备名称",@"儿童生日",@"儿童学习阶段",@"设备校检码"];
    NSArray * imgArr = @[@"xinxi_icon_touxiag",@"tianjia_icon_shebei",@"tianjia_icon_shengri",@"xinxi_icon_xuexi",@"xinxi_icon_shouji"];
    NSArray * placeHolderArr = @[@"",@"请输入设备名称",@"请选择儿童生日日期",@"请选择儿童所在学习阶段",@"请输入设备校检码"];
    NSArray * arrayData = @[@"学前班",@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级",@"初中",@"高中",@"其他"];
    BMEditDeviceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BMEditDeviceTableViewCellID forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BMEditDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BMEditDeviceTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        self.icon = cell.iconImgView;
    }
    cell.title = titleArr[indexPath.row];
    cell.img = imgArr[indexPath.row];
    cell.placeHolder = placeHolderArr[indexPath.row];
    ZWeakSelf(self);
    
    cell.canEdit = NO;
    if (indexPath.row == 1) {
        
        cell.canEdit = YES;
    }
    
    cell.editBlock = ^(UITextField * _Nonnull tf) {
        
        self.infoModel.name = tf.text;
        
    };
    if (indexPath.row == 2 || indexPath.row == 3) {
        
        if (indexPath.row == 2) {
            
            cell.chooseBlock = ^(UITextField * _Nonnull tf) {
                
                [weakself.datePicker show];
            };
        }else if (indexPath.row == 3) {
            
            cell.chooseBlock = ^(UITextField * _Nonnull tf) {
                
                [weakself.pickerSingle show];
                
            };
        }
    }
    if (indexPath.row == 0) {
        
        cell.iconImgView.hidden = NO;
        if (self.infoModel) {
            
            if (!self.iconImg) {
                
                [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.infoModel.picUrl]] placeholderImage:nil];
            }
            
        }
    }
    if (self.infoModel) {
        
        NSArray * contentArr = @[@"",self.infoModel.name,self.infoModel.birthday,arrayData[[self.infoModel.childrenType integerValue]],self.infoModel.imei];
        cell.content = contentArr[indexPath.row];
    }

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        //更改头像
        [self chooseIcon];
        
    }
}
#pragma mark ======  STPickerDelegate  ======
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    //    NSString *text = [NSString stringWithFormat:@"%@ 人民币", selectedTitle];
    //    self.textSingle.text = text;
    NSArray * arrayData = @[@"学前班",@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级",@"初中",@"高中",@"其他"];
    self.infoModel.childrenType = [NSString stringWithFormat:@"%lu",(unsigned long)[arrayData indexOfObject:selectedTitle]];
    [self.tableView reloadData];
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%zd-%zd-%zd", year, month, day];
    self.infoModel.birthday = text;
    [self.tableView reloadData];
}


#pragma mark ======  选择头像  ======
- (void)chooseIcon{
    
    [BMBottomPopView showMoreWithTitle:@[@"拍照",@"相册",@"取消"] imgNameArray:@[] itemHeight:50 * AutoSizeScaleX fontS:15.f showCornerRadius:NO blockTapAction:^(NSInteger index) {
        
        if (index == 0) {
            
            [self takePhoto];
        }else if (index == 1){
            
            [self pushTZImagePickerController];
        }else if (index == 2){
            
            
        }
    }];
    return;
    
    
    BMEditDeviceTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
#pragma mark ======  上传图片  ======
- (void)upLoadImage{
    
    if (!self.iconImg) {
        
        [self keepInfo];
        return;
    }
    [[BMHttpsMethod httpMethodManager] fileUploadFileWithImgArr:@[self.iconImg] ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.infoModel.picUrl = data[@"data"][@"path"];
            [self keepInfo];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}
#pragma mark ======  保存  ======
- (void)submit{
    
    [self upLoadImage];
    
}
#pragma mark ======  删除  ======
- (void)delete{
    
    [[BMHttpsMethod httpMethodManager] deviceDeleteWithId:self.device.Id ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self showHint:@"保存成功"];
            [Z_NotificationCenter postNotificationName:@"deviceChange" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}

- (void)keepInfo{
    
    if (self.infoModel.name.length == 0) {
        
        [self showHint:@"请输入设备名称"];
        return;
    }
    
    [[BMHttpsMethod httpMethodManager] deviceUpdateWithId:self.device.Id Name:self.infoModel.name Birthday:self.infoModel.birthday ChildrenType:self.infoModel.childrenType PicUrl:self.infoModel.picUrl ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [Z_NotificationCenter postNotificationName:@"deviceChange" object:nil];
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
