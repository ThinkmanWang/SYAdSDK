//
//  UserInfoUtils.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/5/20.
//

#import "UserInfoUtils.h"

#import <CommonCrypto/CommonCrypto.h>
#import <UIKit/UIDevice.h>
#import <sys/utsname.h>
#import <sys/sysctl.h>

#import <UIKit/UIKit.h>
#import <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <zlib.h>
#import <mach/mach.h>
#import <Foundation/NSProcessInfo.h>

#import "SYLogUtils.h"
#import "StringUtils.h"

@interface UserInfoUtils()

@end

@implementation UserInfoUtils

+ (NSString*) getScreenWidth {
    CGRect rect = [[UIScreen mainScreen] bounds];
    return [NSString stringWithFormat:@"%ld", (NSInteger)floorf(rect.size.width)];
}

+ (NSString*) getScreenHeight {
    CGRect rect = [[UIScreen mainScreen] bounds];
    return [NSString stringWithFormat:@"%ld", (NSInteger)floorf(rect.size.height)];
}

+ (NSString*) getOSVersion {
    NSString* pszRet = [UIDevice currentDevice].systemVersion;
    
    if ([StringUtils isEmpty:pszRet]) {
        return @"";
    }
    
    return pszRet;
}

+ (NSString*) getOSCode {
    return [UserInfoUtils getOSVersion];
}

+ (NSString*) getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if (nil == infoDictionary) {
        return @"";
    }
    
    NSString* pszAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if ([StringUtils isEmpty:pszAppVersion]) {
        return @"";
    }
    
    return pszAppVersion;
}

+ (NSString*) getUserAgent {
    UIWebView* webView = [[UIWebView alloc]initWithFrame: CGRectZero];
    NSString* pszUserAgent = [webView stringByEvaluatingJavaScriptFromString: @"navigator.userAgent"];
    
    if ([StringUtils isEmpty:pszUserAgent]) {
        return @"";
    }
    
    return pszUserAgent;
}

+ (NSString*) getVendor {
    return @"APPLE";
}

+ (NSString*) getManufacture {
    return @"APPLE";
}

+ (NSString*) getOSType {
    return @"1";
}

+ (NSString*) getModel {
    NSString* pszRet = [UIDevice currentDevice].model;
    
    if ([StringUtils isEmpty:pszRet]) {
        return @"";
    }
    
    return pszRet;
}

+ (NSString*) getOAID {
    return @"";
}

+ (NSNumber*) getNetworkType {
    //TODO
    return [NSNumber numberWithInt:-1];
}

+ (NSString*) getIP {
    //TODO
    return @"";
}

+ (NSString*) getUserId:(NSString*)_idfa {
    if ([StringUtils isEmpty:_idfa]) {
        //TODO
        return @"00000000-0000-0000-0000-000000000000";
    }
    
    return _idfa;
}

+ (NSString*) getMAC {
    return @"02:00:00:00:00:00";
}

+ (NSString*) getOperatorType {
    //TODO
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    NSString* pszCode = [NSString stringWithFormat:@"%@%@", [carrier mobileCountryCode], [carrier mobileNetworkCode]];
    
    if ([StringUtils isEmpty:pszCode]) {
        return @"-1";
    }
    
    if ([pszCode isEqualToString:@"46000"]
        || [pszCode isEqualToString:@"46002"]
        || [pszCode isEqualToString:@"46004"]
        || [pszCode isEqualToString:@"46007"]) {
        //CM
        return @"1";
    } else if ([pszCode isEqualToString:@"46001"]
               || [pszCode isEqualToString:@"46006"]
               || [pszCode isEqualToString:@"46009"]) {
        //CU
        return @"3";
    } else if ([pszCode isEqualToString:@"46003"]
               || [pszCode isEqualToString:@"46005"]
               || [pszCode isEqualToString:@"46011"]) {
        //CT
        return @"2";
    } else if ([pszCode isEqualToString:@"46020"]) {
        return @"0";
    }
    
    return @"0";
}

+ (NSString*) getIMEI {
    return @"";
}

+ (NSString*) getAndroidId {
    return @"";
}

+ (NSString*) getLatitude {
    return @"";
}

+ (NSString*) getLongitude {
    return @"";
}

+ (NSNumber*) getTimestamp {
    double currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    long long iTime = (long long)currentTime;
    
    return [NSNumber numberWithLongLong:iTime];
}

+ (NSNumber*) getDeviceStartSec {
    struct timeval boottime;
    
    size_t len = sizeof(boottime);
    int mib[2] = { CTL_KERN, KERN_BOOTTIME };
    if( sysctl(mib, 2, &boottime, &len, NULL, 0) < 0 ) {
        return 0;
    }
    
    return [NSNumber numberWithLong: boottime.tv_sec];
}

+ (NSString*) getCountry {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    
    if ([StringUtils isEmpty:countryCode]) {
        return @"";
    }
    
    return countryCode;
}

+ (NSString*) getLanguage {
    NSString *language;
    NSLocale *locale = [NSLocale currentLocale];
    
    if ([[NSLocale preferredLanguages] count] > 0) {
        language = [[NSLocale preferredLanguages]objectAtIndex:0];
    } else {
        language = [locale objectForKey:NSLocaleLanguageCode];
    }
    
    if ([StringUtils isEmpty:language]) {
        return @"";
    }
    
    return language;
}

+ (NSString*) getDeviceNameMd5 {
    NSString* pszMd5 = [UserInfoUtils MD5String: [[UIDevice currentDevice] name]];
    
    if ([StringUtils isEmpty:pszMd5]) {
        return @"";
    }
    
    return pszMd5;
}

+ (NSString*) MD5String: (NSString*)input {
    if ([StringUtils isEmpty:input]) {
        return nil;
    }
    
    const char* str = [input UTF8String];
    unsigned char result[16];
    
    CC_MD5(str, (uint32_t)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:16 * 2];
    for(int i = 0; i<16; i++) {
        [ret appendFormat:@"%02x",(unsigned int)(result[i])];
    }
    
    return ret;
}

+ (NSString*) getHWMachine {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname("hw.machine", answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithUTF8String:answer];
    free(answer);
    
    if ([StringUtils isEmpty:results]) {
        return @"";
    }
    
    return results;
}

+ (NSString*) getPhysicalMemoryByte {
    unsigned long long nMemory = [NSProcessInfo processInfo].physicalMemory;
    
    return [NSString stringWithFormat:@"%llu", nMemory];
}

+ (NSString*) getHDSize {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath: NSHomeDirectory() error: nil];
    NSString *diskSize = [[fattributes objectForKey:NSFileSystemSize] stringValue];
    
    if ([StringUtils isEmpty:diskSize]) {
        return @"";
    }
    
    return diskSize;
}

+ (NSString*) getSystemUpdateSec {
    NSString* result = nil;
    NSString* information = @"L3Zhci9tb2JpbGUvTGlicmFyeS9Vc2VyQ29uZmlndXJhdGlvblByb2ZpbGVzL1B1YmxpY0luZm8vTUNNZXRhLnBsaXN0";
    NSData *data=[[NSData alloc]initWithBase64EncodedString:information options:0];
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:dataString error:&error];
    
    if (fileAttributes) {
        id singleAttibute = [fileAttributes objectForKey:NSFileCreationDate];
        if ([singleAttibute isKindOfClass:[NSDate class]]) {
            NSDate *dataDate = singleAttibute;
            result = [NSString stringWithFormat:@"%f",[dataDate timeIntervalSince1970]];
        }
    }
    
    if ([StringUtils isEmpty:result]) {
        return @"";
    }
    
    return result;
}

+ (NSString*) getTimezone {
//    NSInteger offset = [NSTimeZone systemTimeZone].secondsFromGMT;
//    return [NSString stringWithFormat:@"%ld",(long)offset];
    
    NSString* pszZone = [[NSTimeZone systemTimeZone] name];
    
    if ([StringUtils isEmpty:pszZone]) {
        return @"";
    }
    
    return pszZone;
}

+ (NSString*) mkJSON:(NSString*) pszAppId idfa:(NSString*) pszIdfa {
    if ([StringUtils isEmpty:pszAppId]) {
        pszAppId = @"";
    }
    
    if ([StringUtils isEmpty:pszIdfa]) {
        pszIdfa = @"";
    }
    
    @try {
        NSDictionary* pdictInfo = @{
            @"appId": pszAppId,
            @"screenWidth": [UserInfoUtils getScreenWidth],
            @"appVersion":[UserInfoUtils getAppVersion],
            @"osVersion":[UserInfoUtils getOSVersion],
            @"ua":[UserInfoUtils getUserAgent],
            @"osCode":[UserInfoUtils getOSCode],
            @"screenHeight":[UserInfoUtils getScreenHeight],
            @"vendor":[UserInfoUtils getVendor],
            @"manufacture":[UserInfoUtils getManufacture],
            @"osType":[UserInfoUtils getOSType],
            @"model":[UserInfoUtils getModel],
            @"oaid":[UserInfoUtils getOAID],
            @"idfa":pszIdfa,
            @"networkType":[UserInfoUtils getNetworkType],
            @"ip":[UserInfoUtils getIP],
            @"userId":[UserInfoUtils getUserId:pszIdfa],
            @"mac":[UserInfoUtils getMAC],
            @"operatorType":[UserInfoUtils getOperatorType],
            @"imei":[UserInfoUtils getIMEI],
            @"androidid":[UserInfoUtils getAndroidId],
            @"latitude":[UserInfoUtils getLatitude],
            @"longitude":[UserInfoUtils getLongitude],
            @"timestamp":[UserInfoUtils getTimestamp],
            @"requestId":[SYLogUtils mkRequestID],
            @"deviceStartSec":[UserInfoUtils getDeviceStartSec],
            @"country":[UserInfoUtils getCountry],
            @"language":[UserInfoUtils getLanguage],
            @"deviceNameMd5":[UserInfoUtils getDeviceNameMd5],
            @"hardwareMachine":[UserInfoUtils getHWMachine],
            @"physicalMemoryByte":[UserInfoUtils getPhysicalMemoryByte],
            @"hardDiskSizeByte":[UserInfoUtils getHDSize],
            @"systemUpdateSec":[UserInfoUtils getSystemUpdateSec],
            @"timeZone":[UserInfoUtils getTimezone],
        };
        
        return [StringUtils dictToStr: pdictInfo];
        
    } @catch (NSException *exception) {
        NSLog(@"%@: %@",exception.name, exception.reason);
        return @"{}";
        
    } @finally {
        
    }
    
}

@end
