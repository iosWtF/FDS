//
//  NUDHelper.m
//  Tourism
//
//  Created by Mac on 2019/3/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import "NUDHelper.h"

@implementation NUDHelper
+(void)saveValue:(id) value forKey:(NSString *)key{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}

+(id)valueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:key];
    id user;
    if(data){
        user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return user;
}

+(BOOL)boolValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

+(void)removeValueWithKey:(NSString *) key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    
}

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

+(void)print{
    //    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    //    DNSLog(@"%@",dic);
}

@end
