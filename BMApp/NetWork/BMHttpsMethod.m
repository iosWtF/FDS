//
//  BMHttpsMethod.m
//  Tourism
//
//  Created by Mac on 2019/3/4.
//  Copyright © 2019 BM. All rights reserved.
//

#import "BMHttpsMethod.h"

@implementation BMHttpsMethod

// 创建静态对象 防止外部访问
static BMHttpsMethod *_httpMethod;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    //    @synchronized (self) {
    //        // 为了防止多线程同时访问对象，造成多次分配内存空间，所以要加上线程锁
    //        if (_instance == nil) {
    //            _instance = [super allocWithZone:zone];
    //        }
    //        return _instance;
    //    }
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_httpMethod == nil) {
            _httpMethod = [super allocWithZone:zone];
        }
    });
    return _httpMethod;
}
+(instancetype)httpMethodManager
{
    
    return [[self alloc]init];
}

-(id)copyWithZone:(NSZone *)zone
{
    return _httpMethod;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _httpMethod;
}

- (void)sharePlanWithUserid:(NSString *)userid OrderId:(NSString *)orderId Fid:(NSString *)fid ToGetResult:(void (^)(id data))complete{
    
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",orderId,@"id",fid,@"fid",nil];
    [NetWorkManager requestWithType:1 withUrlString:BaseURL withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];

}
- (void)fileUploadFileWithImgArr:(NSArray *)img ToGetResult:(void (^)(id data))complete{
    
    if (img.count == 0) {
        
        return;
    }
    [NetWorkManager uploadImageWithOperations:nil withImageArray:img withtargetWidth:0 withUrlString:[NSString stringWithFormat:@"%@file/uploadFile",BaseURL] withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
        
    } withFailurBlock:^(NSError *error) {
        
        if (complete){
            
            complete(@{});
        }
        
    } withUpLoadProgress:^(float progress) {
        
    }];
}
- (void)fileUploadFilesWithImgArr:(NSArray *)img ToGetResult:(void (^)(id data))complete{
    
    if (img.count == 0) {
        
        return;
    }
    [NetWorkManager uploadImageWithOperations:nil withImageArray:img withtargetWidth:0 withUrlString:[NSString stringWithFormat:@"%@file/uploadFiles",BaseURL] withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
        
    } withFailurBlock:^(NSError *error) {
        
        if (complete){
            
            complete(@{});
        }
        
    } withUpLoadProgress:^(float progress) {
        
    }];
}

#pragma mark ======  获取群组设备列表  ======

/**
 获取群组设备列表
 
 @param clusterId 群组id
 @param complete 返回值
 */
- (void)deviceDeviceListWithClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:clusterId,@"clusterId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@device/deviceList",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}

#pragma mark ======  足迹/轨迹  ======

/**
 足迹/轨迹
 
 @param date 日期
 @param deviceId 设备id
 @param complete 返回值
 */
- (void)positionGetListWithDate:(NSString *)date DeviceId:(NSString *)deviceId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:date,@"date",deviceId,@"deviceId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@position/getList",BaseURL] withParaments:dict withShowIndicator:YES withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
#pragma mark ======  安全消息列表  ======

/**
 安全消息列表
 
 @param pageNow 当前页
 @param size 大小
 @param userid 用户id
 @param complete 返回值
 */
- (void)messagePageWithPageNow:(NSString *)pageNow Size:(NSString *)size userid:(NSString *)userid ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:pageNow,@"pageNow",size,@"pageSize",userid,@"userId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@message/page",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
#pragma mark ======  查看安全消息详情  ======

/**
 查看安全消息详情
 
 @param Id 消息id
 @param complete 返回值
 */
- (void)messageGetWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@message/get",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)deviceOutburstWithDeviceId:(NSString *)deviceId Status:(NSString *)status ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:deviceId,@"deviceId",status,@"emergency",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@device/outburst",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
    
}
- (void)userGetCheckCodeWithPhoneNo:(NSString *)phoneNo Type:(NSString *)type ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:phoneNo,@"phoneNo",type,@"type",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/getCheckCode",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}

#pragma mark ======  登录注册  ======

/**
 登录注册
 
 @param phoneNo 手机号
 @param checkCode 短信验证码
 @param qqOpenid qq唯一码
 @param wechatOpenid 微信唯一码
 @param complete 返回值
 */
- (void)userLoginWithPhoneNo:(NSString *)phoneNo CheckCode:(NSString *)checkCode QqOpenid:(NSString *)qqOpenid WechatOpenid:(NSString *)wechatOpenid NickName:(NSString *)nickName PicUrl:(NSString *)picUrl Gender:(NSString *)gender ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:phoneNo,@"phoneNo",checkCode,@"checkCode",qqOpenid,@"qqOpenid",wechatOpenid,@"wechatOpenid",nickName,@"nickName",picUrl,@"picUrl",gender,@"gender",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/login",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)userFrontPageWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/frontPage",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterGetClusterListWithUserId:(NSString *)userId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@cluster/getClusterList",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterCreateClusterWithUserId:(NSString *)userId Name:(NSString *)name ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",name,@"name",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@cluster/createCluster",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterGetClusterInfoWithUserId:(NSString *)userId ClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",clusterId,@"clusterId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@cluster/getClusterInfo",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)userGetUserDetailByIdWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/getUserDetailById",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterUpdateWithId:(NSString *)Id Name:(NSString *)name ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",name,@"name",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@cluster/update",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)fenceGetFenceListWithClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:clusterId,@"clusterId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@fence/getFenceList",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)fenceSaveWithClusterId:(NSString *)clusterId Name:(NSString *)name Position:(NSString *)position Longitude:(NSString *)longitude Latitude:(NSString *)latitude Radius:(NSString *)radius ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:clusterId,@"clusterId",name,@"name",position,@"position",longitude,@"longitude",latitude,@"latitude",radius,@"radius",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@fence/save",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)fenceGetWithClusterId:(NSString *)Id ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@fence/get",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)fenceDeleteWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@fence/delete",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)deviceDeviceListWithUserId:(NSString *)userId ClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",clusterId,@"clusterId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@device/deviceList",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterGetUserListWithClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:clusterId,@"clusterId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@cluster/getUserList",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterUserRemindWithId:(NSString *)Id Remind:(NSString *)remind ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",remind,@"remind",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@clusterUser/remind",BaseURL] withParaments:dict withShowIndicator:YES withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)retentionRetentionListWithDeviceId:(NSString *)deviceId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:deviceId,@"deviceId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@retention/retentionList",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)retentionSaveWithDeviceId:(NSString *)deviceId StartTime:(NSString *)startTime EndTime:(NSString *)endTime Period:(NSString *)period ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:deviceId,@"deviceId",startTime,@"startTime",endTime,@"endTime",period,@"period",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@retention/save",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)retentionDeleteWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@retention/delete",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)deviceGetWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@device/get",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)deviceDeleteWithId:(NSString *)Id ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@device/delete",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterBindingDeviceWithClusterId:(NSString *)clusterId Imei:(NSString *)imei ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:clusterId,@"clusterId",imei,@"imei",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@cluster/bindingDevice",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)deviceUpdateWithId:(NSString *)Id Name:(NSString *)name Birthday:(NSString *)birthday ChildrenType:(NSString *)childrenType PicUrl:(NSString *)picUrl ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",name,@"name",birthday,@"birthday",childrenType,@"childrenType",picUrl,@"picUrl",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@device/update",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)noticePageWithPageNow:(NSString *)pageNow Size:(NSString *)size UserId:(NSString *)userId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:pageNow,@"pageNow",size,@"pageSize",userId,@"userId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@notice/page",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)userMyInfoWithUserId:(NSString *)userId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/myInfo",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)messageUserDeleteWithId:(NSString *)Id UserId:(NSString *)userId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",userId,@"userId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@messageUser/delete",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)noticeUserDeleteWithId:(NSString *)Id UserId:(NSString *)userId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",userId,@"userId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@noticeUser/delete",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterUserSaveWithUserId:(NSString *)userId ClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",clusterId,@"clusterId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@clusterUser/save",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)userUpdateWithId:(NSString *)Id IsPush:(NSString *)isPush NickName:(NSString *)nickName PicUrl:(NSString *)picUrl Gender:(NSString *)gender Description:(NSString *)description ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",isPush,@"isPush",nickName,@"nickName",picUrl,@"picUrl",gender,@"gender",description,@"description",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/update",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)feedbackSaveWithUserId:(NSString *)userId Content:(NSString *)content PhoneNo:(NSString *)phoneNo PicUrls:(NSString *)picUrls ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",content,@"content",phoneNo,@"phoneNo",picUrls,@"picUrls",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@feedback/save",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)userCheckCodeWithPhoneNo:(NSString *)phoneNo CheckCode:(NSString *)checkCode ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:phoneNo,@"phoneNo",checkCode,@"checkCode",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/checkCode",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)userUpdatePhoneNoWithUserId:(NSString *)userId PhoneNo:(NSString *)phoneNo CheckCode:(NSString *)checkCode ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",phoneNo,@"phoneNo",checkCode,@"checkCode",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/updatePhoneNo",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)questionPageWithPageNow:(NSString *)pageNow Size:(NSString *)size ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:pageNow,@"pageNow",size,@"pageSize",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@question/page",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)settingGetSettingToGetResult:(void (^)(id data))complete{
    
    
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@setting/getSetting",BaseURL] withParaments:nil withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}

- (void)clusterTransferWithUserId:(NSString *)userId ClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",clusterId,@"clusterId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@cluster/transfer",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterDissolveWithClusterId:(NSString *)clusterId ToGetResult:(void (^)(id data))complete;{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:clusterId,@"clusterId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@cluster/dissolve",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)clusterUserRemoveWithClusterId:(NSString *)clusterId UserId:(NSString *)userId ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:clusterId,@"clusterId",userId,@"userId",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@clusterUser/remove",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)userRedirectWithQqOpenid:(NSString *)qqOpenid WechatOpenid:(NSString *)wechatOpenid ToGetResult:(void (^)(id data))complete{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:qqOpenid,@"qqOpenid",wechatOpenid,@"wechatOpenid",nil];
    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@user/redirect",BaseURL] withParaments:dict withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
- (void)deviceSettingGetSettingToGetResult:(void (^)(id data))complete{

    [NetWorkManager requestWithType:1 withUrlString:[NSString stringWithFormat:@"%@deviceSetting/getSetting",BaseURL] withParaments:nil withShowIndicator:NO withSuccessBlock:^(NSDictionary *object) {
        
        if (complete){
            
            complete(object);
        }
    } withFailureBlock:^(NSError *error) {
        if (complete){
            
            complete(@{});
        }
    } progress:^(float progress) {
        
    }];
}
@end
