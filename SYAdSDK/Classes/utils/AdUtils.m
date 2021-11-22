//
//  AdUtils.m
//  Masonry
//
//  Created by 王晓丰 on 2021/11/22.
//

#import "AdUtils.h"
#import "SYAdSDKManager.h"

@interface AdUtils ()

@end

@implementation AdUtils

+ (NSString *)uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString* uuid = [NSString stringWithString:(__bridge NSString* )uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

+ (NSString*) mkRequestID {
    return [[AdUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
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

+ (void) getAd:(NSString*)pszSlotId nAdCount:(int)nAdCount onSuccess:(void (^)(NSString* pszResp)) successHandler onFailed:(void (^)(NSString* pszResp)) failHandler {
    
}

@end
