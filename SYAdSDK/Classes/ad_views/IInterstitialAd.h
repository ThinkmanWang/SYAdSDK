//
//  IInterstitialAd.h
//  Pods
//
//  Created by 王晓丰 on 2021/2/19.
//

#ifndef IInterstitialAd_h
#define IInterstitialAd_h

#import "SYAdSDKDefines.h"

@protocol IInterstitialAdDelegate;

@protocol IInterstitialAd <NSObject>
@required
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

- (void)setSYDelegate:(id<IInterstitialAdDelegate>)delegate;
- (void)setRequestID:(NSString*)requestID;

@end

@protocol IInterstitialAdDelegate <NSObject>
@optional
/**
 This method is called when interstitial ad material loaded successfully.
 */
- (void)interstitialAdDidLoad:(id<IInterstitialAd>)interstitialAd;

/**
 This method is called when interstitial ad material failed to load.
 */
- (void)interstitialAd:(id<IInterstitialAd>)interstitialAd;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)interstitialAdRenderSuccess:(id<IInterstitialAd>)interstitialAd;

/**
 This method is called when a nativeExpressAdView failed to render.
 */
- (void)interstitialAdRenderFail:(id<IInterstitialAd>)interstitialAd;

/**
 This method is called when interstitial ad slot will be showing.
 */
- (void)interstitialAdWillVisible:(id<IInterstitialAd>)interstitialAd;

/**
 This method is called when interstitial ad is clicked.
 */
- (void)interstitialAdDidClick:(id<IInterstitialAd>)interstitialAd;

/**
 This method is called when interstitial ad is about to close.
 */
- (void)interstitialAdWillClose:(id<IInterstitialAd>)interstitialAd;

/**
 This method is called when interstitial ad is closed.
 */
- (void)interstitialAdDidClose:(id<IInterstitialAd>)interstitialAd;
@end


#endif /* IInterstitialAd_h */
