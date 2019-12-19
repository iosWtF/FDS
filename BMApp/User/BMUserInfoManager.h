//
//  BMUserInfoManager.h
//  Tourism
//
//  Created by Mac on 2019/3/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UserModel;
@class BMUserInfoModel;
@class BMCityModel;
@class BMContactModel;
@interface BMUserInfoManager : NSObject

//创建单例，return自身
+(BMUserInfoManager *)sharedManager;



//判断用户是否已登录，return是否已登录
-(BOOL)isLoginIn;


//保存个人信息

-(void)saveUser:(UserModel *)user;

-(void)saveUserInfo:(BMUserInfoModel *)user;
-(void)saveCity:(BMCityModel *)city;
- (void)saveContact:(BMContactModel *)contact WithContactId:(NSString *)contactId;
//读取个人信息

-(UserModel *)getUser;
-(BMUserInfoModel *)getUserInfo;
-(BMCityModel *)getCity;
-(BMContactModel *)getContactWithContactId:(NSString *)contactId;
//移除用户个人信息

-(void)removeUser;
-(void)removeUserInfo;

-(void)removeCity;
-(void)removeContactWithContactId:(NSString *)contactId;
@end

NS_ASSUME_NONNULL_END
