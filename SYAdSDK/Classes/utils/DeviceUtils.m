//
//  DeviceUtils.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/19.
//

#import "DeviceUtils.h"

#import <sys/stat.h>
#import <sys/sysctl.h>

@implementation DeviceUtils

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

@end
