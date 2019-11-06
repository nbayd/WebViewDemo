//
//  NetworkManager.m
//  Wallper
//
//  Created by ZhangFan on 2019/8/13.
//  Copyright © 2019 Ranghua. All rights reserved.
//

#import "AFNetworking.h"
#import "NetworkManager.h"

#define APP_ID @"uPGGpPfrbicu5xTY4eNGUXsS-MdYXbMMI" //这里填写LeanCloud的APP_ID
#define APP_KET @"0k1LEeWkkfba71FjRzbGMfhg" //这里填写LeanCloud的APP_KET
#define MASTER_KEY @"J3DsDtDVrkJE3nVg9oIKx4qz" //这里填写LeanCloud的MASTER_KEY

#define HOST_URL @"http://139.9.210.81" //接口服务器地址

@implementation NetworkManager

+ (void)getVersionUpdata: (resultRecived)block {
    NSDictionary *param = @{
                            @"appId" : APP_ID,
                            @"appKey" : APP_KET,
                            @"masterKey" : MASTER_KEY
                            };
    AFHTTPSessionManager *afnManager = [[AFHTTPSessionManager alloc]init];
    [afnManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [afnManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [afnManager POST:[NSString stringWithFormat:@"%@/check/checkupdate/updatemsg",HOST_URL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dataObj = responseObject;
        if([dataObj[@"msg"] isEqualToString:@"ok"]) {
            NSDictionary *resultData = dataObj[@"data"];
            block(resultData);
        } else {
            NSLog(@"%@",[NSString stringWithFormat:@"%@",dataObj[@"msg"]]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[error localizedDescription]]);
        [self logError:error];
    }];
}

+ (void)pushServiceWithDeviceToken:(NSString*)deviceToken callback:(callback)block {
    NSDictionary *param = @{
                            @"appId" : APP_ID,
                            @"appKey" : APP_KET,
                            @"token" : deviceToken
                            };
    AFHTTPSessionManager *afnManager = [[AFHTTPSessionManager alloc]init];
    [afnManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [afnManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [afnManager POST:[NSString stringWithFormat:@"%@/check/push/pushService",HOST_URL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        block();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[error localizedDescription]]);
        [self logError:error];
    }];
}

+ (void)logError:(NSError *)error {
    NSLog(@"%@",error);
    NSLog(@"Network request error：\n代码：%ld\n\%@",(long)error.code,error.localizedDescription);
}

@end
