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
+ (int) getStartSec;
+ (NSString*) getUpdate;
+ (NSString*) getOSVersion;
+ (float) getOSVersionFloat;
+ (NSString*) getDeviceType;
+ (int) getScreenWidth;
+ (int) getScreenHeight;
+ (int) getPPI;
+ (NSString*) getCountryCode;
+ (NSString*) getLanguage;
+ (NSString*) deviceName;
+ (unsigned long long) physicalMemoryByte;
+ (u_int64_t) hardDiskSize;
+ (NSString*) timeZone;
+ (NSString*) userAgent;

+ (void) deviceTest;

@end

NS_ASSUME_NONNULL_END
