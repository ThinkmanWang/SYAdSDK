//
//  AdUtils.m
//  Masonry
//
//  Created by 王晓丰 on 2021/11/22.
//

#import "SYAdUtils.h"
#import "SYAdSDKManager.h"
#import "StringUtils.h"
#import "DeviceUtils.h"
#import "UserInfoUtils.h"
#import "SYLogUtils.h"

@interface SYAdUtils ()

@end

@implementation SYAdUtils

+ (NSString *)uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString* uuid = [NSString stringWithString:(__bridge NSString* )uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

+ (NSString*) mkRequestID {
    return [[SYAdUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};

    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range];

    return mutStr;
}

+ (NSString*) mkSign {
    NSString* pszBase = [NSString stringWithFormat:@"%@%@%@", SYAdSDKManager.idfa, SYAdSDKManager.syAppID, SYAdSDKManager.sySecret];
    
    return [UserInfoUtils MD5String: pszBase];
}

+ (void) getSYAd:(NSString*)pszSlotId nAdCount:(int)nAdCount onSuccess:(void (^)(NSDictionary* dictResp)) successHandler {
    
    if ([StringUtils isEmpty:pszSlotId]) {
        successHandler(nil);
        return;
    }
    
    NSString* pszAppID = SYAdSDKManager.syAppID;
    if ([StringUtils isEmpty:pszAppID]) {
        successHandler(nil);
        return;
    }
    
    @try {
        NSDictionary* dictData = @{
            @"request_id": [SYAdUtils mkRequestID],
            @"api_version": @"2.0",
            @"device": @{
                @"device_type": @"PHONE",
                @"os_type": @"1",
                @"ua": [DeviceUtils userAgent],
                @"os_version": [DeviceUtils getOSVersion],
                @"vendor": @"APPLE",
                @"model": [DeviceUtils getDeviceType],
                @"screen_width": [NSNumber numberWithInt:[DeviceUtils getScreenWidth]],
                @"screen_height": [NSNumber numberWithInt:[DeviceUtils getScreenHeight]],
                @"user_id": SYAdSDKManager.idfa
            },
            @"uuid": @{
                @"idfa": SYAdSDKManager.idfa,
                @"idfa_md5": [UserInfoUtils MD5String: SYAdSDKManager.idfa]
            },
            @"network": @{
                @"connection_type": [NSNumber numberWithInt:-1],
                @"operator_type": [NSNumber numberWithInt:-1],
                @"mac": @"00:00:00:00:00:00"
            },
            @"wifi": @[],
            @"gps": @{},
            @"business": @{
                @"business_id": SYAdSDKManager.syAppID,
                @"slot_id": pszSlotId,
                @"sign": [SYAdUtils mkSign],
                @"ad_count": [NSNumber numberWithInt:nAdCount]
            },
            @"audience_profile": @{}
        };
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://openapi.jiegames.com/Advertise/getAd"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        NSDictionary *headers = @{
            @"Content-Type": @"text/plain"
        };

        [request setAllHTTPHeaderFields:headers];
        //NSLog([SYLogUtils convertToJsonData:dictData]);
        NSString* body = [NSString stringWithFormat:@"%@", [SYLogUtils convertToJsonData:dictData]];
        NSData *postData = [[NSData alloc] initWithData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postData];
        [request setHTTPMethod:@"POST"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (connectionError) {
                NSLog(@"%@", connectionError);
            } else {
                if (nil == response) {
                    successHandler(nil);
                    return;
                }
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                if (200 != httpResponse.statusCode) {
                    successHandler(nil);
                    return;
                }
                
                if (nil == data) {
                    successHandler(nil);
                    return;
                }
                
                NSString* str  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@", str);
                
                NSError *parseError = nil;
                NSDictionary *dictRet = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                if (parseError != nil) {
                    successHandler(nil);
                    return;
                }
                                                
                if (successHandler) {
                    successHandler(dictRet);
                }
            }
            
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@: %@",exception.name, exception.reason);
        successHandler(nil);
        return;
    } @finally {
        
    }
}

@end
