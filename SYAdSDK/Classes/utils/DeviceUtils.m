//
//  DeviceUtils.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/19.
//

#import "DeviceUtils.h"

#import <sys/stat.h>
#import <sys/sysctl.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "StringUtils.h"

static NSString* ip = @"";

@implementation DeviceUtils

+ (NSString*) ip {
//    if ([StringUtils isEmpty:ip]) {
//
//    }
    
    return ip;
}

+ (void) setIp:(NSString*)val {
    ip = val;
}

+ (NSString *) getBoot {
    NSString *timeString = nil;
    int mib[2];
    size_t size;
    struct timeval  boottime;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_BOOTTIME;
    size = sizeof(boottime);
    
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1) {
        timeString = [NSString stringWithFormat:@"%d.%d", (int) boottime.tv_sec, (int) boottime.tv_usec];
    }
    
    return timeString?:@"";
}

+ (int) getStartSec {
    int mib[2];
    size_t size;
    struct timeval  boottime;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_BOOTTIME;
    size = sizeof(boottime);
    
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1) {
        NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        NSNumber* nTimestamp = [NSNumber numberWithDouble:timeStamp];
        
        return nTimestamp.intValue - boottime.tv_sec;
    }
    
    return 0;
}

+ (NSString *)getUpdate {
    NSString *timeString = nil;
    struct stat sb;
    NSString *enCodePath = @"L3Zhci9tb2JpbGU=";
    NSData *data=[[NSData alloc]initWithBase64EncodedString:enCodePath options:0];
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    const char* dePath = [dataString cStringUsingEncoding:NSUTF8StringEncoding];
    
    if (stat(dePath, &sb) != -1) {
        timeString = [NSString stringWithFormat:@"%d.%d", (int)sb.st_ctimespec.tv_sec, (int)sb.st_ctimespec.tv_nsec];
    } else {
        timeString = @"0.0";
        
    }
        
    return timeString?:@"";
}

+ (NSString*) getOSVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (float) getOSVersionFloat {
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+ (NSString*) getDeviceType {
    return [[UIDevice currentDevice] model];
}

+ (int) getScreenWidth {
    CGRect rect = [[UIScreen mainScreen] bounds];
    return rect.size.width;
}

+ (int) getScreenHeight {
    CGRect rect = [[UIScreen mainScreen] bounds];
    return rect.size.height;
}

+ (int) getPPI {
    float scale = 1;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        scale = [[UIScreen mainScreen] scale];
    }
    
    float dpi = 160 * scale;
    
    return (int)dpi;
}

+ (NSString*) getCountryCode {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    NSString *country = [locale displayNameForKey: NSLocaleCountryCode value: countryCode];
    
    return country;
}

+ (NSString*) getLanguage {
    return [[NSLocale preferredLanguages] firstObject];
}

+ (NSString*) deviceName {
    return [[UIDevice currentDevice] name];
}

+ (unsigned long long) physicalMemoryByte {
    return [[NSProcessInfo processInfo] physicalMemory];
}

+ (u_int64_t) hardDiskSize {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        return fileSystemSizeInBytes.unsignedLongLongValue;
    } else {
        return 0;
    }
}

+ (NSString*) timeZone {
    return [NSTimeZone localTimeZone].name;    
}

+ (NSString*) userAgent {
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    return [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
}

+ (void) deviceTest {
    int nWidth = [DeviceUtils getScreenWidth];
    
    int nHeight = [DeviceUtils getScreenHeight];
    
    NSString* pszBoot = [DeviceUtils getBoot];
    NSLog(@"%@", pszBoot);
    
    int pszStartSec = [DeviceUtils getStartSec];
//    NSLog(@"%@", pszStartSec);
    
    NSString* pszUpdate = [DeviceUtils getUpdate];
    NSLog(@"%@", pszUpdate);
    
    NSString* pszOSVer = [DeviceUtils getOSVersion];
    NSLog(@"%@", pszOSVer);
    
    int nDPI = [DeviceUtils getPPI];
    NSLog(@"%@", pszOSVer);
    
    NSString* pszCountry = [DeviceUtils getCountryCode];
    
    [DeviceUtils getLanguage];
    
    [DeviceUtils deviceName];
    
    [DeviceUtils physicalMemoryByte];
    
    [DeviceUtils hardDiskSize];
    
    [DeviceUtils timeZone];
    
    [DeviceUtils userAgent];
    
}


@end
