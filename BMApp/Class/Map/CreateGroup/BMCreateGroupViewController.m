//
//  BMCreateGroupViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMCreateGroupViewController.h"

@interface BMCreateGroupViewController ()<UITextFieldDelegate>

@property(nonatomic ,strong)UITextField * nameTf;

@end

@implementation BMCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"创建群组";
    [self.customNavBar wr_setRightButtonWithTitle:@"确认" titleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
    self.customNavBar.rightButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    ZWeakSelf(self);
    self.customNavBar.onClickRightButton = ^{
      
        [weakself createGroup];
    };
    
    self.view.backgroundColor = [UIColor  getUsualColorWithString:@"#F5F6FA"];
    
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * AutoSizeScaleX, 55 * AutoSizeScaleY)];
    leftView.backgroundColor = [UIColor whiteColor];
    UITextField *nameTf = [[UITextField alloc] init];
    nameTf.backgroundColor = [UIColor getUsualColorWithString:@"#FFFFFF"];
    nameTf.placeholder = @"请输入群名称";
    nameTf.font = [UIFont systemFontOfSize:14.f];
    [nameTf setValue:[UIColor getUsualColorWithString:@"#C4C4C4"] forKeyPath:@"placeholderLabel.textColor"];
    nameTf.leftView = leftView;
    nameTf.leftViewMode = UITextFieldViewModeAlways;
    [nameTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    nameTf.delegate = self;
    [self.view addSubview:nameTf];
    [nameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(SafeAreaTopHeight + 10* AutoSizeScaleY);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(Z_SCREEN_WIDTH, 55 * AutoSizeScaleY));
        
    }];
    self.nameTf = nameTf;
}

- (void)createGroup{
 
    if (self.nameTf.text.length == 0) {
        
        [self showHint:@"请输入群名称"];
        return;
    }
    
    [[BMHttpsMethod httpMethodManager] clusterCreateClusterWithUserId:UserID Name:self.nameTf.text ToGetResult:^(id  _Nonnull data) {
       
        [self showHint:data[@"errorMsg"]];
        if ([data[@"errorCode"] isEqualToString:@"0000"]) {
            
            [Z_NotificationCenter postNotificationName:@"createGroup" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
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
    
    //    textField.text =[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
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
