//
//  WebToolbarView.h
//  LeanCloudTest
//
//  Created by ZhangFan on 2019/7/31.
//  Copyright © 2019 Rahman Hamid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebToolbarDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebToolbarView : UIView

@property (nonatomic, strong) id<WebToolbarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
