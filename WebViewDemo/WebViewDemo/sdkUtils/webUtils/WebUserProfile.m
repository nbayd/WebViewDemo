//
//  WebUserProfile.m
//  LeanCloudTest
//
//  Created by ZhangFan on 2019/8/2.
//  Copyright © 2019 Rahman Hamid. All rights reserved.
//

#import "WebUserProfile.h"

#define IS_NOT_FIRST_RUN @"isNotFirstRun"

@implementation WebUserProfile

+ (BOOL)isNotFirstRun {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:IS_NOT_FIRST_RUN];
}

+ (void)setNotFirstRun:(BOOL)newValue {
    [[NSUserDefaults standardUserDefaults] setBool:newValue forKey:IS_NOT_FIRST_RUN];
}

@end
