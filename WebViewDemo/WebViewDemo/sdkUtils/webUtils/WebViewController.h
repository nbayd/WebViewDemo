//
//  WebViewController.h
//  LeanCloudTest
//
//  Created by ZhangFan on 2019/7/31.
//  Copyright © 2019 Rahman Hamid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController

/*
 screenType:
    1   仅横屏
    2   仅竖屏
    其它值  横竖屏跟随系统
 */
@property (assign, nonatomic) NSInteger screenType;

+ (WebViewController*)webViewControllerWithURL:(NSString*)urlStr isHiddenToolbar: (BOOL)isHiddenToolbar screenType:(NSInteger) screenType;

@end

NS_ASSUME_NONNULL_END
