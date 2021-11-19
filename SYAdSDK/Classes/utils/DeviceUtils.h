//
//  DeviceUtils.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceUtils : NSObject

+ (NSString*) getBoot;
+ (NSString*) getUpdate;
+ (NSString*) getOSVersion;
+ (float) getOSVersionFloat;

@end

NS_ASSUME_NONNULL_END
