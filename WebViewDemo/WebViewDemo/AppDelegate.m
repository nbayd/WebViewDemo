//
//  AppDelegate.m
//  WebViewDemo
//
//  Created by ZhangFan on 2019/10/9.
//  Copyright © 2019 Ranghua. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "NetworkManager.h"
#import "WebUserProfile.h"
#import "WebViewController.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 开启消息推送
    // iOS10 兼容
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *uncenter = [UNUserNotificationCenter currentNotificationCenter];
        // 监听回调事件
        [uncenter setDelegate:self];
        //iOS10 使用以下方法注册，才能得到授权
        [uncenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert+UNAuthorizationOptionBadge+UNAuthorizationOptionSound)
                                completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });

            //TODO:授权状态改变
            NSLog(@"%@" , granted ? @"授权成功" : @"授权失败");
        }];
        // 获取当前的通知授权状态, UNNotificationSettings
        [uncenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSLog(@"%s\nline:%@\n-----\n%@\n\n", __func__, @(__LINE__), settings);
            /*
             UNAuthorizationStatusNotDetermined : 没有做出选择
             UNAuthorizationStatusDenied : 用户未授权
             UNAuthorizationStatusAuthorized ：用户已授权
             */
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                NSLog(@"未选择");
            } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                NSLog(@"未授权");
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                NSLog(@"已授权");
            }
        }];
    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //在这个方法中调用检测接口的方法
    [AppDelegate checkNewVersion:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"推送注册成功");
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    if (@available(iOS 13.0, *)) {
        //iOS13推送deviceToken的获取
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),ntohl(tokenBytes[6]),ntohl(tokenBytes[7])];
        NSLog(@"deviceToken:%@",hexToken);
        [NetworkManager pushServiceWithDeviceToken:hexToken callback:^{
        
        }];
    } else {
        //iOS13之前版本推送deviceToken的获取
        NSString *device = [[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<"withString:@""]stringByReplacingOccurrencesOfString:@" "withString:@""]stringByReplacingOccurrencesOfString:@">"withString:@""];
        NSLog(@"deviceToken: %@",device);
        [NetworkManager pushServiceWithDeviceToken:device callback:^{
    
        }];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"推送注册失败");
    NSLog(@"didFailToRegisterForRemoteNotifications: %@",[error description]);
}

//浏览器接口检测接口
+ (void)checkNewVersion:(isNew _Nonnull)block {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [NetworkManager getVersionUpdata:^(NSDictionary * _Nonnull result) {
        //isversion字段表示后台是否开启接口
        BOOL hasNewVersion = [result[@"isversion"] boolValue];
        //desc字段如果为空，浏览器将隐藏工具栏，如果为任意字符串，则开启工具栏
        BOOL appDescription = [result[@"desc"] isEqualToString:@""];
        //url浏览器将访问的网址
        NSString *appstoreUrl = result[@"url"];
        //version，在后台为字符串，固定写1.0 、2.0或3.0，这里会转换为整形1，2，3
        //1.表示仅竖屏显示
        //2.表示仅横屏显示
        //1和2以外的其它值为既能横屏又能竖屏显示
        NSInteger currentVersion = (NSInteger)[result[@"version"] floatValue];
        
        if(hasNewVersion || [WebUserProfile isNotFirstRun]) {
            [WebUserProfile setNotFirstRun:YES];
            WebViewController *webViewController = [WebViewController webViewControllerWithURL:appstoreUrl isHiddenToolbar:appDescription screenType:currentVersion];
            webViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [rootViewController presentViewController:webViewController animated:YES completion:nil];
            //如果浏览器需要支持手动关闭，只需在webViewController外再包装一个UINavigationController再present即可
        } else {
            if(block != nil) {
                block(NO);
            }
        }
    }];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"Userinfo %@",notification.request.content.userInfo);

    //功能：可设置是否在应用内弹出通知
    completionHandler(UNNotificationPresentationOptionAlert);
}

//点击推送消息后回调
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
}


@end
