//
//  ISplashAdView.h
//  Pods
//
//  Created by 王晓丰 on 2021/2/8.
//

#ifndef ISplashAdView_h
#define ISplashAdView_h

@protocol ISplashAdView <NSObject>
@required
- (instancetype)initWithSlotID:(NSString *)slotID;
- (void)loadAdData;

@end



@protocol ISplashAdViewDelegate <NSObject>

@optional
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)splashAdDidLoad:(id<ISplashAdView>)splashAd;

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)splashAd:(id<ISplashAdView>)splashAd;

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(id<ISplashAdView>)splashAd;

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(id<ISplashAdView>)splashAd;

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(id<ISplashAdView>)splashAd;

/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(id<ISplashAdView>)splashAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashAdDidCloseOtherController:(id<ISplashAdView>)splashAd;

/**
 This method is called when spalashAd skip button  is clicked.
 */
- (void)splashAdDidClickSkip:(id<ISplashAdView>)splashAd;

/**
 This method is called when spalashAd countdown equals to zero
 */
- (void)splashAdCountdownToZero:(id<ISplashAdView>)splashAd;

@end

#endif /* ISplashAdView_h */
