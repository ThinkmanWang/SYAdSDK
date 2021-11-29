//
//  SYRewardedVideoAd.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SYRewardedVideoAd;

@interface SYRewardedVideoModel : NSObject

/**
   optional.
   Third-party game user_id identity.
   Mainly used in the reward issuance, it is the callback pass-through parameter from server-to-server.
   It is the unique identifier of each user.
   In the non-server callback mode, it will also be pass-through when the video is finished playing.
   Only the string can be passed in this case, not nil.
 */
@property (nonatomic, copy) NSString *userId;

//optional. serialized string.
@property (nonatomic, copy) NSString *extra;

//reward name. It will assigned value when the ads back.
@property (nonatomic, copy) NSString *rewardName;

//number of rewards. It will assigned value when the ads back.
@property (nonatomic, assign) NSInteger rewardAmount;

@end


@protocol SYRewardedVideoAdDelegate <NSObject>

@optional

/**
 This method is called when video ad material loaded successfully.
 */
- (void)rewardedVideoAdDidLoad:(SYRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)rewardedVideoAd:(SYRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 This method is called when video cached successfully.
 */
- (void)rewardedVideoAdVideoDidLoad:(SYRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad slot will be showing.
 */
- (void)rewardedVideoAdWillVisible:(SYRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad slot has been shown.
 */
- (void)rewardedVideoAdDidVisible:(SYRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is about to close.
 */
- (void)rewardedVideoAdWillClose:(SYRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is closed.
 */
- (void)rewardedVideoAdDidClose:(SYRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is clicked.
 */
- (void)rewardedVideoAdDidClick:(SYRewardedVideoAd *)rewardedVideoAd;


/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)rewardedVideoAdDidPlayFinish:(SYRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 Server verification which is requested asynchronously is succeeded.
 @param verify :return YES when return value is 2000.
 */
- (void)rewardedVideoAdServerRewardDidSucceed:(SYRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify;

/**
 Server verification which is requested asynchronously is failed.
 Return value is not 2000.
 */
- (void)rewardedVideoAdServerRewardDidFail:(SYRewardedVideoAd *)rewardedVideoAd __attribute__((deprecated("Use rewardedVideoAdServerRewardDidFail: error: instead.")));

/**
  Server verification which is requested asynchronously is failed.
  @param rewardedVideoAd rewarded Video ad
  @param error request error info
 */
- (void)rewardedVideoAdServerRewardDidFail:(SYRewardedVideoAd *)rewardedVideoAd error:(NSError *)error;

/**
 This method is called when the user clicked skip button.
 */
- (void)rewardedVideoAdDidClickSkip:(SYRewardedVideoAd *)rewardedVideoAd;

@end


@interface SYRewardedVideoAd : NSObject

@property (nonatomic, weak, nullable) id<SYRewardedVideoAdDelegate> delegate;

- (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(SYRewardedVideoModel *)model;
- (void)loadAdData;
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
