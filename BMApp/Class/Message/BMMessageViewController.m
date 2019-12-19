//
//  BMMessageViewController.m
//  BMApp
//
//  Created by Mac on 2019/9/5.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMMessageViewController.h"

@interface BMMessageViewController ()

@end

@implementation BMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"消息中心";
    [self.customNavBar wr_setRightButtonWithTitle:@"清空" titleColor:[UIColor getUsualColorWithString:@"#FFFFFF"]];
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
