//
//  SYExpressAdManager.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SYExpressAdManager;
@class SYExpressAdView;

@protocol SYExpressAdViewDelegate <NSObject>

@optional
/**
 * Sent when views successfully load ad
 */
- (void)expressAdSuccessToLoad:(SYExpressAdManager *) expressAd views:(NSArray<__kindof SYExpressAdView *> *)views;

/**
 * Sent when views fail to load ad
 */
- (void)expressAdFailToLoad:(SYExpressAdManager *)expressAd;

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)expressAdViewRenderSuccess:(SYExpressAdView *)expressAdView;

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)expressAdViewRenderFail:(SYExpressAdView *)expressAdView;

/**
 * Sent when an ad view is about to present modal content
 */
- (void)expressAdViewWillShow:(SYExpressAdView *)expressAdView;

/**
 * Sent when an ad view is clicked
 */
- (void)expressAdViewDidClick:(SYExpressAdView *)expressAdView;

/**
 * Sent when a player finished
 * @param error : error of player
 */
- (void)expressAdViewPlayerDidPlayFinish:(SYExpressAdView *)expressAdView;

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)expressAdView:(SYExpressAdView *)expressAdView;

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)expressAdViewWillPresentScreen:(SYExpressAdView *)expressAdView;

@end

@interface SYExpressAdManager : NSObject

@property (nonatomic, copy, nonnull) NSString *slotID;
@property (nonatomic, weak, nullable) id<SYExpressAdViewDelegate> delegate;
@property (nonatomic, strong) UIViewController *rootViewController;


/**
 @param size expected ad view size，when size.height is zero, acture height will match size.width
 */
- (instancetype)initWithSlotID:(NSString *)slotID rootViewController:(UIViewController *)rootViewController adSize:(CGSize)size;

/**
 The number of ads requested,The maximum is 3
 */
- (void)loadAdDataWithCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
