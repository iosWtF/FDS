//
//  BMChangeGroupNameViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/11.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMChangeGroupNameViewController.h"

@interface BMChangeGroupNameViewController ()<UITextFieldDelegate>

@property(nonatomic ,strong)UITextField * nameTf;

@end

@implementation BMChangeGroupNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor  getUsualColorWithString:@"#F5F6FA"];
    self.customNavBar.title = @"修改群名称";
    [self.customNavBar wr_setRightButtonWithTitle:@"保存" titleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    self.customNavBar.rightButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    ZWeakSelf(self);
    self.customNavBar.onClickRightButton = ^{
      
        ZStrongSelf(self);
        [self keep];
        
    };
    UILabel * titleLb = [[UILabel alloc] init];
    titleLb.textColor = [UIColor getUsualColorWithString:@"#666666"];
    titleLb.font = [UIFont systemFontOfSize:14.f];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.text = @"群聊名称";
    [self.view addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(15 * AutoSizeScaleY);
        make.top.equalTo(SafeAreaTopHeight);
        make.height.equalTo(40 * AutoSizeScaleY);
    }];
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * AutoSizeScaleX, 55 * AutoSizeScaleY)];
    leftView.backgroundColor = [UIColor whiteColor];
    UITextField *nameTf = [[UITextField alloc] init];
    nameTf.text = self.model.name;
    nameTf.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    nameTf.placeholder = @"请输入群名称";
    nameTf.font = [UIFont systemFontOfSize:14.f];
    [nameTf setValue:[UIColor getUsualColorWithString:@"#C4C4C4"] forKeyPath:@"placeholderLabel.textColor"];
    nameTf.leftView = leftView;
    nameTf.leftViewMode = UITextFieldViewModeAlways;
    UIButton *button = [nameTf valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"mingcheng_icon_guanbi"] forState:UIControlStateNormal];
//    nameTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nameTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    nameTf.delegate = self;
    [self.view addSubview:nameTf];
    [nameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLb.mas_bottom);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(Z_SCREEN_WIDTH, 55 * AutoSizeScaleY));
        
    }];
    self.nameTf = nameTf;
}

#pragma mark ======  保存  ======

- (void)keep{
    
    [[BMHttpsMethod httpMethodManager] clusterUpdateWithId:self.model.Id Name:self.nameTf.text ToGetResult:^(id  _Nonnull data) {
       
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [self showHint:@"修改成功"];
            [Z_NotificationCenter postNotificationName:@"changeGroupInfo" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [self showHint:data[@"errorMsg"]];
        }
    }];
    
}

#pragma mark ======  textFieldDelegate  ======

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([NSString isNineKeyBoard:string] ){
        
        return YES;
    }else{
        
        if ([NSString stringContainsEmoji:string]) {
            
            return NO;
        }
    }
    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField{
    
    NSUInteger maxLength = 10;
    // text field 的内容
    NSString *contentText = textField.text;
    // 获取高亮内容的范围
    UITextRange *selectedRange = [textField markedTextRange];
    // 这行代码 可以认为是 获取高亮内容的长度
    NSInteger markedTextLength = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
    // 没有高亮内容时,对已输入的文字进行操作
    if (markedTextLength == 0) {
        // 如果 text field 的内容长度大于我们限制的内容长度
        if (contentText.length > maxLength) {
            
            NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
            textField.text = [contentText substringWithRange:rangeRange];
        }
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
