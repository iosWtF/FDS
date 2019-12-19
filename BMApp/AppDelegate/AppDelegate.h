//
//  AppDelegate.h
//  BMApp
//
//  Created by Mac on 2019/5/21.
//  Copyright © 2019 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic) BOOL netStatus;

@property (copy, nonatomic) NSString * net;
@end


