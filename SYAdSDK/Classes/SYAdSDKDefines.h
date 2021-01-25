
#ifndef BUAdSDK_DEFINES_h
#define BUAdSDK_DEFINES_h

#import <Foundation/Foundation.h>
#include <CoreGraphics/CGBase.h>

typedef NS_ENUM(NSInteger, SYAdSDKLogLevel) {
    SYAdSDKLogLevelNone,
    SYAdSDKLogLevelError,
    SYAdSDKLogLevelDebug
};

typedef NS_ENUM(NSInteger, SYBannerSize) {
    SYBannerSize600_300
    , SYBannerSize600_400
    , SYBannerSize600_500
    , SYBannerSize600_260
    
    , SYBannerSize600_90
    , SYBannerSize600_150
    , SYBannerSize640_100
    , SYBannerSize690_388
};

#endif
