//
//  SYLogUtils.h
//  AFNetworking
//
//  Created by 王晓丰 on 2021/1/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYLogUtils : NSObject

+ (NSString *)uuidString;

+ (void) report:(NSString*) pszSlotID sourceId:(int) nSourceID type:(int) nType ;
+ (void) report:(NSString*) pszSlotID requestID:(NSString*) pszRequestId sourceId:(int) nSourceID type:(int) nType ;
+ (void) report:(NSString*) pszSlotID requestID:(NSString*) pszRequestId sourceId:(int) nSourceID type:(int) nType adCount:(int) nAdCount ;


@end

NS_ASSUME_NONNULL_END
