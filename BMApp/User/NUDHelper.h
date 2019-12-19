//
//  NUDHelper.h
//  Tourism
//
//  Created by Mac on 2019/3/6.
//  Copyright © 2019 BM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NUDHelper : NSObject
+(void)saveValue:(id) value forKey:(NSString *)key;

+(id)valueWithKey:(NSString *)key;

+(BOOL)boolValueWithKey:(NSString *)key;

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+(void)removeValueWithKey:(NSString *) key;
+(void)print;
@end

NS_ASSUME_NONNULL_END
