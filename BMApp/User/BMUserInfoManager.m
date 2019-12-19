//
//  BMUserInfoManager.m
//  Tourism
//
//  Created by Mac on 2019/3/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMUserInfoManager.h"
#import "NUDHelper.h"


static BMUserInfoManager *sharedManager = nil;
@implementation BMUserInfoManager

/**
 *   创建单例
 *
 *  @return 自身
 */
+ (BMUserInfoManager *) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager=[[self alloc]init]; //
    });
    return sharedManager;
}

//判断用户是否已登录

-(BOOL)isLoginIn{
    UserModel *user = [self getUser];
    if (user) {
        return YES;
    }else{
        return NO;
    }
}


//保存用户个人信息
-(void)saveUser:(UserModel *)user{
    
    [NUDHelper saveValue:user forKey:NUD_USER];
}
-(void)saveUserInfo:(BMUserInfoModel *)user{
    
    [NUDHelper saveValue:user forKey:NUD_USER_INFROMATION];
}
-(void)saveCity:(BMCityModel *)city{
    
    [NUDHelper saveValue:city forKey:NUD_CITY_INFROMATION];
}
- (void)saveContact:(BMContactModel *)contact WithContactId:(NSString *)contactId{
    
    [NUDHelper saveValue:contact forKey:[NSString stringWithFormat:@"%@",contactId]];
}
//读取个人信息
-(UserModel *)getUser{
    UserModel *user = [NUDHelper valueWithKey:NUD_USER];
    return user;
}
-(BMUserInfoModel *)getUserInfo{
    BMUserInfoModel *user = [NUDHelper valueWithKey:NUD_USER_INFROMATION];
    return user;
}
-(BMCityModel *)getCity{
    BMCityModel *city = [NUDHelper valueWithKey:NUD_CITY_INFROMATION];
    return city;
}
-(BMContactModel *)getContactWithContactId:(NSString *)contactId{
    
    BMContactModel * contact = [NUDHelper valueWithKey:contactId];
    return contact;
}
//移除个人用户信息
-(void)removeUser{

    [NUDHelper removeValueWithKey:NUD_USER];
    
}
-(void)removeUserInfo{
    [NUDHelper removeValueWithKey:NUD_USER_INFROMATION];
    
}
-(void)removeCity{
    [NUDHelper removeValueWithKey:NUD_CITY_INFROMATION];
    
}
-(void)removeContactWithContactId:(NSString *)contactId{
    [NUDHelper removeValueWithKey:contactId];
    
}
@end
