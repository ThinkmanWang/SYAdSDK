//
//  SYLogUtils.m
//  AFNetworking
//
//  Created by 王晓丰 on 2021/1/29.
//

#import "SYLogUtils.h"
#import "../SYAdSDKManager.h"

@implementation SYLogUtils

+ (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString* uuid = [NSString stringWithString:(__bridge NSString* )uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
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

    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;
}

+ (void) report:(NSString*) pszUserID slotId:(NSString*) pszSlotID sourceId:(NSNumber*) nSourceID type:(NSNumber*) nType {
    NSString* pszRequestId = [SYLogUtils uuidString];
    NSString* pszAppID = SYAdSDKManager.appID;
    NSNumber* nTimestamp = [NSNumber numberWithUnsignedLong:[[NSDate date] timeIntervalSince1970]*1000];
    NSNumber* nOSType = [NSNumber numberWithInt:1];
    NSNumber* nInteractionType = [NSNumber numberWithInt:2];
 
    NSDictionary* dictData = @{
        @"requestId": pszRequestId
        , @"appId": pszAppID
        , @"slotId": pszSlotID
        , @"sourceId": nSourceID
        , @"type": nType
        , @"timestamp": nTimestamp
        , @"userId": SYAdSDKManager.idfa
        , @"osType": @"1"
        , @"interactionType": nInteractionType
    };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://openapi.jiegames.com/Advertise/getSdkSlotResourceConfig"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSDictionary *headers = @{
        @"Content-Type": @"text/plain"
    };

    [request setAllHTTPHeaderFields:headers];
    NSString* body = [SYLogUtils convertToJsonData:dictData];
    NSData *postData = [[NSData alloc] initWithData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            NSLog(@"%@", connectionError);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSError *parseError = nil;
            NSDictionary *dictRet = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"%@", dictRet);
        }
        
    }];
}


@end
