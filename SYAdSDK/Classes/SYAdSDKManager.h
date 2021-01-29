
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SYAdSDKDefines.h"

@interface SYAdSDKManager : NSObject

+ (NSString *)appID;
+ (NSDictionary*) dictConfig;

+ (void) initSSDK:(NSString *)appID level:(SYAdSDKLogLevel)level onInitFinish: (void (^)(BOOL bSuccess)) handler;

///**
// Register the App key that’s already been applied before requesting an ad from TikTok Audience Network.
// @param appID : the unique identifier of the App
// */
//+ (void)setAppID:(NSString *)appID;
///**
// Configure development mode.
// @param level : default BUAdSDKLogLevelNone
// */
//+ (void)setLoglevel:(SYAdSDKLogLevel)level;
//
///// Set the user's keywords, such as interests and hobbies, etc.
///// Must obtain the consent of the user before incoming.
//+ (void)setUserKeywords:(NSString *)keywords;
//
///// set additional user information.
//+ (void)setUserExtData:(NSString *)data;



@end
