//
//  WebToolbarDelegate.h
//  LeanCloudTest
//
//  Created by ZhangFan on 2019/7/31.
//  Copyright © 2019 Rahman Hamid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WebToolbarDelegate <NSObject>

- (void)webtoolbarDidToPrev;
- (void)webtoolbarDidToNext;
- (void)webtoolbarDidToHome;
- (void)webtoolbarDidReload;

@end

NS_ASSUME_NONNULL_END
