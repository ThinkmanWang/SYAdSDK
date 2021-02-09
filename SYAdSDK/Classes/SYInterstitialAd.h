//
//  SYInterstitialAd.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/1/26.
//

#ifndef SYInterstitialAd_h
#define SYInterstitialAd_h

#import <Foundation/Foundation.h>
#import "SYAdSDKDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class SYInterstitialAd;

@protocol SYInterstitialAdDelegate <NSObject>
@optional
/**
 This method is called when interstitial ad material loaded successfully.
 */
- (void)interstitialAdDidLoad:(SYInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad material failed to load.
 */
- (void)interstitialAd:(SYInterstitialAd *)interstitialAd;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)interstitialAdRenderSuccess:(SYInterstitialAd *)interstitialAd;

/**
 This method is called when a nativeExpressAdView failed to render.
 */
- (void)interstitialAdRenderFail:(SYInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad slot will be showing.
 */
- (void)interstitialAdWillVisible:(SYInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad is clicked.
 */
- (void)interstitialAdDidClick:(SYInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad is about to close.
 */
- (void)interstitialAdWillClose:(SYInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad is closed.
 */
- (void)interstitialAdDidClose:(SYInterstitialAd *)interstitialAd;
 
@end

@interface SYInterstitialAd : NSObject

@property (nonatomic, weak, nullable) id<SYInterstitialAdDelegate> delegate;

- (instancetype)initWithSlotID:(NSString *)slotID adSize:(SYInterstitialAdSize)adsize;

/**
 Load interstitial ad datas.
 */
- (void)loadAdData;

/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;


@end

NS_ASSUME_NONNULL_END

#endif
