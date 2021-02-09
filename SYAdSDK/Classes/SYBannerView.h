//
//  SYBannerView.h
//  SYAdSSDK
//
//  Created by 王晓丰 on 2021/1/25.
//

#ifndef SYBannerView_h
#define SYBannerView_h

#import <UIKit/UIKit.h>

#import "SYAdSDKDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class SYBannerView;

@protocol SYBannerViewDelegate <NSObject>

@optional

/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 */
- (void)bannerAdViewDidLoad:(SYBannerView *)bannerAdView;

/**
 This method is called when bannerAdView ad slot failed to load.
 */
- (void)bannerAdViewLoadFailed:(SYBannerView *)bannerAdView;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)bannerAdViewRenderSuccess:(SYBannerView *)bannerAdView;

/**
 This method is called when a nativeExpressAdView failed to render.
 */
- (void)bannerAdViewRenderFail:(SYBannerView *)bannerAdView;

/**
 This method is called when bannerAdView ad slot showed new ad.
 */
- (void)bannerAdViewWillBecomVisible:(SYBannerView *)bannerAdView;

/**
 This method is called when bannerAdView is clicked.
 */
- (void)bannerAdViewDidClick:(SYBannerView *)bannerAdView;

@end

@interface SYBannerView : UIView

@property (nonatomic, weak, nullable) id<SYBannerViewDelegate> delegate;

- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(SYBannerSize)adsize;

- (void)loadAdData;

@end

NS_ASSUME_NONNULL_END

#endif
