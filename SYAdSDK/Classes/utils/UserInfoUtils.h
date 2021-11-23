//
//  UserInfoUtils.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/5/20.
//

#ifndef UserInfoUtils_h
#define UserInfoUtils_h

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <zlib.h>
#import <mach/mach.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoUtils : NSObject
+ (NSString*) getScreenWidth;
+ (NSString*) getScreenHeight;
+ (NSString*) getOSVersion;
+ (NSString*) getOSCode;
+ (NSString*) getAppVersion;
+ (NSString*) getUserAgent;
+ (NSString*) getVendor;
+ (NSString*) getManufacture;
+ (NSString*) getOSType;
+ (NSString*) getModel;
+ (NSString*) getOAID;
+ (NSNumber*) getNetworkType;
+ (NSString*) getIP;
+ (NSString*) getUserId:(NSString*)_idfa;
+ (NSString*) getMAC;
+ (NSString*) getOperatorType;
+ (NSString*) getIMEI;
+ (NSString*) getAndroidId;
+ (NSString*) getLatitude;
+ (NSString*) getLongitude;
+ (NSNumber*) getTimestamp;
+ (NSNumber*) getDeviceStartSec;
+ (NSString*) getCountry;
+ (NSString*) getLanguage;
+ (NSString*) getDeviceNameMd5;
+ (NSString*) getHWMachine;
+ (NSString*) getPhysicalMemoryByte;
+ (NSString*) getHDSize;
+ (NSString*) getSystemUpdateSec;
+ (NSString*) getTimezone;
+ (NSString*) MD5String: (NSString*)input;

+ (NSString*) mkJSON:(NSString*) pszAppId idfa:(NSString*) pszIdfa;

@end

NS_ASSUME_NONNULL_END

#endif
