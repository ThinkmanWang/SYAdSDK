//
//  IBannerView.h
//  Pods
//
//  Created by 王晓丰 on 2021/2/18.
//

#ifndef IBannerView_h
#define IBannerView_h

#import "SYAdSDKDefines.h"

@protocol ISYBannerViewDelegate;

@protocol IBannerView <NSObject>
@required
- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(SYBannerSize)adsize;

- (void)loadAdData;
- (CGRect)getFrame;
- (void)setSYDelegate:(id<ISYBannerViewDelegate>)delegate;
- (void)setRequestID:(NSString*)requestID;
@end

@protocol ISYBannerViewDelegate <NSObject>

@optional

/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 */
- (void)bannerAdViewDidLoad:(id<IBannerView>)bannerAdView;

/**
 This method is called when bannerAdView ad slot failed to load.
 */
- (void)bannerAdViewLoadFailed:(id<IBannerView>)bannerAdView;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)bannerAdViewRenderSuccess:(id<IBannerView>)bannerAdView;

/**
 This method is called when a nativeExpressAdView failed to render.
 */
- (void)bannerAdViewRenderFail:(id<IBannerView>)bannerAdView;

/**
 This method is called when bannerAdView ad slot showed new ad.
 */
- (void)bannerAdViewWillBecomVisible:(id<IBannerView>)bannerAdView;

/**
 This method is called when bannerAdView is clicked.
 */
- (void)bannerAdViewDidClick:(id<IBannerView>)bannerAdView;

@end


#endif /* IBannerView_h */
