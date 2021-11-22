//
//  AdUtils.h
//  Masonry
//
//  Created by 王晓丰 on 2021/11/22.
//

#ifndef AdUtils_h
#define AdUtils_h

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <zlib.h>
#import <mach/mach.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdUtils : NSObject

+ (void) getAd:(NSString*)pszSlotId nAdCount:(int)nAdCount onSuccess:(void (^)(NSString* pszResp)) successHandler onFailed:(void (^)(NSString* pszResp)) failHandler;

@end

NS_ASSUME_NONNULL_END

#endif
