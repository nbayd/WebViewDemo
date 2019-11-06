//
//  AppDelegate.h
//  WebViewDemo
//
//  Created by ZhangFan on 2019/10/9.
//  Copyright © 2019 Ranghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

typedef void (^isNew)(BOOL isNew);

@property (strong, nonatomic) UIWindow * _Nonnull window;

+ (void)checkNewVersion:(isNew _Nonnull)block;

@end

