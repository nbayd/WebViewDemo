//
//  NetworkManager.h
//  Wallper
//
//  Created by ZhangFan on 2019/8/13.
//  Copyright © 2019 Ranghua. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^resultRecived)(NSDictionary* _Nonnull result);
typedef void (^callback)();

@interface NetworkManager : NSObject

+ (void)getVersionUpdata: (resultRecived)block;
+ (void)pushServiceWithDeviceToken:(NSString*)deviceToken callback:(callback)block;

@end

NS_ASSUME_NONNULL_END
