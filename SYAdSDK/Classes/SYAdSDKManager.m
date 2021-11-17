
#import "SYAdSDKManager.h"

#import <BUAdSDK/BUAdSDK.h>
//#import <AppTrackingTransparency/AppTrackingTransparency.h>
//#import <AdSupport/AdSupport.h>

#import "log/SYLogUtils.h"

#import "SYAdSDKDefines.h"
#import "StringUtils.h"
#import "utils/UserInfoUtils.h"

@interface SYAdSDKManager ()

@end

static NSString* appID = nil;
static NSString* buAppID = nil;
static NSString* gdtAppID = nil;

static NSDictionary* dictConfig = nil;
static NSString* idfa = nil;

@implementation SYAdSDKManager

+ (NSDictionary*) dictConfig {
    return dictConfig;
}

+ (void) setDictConfig:(NSDictionary*)val {
    dictConfig = val;
}

+ (NSString*) idfa {
    return idfa;
}

+ (void) setIdfa:(NSString*)val {
    idfa = val;
}

+ (NSString*) buAppID {
    return buAppID;
}

+ (void) setBuAppID:(NSString*)val {
    buAppID = val;
}

+ (NSString*) gdtAppID {
    return gdtAppID;
}

+ (void) setGdtAppID:(NSString*)val {
    gdtAppID = val;
}

+ (void) initSDK:(NSString*)_idfa appID:(NSString *)appID level:(SYAdSDKLogLevel)level onInitFinish: (void (^)(BOOL bSuccess)) handler {
    [SYAdSDKManager setAppID:appID];
    [SYAdSDKManager setLoglevel:level];
    
    if (nil == idfa) {
        idfa = _idfa;
    }
    
#ifdef UPLOAD_USER_INFO
    [SYLogUtils uploadUserInfo:appID idfa:self.idfa];
#endif
    
#ifdef TEST_ENV
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://openapi.test.jiegames.com/SDKBase/getInitSdkConfig"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
#else
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://openapi.jiegames.com/SDKBase/getInitSdkConfig"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
#endif
    
    NSDictionary *headers = @{
        @"Content-Type": @"text/plain"
    };

    [request setAllHTTPHeaderFields:headers];
    NSString* body = [NSString stringWithFormat:@"{\"appId\": \"%@\", \"userId\": \"%@\"}", appID, idfa];
    NSData *postData = [[NSData alloc] initWithData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError != nil) {
            NSLog(@"%@", connectionError);
            handler(NO);
            return;
        }
        
#ifdef CRASH_TEST
//        data = nil;
        //1. test if data or response is null
//        response = nil;
        
        NSString* str  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
      
        str = @"{    \"msg\": \"successfull!\",    \"code\": \"200\",    \"data\": {        \"appConfig\": {            \"shiyu_open\": \"1\",            \"tt_open\": \"1\",            \"gdt_open\": \"1\",            \"gdt_appid\": \"1105344611\",            \"shiyu_secret\": \"0809cb5c3f6d4d4d8faaa50e20268d42\",            \"tt_appid\": \"513417\",            \"shiyu_appid\": \"MjUzMDU3MDAyNzU2\"        },        \"appId\": \"MjUzMDU3MDAyNzU2\",        \"clientIp\": \"222.190.22.241\",        \"slotInfo\": [            {                \"slotName\": \"IOS开屏\",                \"slotId\": 24011,                \"config\": [                    {                        \"resourceId\": 8,                        \"configParams\": {                            \"gdt_slot_id\": \"9040714184494018\",                            \"shiyu_slot_id\": \"24011\",                            \"splash_type\": \"8\"                        },                        \"resourceName\": \"广点通\",                        \"resourceType\": 1                    }                ]            },            {                \"slotName\": \"IOS轮播广告\",                \"slotId\": 24012,                \"config\": [                    {                        \"resourceId\": 8,                        \"configParams\": {                            \"gdt_slot_id\": \"1070493363284797\",                            \"shiyu_slot_id\": \"24012\"                        },                        \"resourceName\": \"广点通\",                        \"resourceType\": 1                    }                ]            },            {                \"slotName\": \"IOS Banner\",                \"slotId\": 24013,                \"config\": [                    {                        \"resourceId\": 8,                        \"configParams\": {                            \"gdt_slot_id\": \"1080958885885321\",                            \"shiyu_slot_id\": \"24013\"                        },                        \"resourceName\": \"广点通\",                        \"resourceType\": 1                    }                ]            },            {                \"slotName\": \"IOS插屏\",                \"slotId\": 24014,                \"config\": [                    {                        \"resourceId\": 8,                        \"configParams\": {                            \"gdt_slot_id\": \"1050652855580392\",                            \"shiyu_slot_id\": \"24014\"                        },                        \"resourceName\": \"广点通\",                        \"resourceType\": 1                    }                ]            }        ],        \"timestamp\": 1621999433084    }}";
        
        data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        
#endif
        //1. check if data is NULL
        if (nil == data || nil == response) {
            handler(NO);
            return;
        }
        
        //2. check status Code
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (200 != httpResponse.statusCode) {
            handler(NO);
            return;
        }
        
        //2. check if parse json success
        NSError *parseError = nil;
        NSDictionary *dictRet = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];

        if (parseError != nil || nil == dictRet) {
            handler(NO);
            return;
        }
        
        //3. check if code correct
        if (NO == [[dictRet allKeys] containsObject:@"code"]) {
            handler(NO);
            return;
        }
        
        if (nil == [dictRet objectForKey:@"code"]) {
            handler(NO);
            return;
        }
        
        if (NO == [[dictRet objectForKey:@"code"] isKindOfClass: [NSString class]]
            || NO == [@"200" isEqualToString:[dictRet objectForKey:@"code"]]) {
            handler(NO);
            return;
        }
        
        //4. check all data before use
        if (NO == [[dictRet allKeys] containsObject:@"data"]
            || nil == [dictRet objectForKey:@"data"]
            || [NSNull null] == [dictRet objectForKey:@"data"]) {
            handler(NO);
            return;
        }
        
        if (nil == [dictRet valueForKeyPath:@"data.appConfig"]
            || [NSNull null] == [dictRet valueForKeyPath:@"data.appConfig"]) {
            handler(NO);
            return;
        }
        
        if (nil == [dictRet valueForKeyPath:@"data.appConfig.gdt_appid"]
            || [NSNull null] == [dictRet valueForKeyPath:@"data.appConfig.gdt_appid"]) {
            handler(NO);
            return;
        }
        
        
        if (nil == [dictRet valueForKeyPath:@"data.slotInfo"]
            || [NSNull null] == [dictRet valueForKeyPath:@"data.slotInfo"]) {
            handler(NO);
            return;
        }
        
//            NSLog(@"%@", dictRet);
        
        dictConfig = dictRet;
        buAppID = dictConfig[@"data"][@"appConfig"][@"tt_appid"];
#ifdef TEST_FOR_BYTEDANCE
        buAppID = @"5234865";
#endif
        [BUAdSDKManager setAppID:buAppID];
        
        gdtAppID = [dictConfig valueForKeyPath:@"data.appConfig.gdt_appid"];
        if (nil == gdtAppID) {
            handler(NO);
            return;
        }
        
        if ([StringUtils isEmpty:gdtAppID]) {
            handler(NO);
            return;
        }
        
#ifdef TEST_FOR_GDT
        gdtAppID = @"1105344611";
#endif
        
//        BOOL result = [GDTSDKConfig registerAppId:gdtAppID];
//        if (NO == result) {
//            handler(NO);
//            return;
//
//        }
        
//            [BUAdSDKManager setCustomIDFA:idfa];
        
        handler(YES);

    }];
}

+ (NSString*) appID {
    return appID;
}

/**
 Register the App key that’s already been applied before requesting an ad from TikTok Audience Network.
 @param appID : the unique identifier of the App
 */
+ (void)setAppID:(NSString *)_appID {
    appID = _appID;
}
/**
 Configure development mode.
 @param level : default BUAdSDKLogLevelNone
 */
+ (void)setLoglevel:(SYAdSDKLogLevel)level {
    if (SYAdSDKLogLevelDebug == level) {
        [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
    } else if (SYAdSDKLogLevelError == level) {
        [BUAdSDKManager setLoglevel:BUAdSDKLogLevelError];
    } else {
        [BUAdSDKManager setLoglevel:BUOfflineTypeNone];
    }
}

/// Set the user's keywords, such as interests and hobbies, etc.
/// Must obtain the consent of the user before incoming.
+ (void)setUserKeywords:(NSString *)keywords {
    [BUAdSDKManager setUserKeywords:keywords];
}

/// set additional user information.
+ (void)setUserExtData:(NSString *)data {
    [BUAdSDKManager setUserExtData:data];
}

@end
