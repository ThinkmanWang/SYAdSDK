//
//  SYLogUtils.h
//  AFNetworking
//
//  Created by 王晓丰 on 2021/1/29.
//

#ifndef SYLogUtils_h
#define SYLogUtils_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYLogUtils : NSObject

+ (NSString *)uuidString;
+ (NSString*) mkRequestID;
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

+ (void) report:(NSString*) pszSlotID requestID:(NSString*) pszRequestId type:(int) nType ;
+ (void) report:(NSString*) pszSlotID sourceId:(int) nSourceID type:(int) nType ;
+ (void) report:(NSString*) pszSlotID requestID:(NSString*) pszRequestId sourceId:(int) nSourceID type:(int) nType ;
+ (void) report:(NSString*) pszSlotID requestID:(NSString*) pszRequestId sourceId:(int) nSourceID type:(int) nType adCount:(int) nAdCount ;

+ (void) uploadUserInfo:(NSString*) pszAppId idfa:(NSString*) pszIdfa;


@end

NS_ASSUME_NONNULL_END

#endif
