//
//  SYLogUtils.m
//  AFNetworking
//
//  Created by 王晓丰 on 2021/1/29.
//

#import "SYLogUtils.h"
#import "SYAdSDKManager.h"
#import "SYAdSDKDefines.h"
#import "UserInfoUtils.h"
#import "StringUtils.h"

@implementation SYLogUtils

+ (NSString *)uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString* uuid = [NSString stringWithString:(__bridge NSString* )uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

+ (NSString*) mkRequestID {
    return [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
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

    //去掉字符串中的空格
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range];

    return mutStr;
}

+ (void) report:(NSString*) pszSlotID requestID:(NSString*) pszRequestId type:(int) nType {
    [SYLogUtils report:pszSlotID requestID:pszRequestId sourceId:-1 type:nType];
}

+ (void) report:(NSString*) pszSlotID sourceId:(int) nSourceID type:(int) nType {
    NSString* pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    [SYLogUtils report:pszSlotID requestID:pszRequestId sourceId:nSourceID type:nType];
}

+ (void) report:(NSString*) pszSlotID requestID:(NSString*) pszRequestId sourceId:(int) nSourceID type:(int) nType {
    [SYLogUtils report:pszSlotID requestID:pszRequestId sourceId:nSourceID type:nType adCount:1];
}

+ (void) report:(NSString*) pszSlotID requestID:(NSString*) pszRequestId sourceId:(int) nSourceID type:(int) nType adCount:(int) nAdCount {
    if (nil == pszSlotID || nil == pszRequestId) {
        return;
    }
    
    if ([StringUtils isEmpty:SYAdSDKManager.idfa]) {
        return;
    }

    NSString* pszAppID = SYAdSDKManager.appID;
    if ([StringUtils isEmpty:pszAppID]) {
        return;
    }
    
    @try {
        NSNumber* nTimestamp = [NSNumber numberWithUnsignedLong:[[NSDate date] timeIntervalSince1970]*1000];
        NSNumber* nOSType = [NSNumber numberWithInt:1];
        NSNumber* nInteractionType = [NSNumber numberWithInt:2];
        
        NSString* pszSourceID = @"";
        if (nSourceID > -1) {
            pszSourceID = [NSString stringWithFormat:@"%d", nSourceID];
        } else {
            pszSourceID = [NSNull null];
        }
        
        NSDictionary* dictData = @{
            @"appId": pszAppID
            , @"sdkId": @""
            , @"pluginId": @""
            , @"userId": SYAdSDKManager.idfa
            , @"logInfo": @{
                    @"requestId": pszRequestId
                    , @"appId": pszAppID
                    , @"slotId": pszSlotID
                    , @"sourceId": pszSourceID
                    , @"type": [NSNumber numberWithInt:nType]
                    , @"timestamp": nTimestamp
                    , @"userId": SYAdSDKManager.idfa
                    , @"osType": @"1"
                    , @"interactionType": nInteractionType
                    , @"adCount": [NSNumber numberWithInt:nAdCount]
                }
            , @"logType": @"palmar_info_message"
            , @"timestamp": nTimestamp
        };
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://openapi.jiegames.com/logger/logInfoUpload"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        NSDictionary *headers = @{
            @"Content-Type": @"text/plain"
        };

        [request setAllHTTPHeaderFields:headers];
        //NSLog([SYLogUtils convertToJsonData:dictData]);
        NSString* body = [NSString stringWithFormat:@"[%@]", [SYLogUtils convertToJsonData:dictData]];
        NSData *postData = [[NSData alloc] initWithData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postData];
        [request setHTTPMethod:@"POST"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (connectionError) {
                NSLog(@"%@", connectionError);
            } else {
                if (nil == response) {
                    return;
                }
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSError *parseError = nil;
                NSDictionary *dictRet = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                NSLog(@"%@", dictRet);
            }
            
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@: %@",exception.name, exception.reason);
        return;
    } @finally {
        
    }
    
}

+ (void) uploadUserInfo:(NSString*) pszAppId idfa:(NSString*) pszIdfa {
    
    if ([StringUtils isEmpty:pszAppId] || [StringUtils isEmpty:pszIdfa]) {
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://openapi.jiegames.com/logger/uploadAdSdkUserInfo"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSDictionary *headers = @{
        @"Content-Type": @"text/plain"
    };

    [request setAllHTTPHeaderFields:headers];
    //NSLog([SYLogUtils convertToJsonData:dictData]);
    NSString* pszBody = [UserInfoUtils mkJSON:pszAppId idfa:pszIdfa];
//    NSLog(@"%@", pszBody);
    if ([StringUtils isEmpty:pszBody]) {
        return;
    }
    
    NSData *postData = [[NSData alloc] initWithData:[pszBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            NSLog(@"%@", connectionError);
        } else {
            if (nil == response) {
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSError *parseError = nil;
            NSDictionary *dictRet = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"%@", dictRet);
        }
        
    }];
    
    
}


@end
