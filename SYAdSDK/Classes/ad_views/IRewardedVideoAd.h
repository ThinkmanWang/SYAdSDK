//
//  IRewardedVideoAd.h
//  Pods
//
//  Created by 王晓丰 on 2021/11/29.
//

#ifndef IRewardedVideoAd_h
#define IRewardedVideoAd_h

@class SYRewardedVideoModel;

@protocol IRewardedVideoAd <NSObject>

- (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(SYRewardedVideoModel *)model;
- (void)loadAdData;
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end


@protocol IRewardedVideoAdDelegate <NSObject>

@optional

/**
 This method is called when video ad material loaded successfully.
 */
- (void)rewardedVideoAdDidLoad:(id<IRewardedVideoAd>)rewardedVideoAd;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)rewardedVideoAd:(id<IRewardedVideoAd>)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 This method is called when video cached successfully.
 */
- (void)rewardedVideoAdVideoDidLoad:(id<IRewardedVideoAd>)rewardedVideoAd;

/**
 This method is called when video ad slot will be showing.
 */
- (void)rewardedVideoAdWillVisible:(id<IRewardedVideoAd>)rewardedVideoAd;

/**
 This method is called when video ad slot has been shown.
 */
- (void)rewardedVideoAdDidVisible:(id<IRewardedVideoAd>)rewardedVideoAd;

/**
 This method is called when video ad is about to close.
 */
- (void)rewardedVideoAdWillClose:(id<IRewardedVideoAd>)rewardedVideoAd;

/**
 This method is called when video ad is closed.
 */
- (void)rewardedVideoAdDidClose:(id<IRewardedVideoAd>)rewardedVideoAd;

/**
 This method is called when video ad is clicked.
 */
- (void)rewardedVideoAdDidClick:(id<IRewardedVideoAd>)rewardedVideoAd;


/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)rewardedVideoAdDidPlayFinish:(id<IRewardedVideoAd>)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 Server verification which is requested asynchronously is succeeded.
 @param verify :return YES when return value is 2000.
 */
- (void)rewardedVideoAdServerRewardDidSucceed:(id<IRewardedVideoAd>)rewardedVideoAd verify:(BOOL)verify;

/**
 Server verification which is requested asynchronously is failed.
 Return value is not 2000.
 */
- (void)rewardedVideoAdServerRewardDidFail:(id<IRewardedVideoAd>)rewardedVideoAd __attribute__((deprecated("Use rewardedVideoAdServerRewardDidFail: error: instead.")));

/**
  Server verification which is requested asynchronously is failed.
  @param rewardedVideoAd rewarded Video ad
  @param error request error info
 */
- (void)rewardedVideoAdServerRewardDidFail:(id<IRewardedVideoAd>)rewardedVideoAd error:(NSError *)error;

/**
 This method is called when the user clicked skip button.
 */
- (void)rewardedVideoAdDidClickSkip:(id<IRewardedVideoAd>)rewardedVideoAd;

@end

#endif /* IRewardedVideoAd_h */
