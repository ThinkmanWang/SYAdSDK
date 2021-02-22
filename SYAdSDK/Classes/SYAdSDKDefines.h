
#ifndef SYAdSDK_DEFINES_h
#define SYAdSDK_DEFINES_h

#import <Foundation/Foundation.h>
//#import <Foundation/Foundation.h>
//#import <CoreGraphics/CGBase.h>

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

typedef NS_ENUM(NSInteger, SYInterstitialAdSize) {
    SYInterstitialAdSize600_600
    , SYInterstitialAdSize600_900
};

#define TEST_FOR_GDT


#endif
