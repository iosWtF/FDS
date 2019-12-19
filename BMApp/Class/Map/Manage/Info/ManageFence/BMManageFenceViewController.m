//
//  BMManageFenceViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMManageFenceViewController.h"

#import "BMManageFenceHeaderCollectionReusableView.h"
#import "BMManageFenceCollectionViewCell.h"
#import "BMAddFenceViewController.h"
#import "BMFenceInfoViewController.h"

#import "BMFenceModel.h"
@interface BMManageFenceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) NSMutableArray *sourceArr;
@end

@implementation BMManageFenceViewController

-(void)dealloc{
    
    [Z_NotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"围栏管理";
    [Z_NotificationCenter addObserver:self selector:@selector(configData) name:@"fenceChange" object:nil];
    self.sourceArr = [[NSMutableArray alloc] init];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self configCollectionView];
    [self configData];
}
- (void)configData{
    
    [[BMHttpsMethod httpMethodManager] fenceGetFenceListWithClusterId:self.cluModel.Id ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            self.sourceArr = [BMFenceModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
        [self.collectionView reloadData];

    }];
}



- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _collectionView.scrollEnabled = YES;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[BMManageFenceCollectionViewCell class] forCellWithReuseIdentifier:@"BMManageFenceCollectionViewCellID"];
    [_collectionView registerClass:[BMManageFenceHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _layout.itemSize = CGSizeMake(88 * AutoSizeScaleX, 115 * AutoSizeScaleX);
    _layout.minimumInteritemSpacing = 12 * AutoSizeScaleX;
    _layout.minimumLineSpacing = 15 * AutoSizeScaleY;
    _layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 13);
    [self.collectionView setCollectionViewLayout:_layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(SafeAreaTopHeight-1);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(- SafeAreaBottomHeight);
    }];
    UIImageView *backImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, Z_SCREEN_WIDTH, Z_SCREENH_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight)];
    [backImageView setImage:[UIImage imageNamed:@"zuji_bg_dis"]];
    self.collectionView.backgroundView=backImageView;
}
#pragma mark UICollectionView

#pragma mark - 在布局对象的代理协议方法中设置header的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(Z_SCREEN_WIDTH, 215 * AutoSizeScaleY);
}
#pragma mark - 返回header对象 UICollectionViewDataSource的协议方法(也可以用来返回footer对象)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        BMManageFenceHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        ZWeakSelf(self);
        
        return header;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
        
        
        
        return nil;
        
    }
    return nil;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (!self.isOwner) {
        
        return self.sourceArr.count;
    }
    
    return self.sourceArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BMManageFenceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMManageFenceCollectionViewCellID" forIndexPath:indexPath];
    if (indexPath.item == self.sourceArr.count) {
        
        [cell.imgView setImage:[UIImage imageNamed:@"guanli_btn_tianjia"]];
        cell.nameLb.text = @"添加围栏";
        
    } else {
        
        BMFenceModel * model = self.sourceArr[indexPath.row];
        cell.model = model;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.sourceArr.count) {
        
        //添加围栏
        if (self.sourceArr.count == 10) {
            
            [self showHint:@"围栏数量已满，无法添加"];
            return;
        }
        
        BMAddFenceViewController * add = [[BMAddFenceViewController alloc] init];
        add.cluModel = self.cluModel;
        [self.navigationController pushViewController:add animated:YES];
        
    }else{
        
        //围栏信息
        BMFenceModel * fence = self.sourceArr[indexPath.row];
        BMFenceInfoViewController * info = [[BMFenceInfoViewController alloc] init];
        info.fenceModel = fence;
        info.isOwner = self.isOwner;
        [self.navigationController pushViewController:info animated:YES];
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
