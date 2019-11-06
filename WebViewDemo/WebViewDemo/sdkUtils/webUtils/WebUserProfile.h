//
//  WebUserProfile.h
//  LeanCloudTest
//
//  Created by ZhangFan on 2019/8/2.
//  Copyright © 2019 Rahman Hamid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebUserProfile : NSObject

+ (BOOL)isNotFirstRun;
+ (void)setNotFirstRun:(BOOL)newValue;

@end

NS_ASSUME_NONNULL_END
