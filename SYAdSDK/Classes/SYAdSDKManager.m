
#import "SYAdSDKManager.h"

#import <BUAdSDK/BUAdSDK.h>
//#import <AppTrackingTransparency/AppTrackingTransparency.h>
//#import <AdSupport/AdSupport.h>

#import "log/SYLogUtils.h"

#import "gdt/GDTSplashAd.h"

@interface SYAdSDKManager ()
+(NSString*) buAppID;
@end

static NSString* appID = nil;
static NSString* buAppID = nil;
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

+ (void) initSDK:(NSString*)_idfa appID:(NSString *)appID level:(SYAdSDKLogLevel)level onInitFinish: (void (^)(BOOL bSuccess)) handler {
    [SYAdSDKManager setAppID:appID];
    [SYAdSDKManager setLoglevel:level];
    
    if (nil == idfa) {
        idfa = _idfa;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://openapi.jiegames.com/Advertise/getSdkSlotResourceConfig"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSDictionary *headers = @{
        @"Content-Type": @"text/plain"
    };

    [request setAllHTTPHeaderFields:headers];
    NSString* body = [NSString stringWithFormat:@"{\"appId\": \"%@\", \"userId\": \"%@\"}", appID, idfa];
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
//            NSLog(@"%@", dictRet);
            
            dictConfig = dictRet;
            buAppID = dictConfig[@"data"][@"appConfig"][@"tt_appid"];
            [BUAdSDKManager setAppID:buAppID];
//            [BUAdSDKManager setCustomIDFA:idfa];
        }
        
        handler(connectionError == nil);
            
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
