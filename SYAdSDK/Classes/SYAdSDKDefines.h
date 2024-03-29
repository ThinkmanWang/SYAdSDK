
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

#define UPLOAD_USER_INFO

//#define TEST_SY_SPLASH_DADI
//#define TEST_DEVICE_UTILS
//#define TEST_REWARDED_VIDEO
//#define TEST_SY_AD
//#define TEST_SY_AD_ONLY
//#define CRASH_TEST_SY_AD_NO_AD
//#define CRASH_TEST_SY_AD_ADS_EMPTY
//#define CRASH_TEST_SY_AD_ADS_EMPTY_DICT
//#define TEST_SPLASH_SHAKE
//#define TEST_DOWNLOAD_APP
//#define TEST_DEEPLINK
//#define TEST_FOR_BYTEDANCE
//#define USE_CIRCLE_PROGREESS_BUTTON

//#define TEST_ENV

//#define TEST_FOR_GDT


//#define CRASH_TEST

//#define CRASH_TEST_CODE_NOT_EXISTS
//#define CRASH_TEST_RET_NULL
//#define CRASH_TEST_RESPONSE_NULL
//#define CRASH_TEST_JSON_STRING_INCORRECT
//#define CRASH_TEST_DATA_NULL
//#define CRASH_TEST_APPCONFIG_NULL
//#define CRASH_TEST_SLOTINFO_EMPTY

#endif
