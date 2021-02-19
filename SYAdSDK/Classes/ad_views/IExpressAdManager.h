//
//  IExpressAdManager.h
//  Pods
//
//  Created by 王晓丰 on 2021/2/19.
//

#ifndef IExpressAdManager_h
#define IExpressAdManager_h

#import "SYAdSDKDefines.h"
#import <Foundation/Foundation.h>

@protocol IExpressAdManagerDelegate;

@protocol IExpressAdManager <NSObject>
@required
- (instancetype)initWithSlotID:(NSString *)slotID rootViewController:(UIViewController *)rootViewController adSize:(CGSize)size;
- (void)loadAdDataWithCount:(NSInteger)count;
- (void)setSYDelegate:(id<IExpressAdManagerDelegate>)delegate;
- (void)setRequestID:(NSString*)requestID;
@end

@protocol IExpressAdManagerDelegate <NSObject>

@optional

/**
 * Sent when views successfully load ad
 */
- (void)expressAdSuccessToLoad:(id<IExpressAdManager>) expressAd views:(NSArray<__kindof UIView *> *)views;

/**
 * Sent when views fail to load ad
 */
- (void)expressAdFailToLoad:(id<IExpressAdManager>)expressAd;

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)expressAdViewRenderSuccess:(UIView *)expressAdView;

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)expressAdViewRenderFail:(UIView *)expressAdView;

/**
 * Sent when an ad view is about to present modal content
 */
- (void)expressAdViewWillShow:(UIView *)expressAdView;

/**
 * Sent when an ad view is clicked
 */
- (void)expressAdViewDidClick:(UIView *)expressAdView;

/**
 * Sent when a player finished
 * @param error : error of player
 */
- (void)expressAdViewPlayerDidPlayFinish:(UIView *)expressAdView;

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)expressAdView:(UIView *)expressAdView;

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)expressAdViewWillPresentScreen:(UIView *)expressAdView;

@end


#endif /* IExpressAdManager_h */
