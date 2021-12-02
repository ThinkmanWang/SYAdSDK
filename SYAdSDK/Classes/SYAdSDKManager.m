
#import "SYAdSDKManager.h"

#import <BUAdSDK/BUAdSDK.h>
//#import <AppTrackingTransparency/AppTrackingTransparency.h>
//#import <AdSupport/AdSupport.h>
#import <sys/stat.h>

#import "log/SYLogUtils.h"

#import "SYAdSDKDefines.h"
#import "StringUtils.h"
#import "UserInfoUtils.h"
#import "DeviceUtils.h"
#import "SYAdUtils.h"

@interface SYAdSDKManager ()

@end

static NSString* appID = nil;

static NSString* buAppID = nil;
static NSString* buOpen = nil;

static NSString* gdtAppID = nil;
static NSString* gdtOpen = nil;

static NSString* syAppID = nil;
static NSString* sySecret = nil;
static NSString* syOpen = nil;

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

+ (NSString*) buOpen {
    return buOpen;
}

+ (void) setBuOpen:(NSString*)val {
    buOpen = val;
}

+ (NSString*) gdtAppID {
    return gdtAppID;
}

+ (void) setGdtAppID:(NSString*)val {
    gdtAppID = val;
}

+ (NSString*) gdtOpen {
    return gdtOpen;
}

+ (void) setGdtOpen:(NSString*)val {
    gdtOpen = val;
}

+ (NSString*) syAppID {
    return syAppID;
}

+ (NSString*) sySecret {
    return sySecret;
}

+ (NSString*) syOpen {
    return syOpen;
}

+ (void) setSyOpen:(NSString*)val {
    syOpen = val;
}

+ (void) setSyAppID:(NSString*)val {
    syAppID = val;
}

+ (void) setSySecret:(NSString*)val {
    sySecret = val;
}

+ (void) initSDK:(NSString*)_idfa appID:(NSString *)appID level:(SYAdSDKLogLevel)level onInitFinish: (void (^)(BOOL bSuccess)) handler {
    [SYAdSDKManager setAppID:appID];
    [SYAdSDKManager setLoglevel:level];
    
    if (nil == idfa) {
        idfa = _idfa;
    }

#ifdef TEST_DEVICE_UTILS
    [DeviceUtils deviceTest];
#endif
    
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
        
#ifdef CRASH_TEST_CODE_NOT_EXISTS
        str = @"{\"msg\": \"successfull!\", \"code\": \"200\"}";
#endif
        
#ifdef CRASH_TEST_RET_NULL
        str = nil;
#endif
        
#ifdef CRASH_TEST_RESPONSE_NULL
        response = nil;
#endif
        
#ifdef CRASH_TEST_JSON_STRING_INCORRECT
        str = @"123";
#endif
        
#ifdef CRASH_TEST_DATA_NULL
        str = @"{    \"msg\": \"successfull!\",    \"code\": \"200\",    \"data\": null}";
#endif
        
#ifdef CRASH_TEST_APPCONFIG_NULL
//        str = @"{\"msg\":\"successfull!\",\"code\":\"200\",\"data\":{\"appConfig\":null,\"appId\":\"MTc4NDUwMjQ4MDku\",\"clientIp\":\"222.190.72.182\",\"slotInfo\":[{\"slotName\":\"穿山甲IOS开屏\",\"showType\":1,\"slotId\":24032,\"config\":[{\"resourceId\":9,\"configParams\":{\"shiyu_slot_id\":\"24011\",\"tt_slot_id\":\"887620349\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]},{\"slotName\":\"穿山甲IOS测试-Banner\",\"showType\":2,\"slotId\":24033,\"config\":[{\"resourceId\":9,\"configParams\":{\"shiyu_slot_id\":\"24013\",\"tt_slot_id\":\"947093826\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]},{\"slotName\":\"穿山甲IOS测试-插屏\",\"showType\":3,\"slotId\":24034,\"config\":[{\"resourceId\":9,\"configParams\":{\"shiyu_slot_id\":\"24014\",\"tt_slot_id\":\"947093633\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]},{\"slotName\":\"穿山甲IOS测试-原生\",\"showType\":6,\"slotId\":24035,\"config\":[{\"resourceId\":9,\"configParams\":{\"shiyu_slot_id\":\"24012\",\"tt_slot_id\":\"947096614\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]},{\"slotName\":\"穿山甲IOS测试-激励视频\",\"showType\":9,\"slotId\":24040,\"config\":[{\"resourceId\":9,\"configParams\":{\"tt_slot_id\":\"947191441\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]}],\"timestamp\":1638409585431}}";
        str = @"{\"msg\":\"successfull!\",\"code\":\"200\",\"data\":{\"appConfig\":{},\"appId\":\"MTc4NDUwMjQ4MDku\",\"clientIp\":\"222.190.72.182\",\"slotInfo\":[{\"slotName\":\"穿山甲IOS开屏\",\"showType\":1,\"slotId\":24032,\"config\":[{\"resourceId\":9,\"configParams\":{\"shiyu_slot_id\":\"24011\",\"tt_slot_id\":\"887620349\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]},{\"slotName\":\"穿山甲IOS测试-Banner\",\"showType\":2,\"slotId\":24033,\"config\":[{\"resourceId\":9,\"configParams\":{\"shiyu_slot_id\":\"24013\",\"tt_slot_id\":\"947093826\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]},{\"slotName\":\"穿山甲IOS测试-插屏\",\"showType\":3,\"slotId\":24034,\"config\":[{\"resourceId\":9,\"configParams\":{\"shiyu_slot_id\":\"24014\",\"tt_slot_id\":\"947093633\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]},{\"slotName\":\"穿山甲IOS测试-原生\",\"showType\":6,\"slotId\":24035,\"config\":[{\"resourceId\":9,\"configParams\":{\"shiyu_slot_id\":\"24012\",\"tt_slot_id\":\"947096614\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]},{\"slotName\":\"穿山甲IOS测试-激励视频\",\"showType\":9,\"slotId\":24040,\"config\":[{\"resourceId\":9,\"configParams\":{\"tt_slot_id\":\"947191441\"},\"resourceName\":\"穿山甲\",\"resourceType\":2}]}],\"timestamp\":1638409585431}}";
#endif
        
#ifdef CRASH_TEST_SLOTINFO_EMPTY
        str = @"{\"msg\":\"successfull!\",\"code\":\"200\",\"data\":{\"appConfig\":{\"shiyu_open\":\"1\",\"tt_open\":\"1\",\"gdt_open\":\"0\",\"gdt_appid\":\"1105344611\",\"shiyu_secret\":\"0809cb5c3f6d4d4d8faaa50e20268d42\",\"tt_appid\":\"5234865\",\"shiyu_appid\":\"MjUzMDU3MDAyNzU2\"},\"appId\":\"MTc4NDUwMjQ4MDku\",\"clientIp\":\"222.190.72.182\",\"slotInfo\":[{},{},{},{},{}],\"timestamp\":1638409585431}}";
#endif
        
        
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
        
//        if (nil == [dictRet valueForKeyPath:@"data.appConfig.gdt_appid"]
//            || [NSNull null] == [dictRet valueForKeyPath:@"data.appConfig.gdt_appid"]) {
//            handler(NO);
//            return;
//        }
        
        
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
        if (nil != buAppID && [@"1" isEqualToString:dictConfig[@"data"][@"appConfig"][@"tt_open"]]) {
            [BUAdSDKManager setAppID:buAppID];
        }
        
        syAppID = dictConfig[@"data"][@"appConfig"][@"shiyu_appid"];
        sySecret = dictConfig[@"data"][@"appConfig"][@"shiyu_secret"];
        
//        gdtAppID = [dictConfig valueForKeyPath:@"data.appConfig.gdt_appid"];
//        if (nil == gdtAppID) {
//            handler(NO);
//            return;
//        }
//
//        if ([StringUtils isEmpty:gdtAppID]) {
//            handler(NO);
//            return;
//        }
        
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
