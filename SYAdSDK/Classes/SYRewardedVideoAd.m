//
//  SYRewardedVideoAd.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/29.
//

#import "SYRewardedVideoAd.h"
#import "IRewardedVideoAd.h"

#import "log/SYLogUtils.h"
#import "utils/SlotUtils.h"
#import "IRewardedVideoAd.h"
#import "SYAdSDKDefines.h"
#import "RewardedVideoAdCSJ.h"

@interface SYRewardedVideoAd () <IRewardedVideoAdDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property (nonatomic, weak) UIViewController *rootViewController;

@property (nonatomic, strong) id<IRewardedVideoAd> rewardedVideoAd;

@end

@implementation SYRewardedVideoAd

- (id) init {
    self = [super init];
    if (self) {
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.delegate = nil;
        self.m_pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.m_pszSlotID = slotID;
    self.m_nResourceType = [SlotUtils getResourceType:slotID];
#ifdef TEST_REWARDED_VIDEO
    self.m_nResourceType = [NSNumber numberWithInt:2];
#endif
    switch ([self.m_nResourceType longValue]) {
        case 1: //gdt
            self.rewardedVideoAd = [[RewardedVideoAdCSJ alloc] init];
            break;
        case 2: //bytedance
            self.rewardedVideoAd = [[RewardedVideoAdCSJ alloc] init];
            break;
        case 3: //SY
            self.rewardedVideoAd = [[RewardedVideoAdCSJ alloc] init];
            break;
        default: //bytedance
            self.rewardedVideoAd = [[RewardedVideoAdCSJ alloc] init];
            break;
    }
    
    [self.rewardedVideoAd setSYDelegate:self];
    [self.rewardedVideoAd setRequestID:self.m_pszRequestId];
    [self.rewardedVideoAd initWithSlotID:self.m_pszSlotID];
    
    return self;
}

- (void)loadAdData {
    [self.rewardedVideoAd loadAdData];
}

- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    [self.rewardedVideoAd showAdFromRootViewController:rootViewController];
    return YES;
}


- (void)rewardedVideoAdDidLoad:(id<IRewardedVideoAd>)rewardedVideoAd {
    if (self.delegate) {
        [self.delegate rewardedVideoAdDidLoad:self];
    }
}

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)rewardedVideoAd:(id<IRewardedVideoAd>)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    if (self.delegate) {
        [self.delegate rewardedVideoAd:self didFailWithError:error];
    }
}

/**
 This method is called when video cached successfully.
 */
- (void)rewardedVideoAdVideoDidLoad:(id<IRewardedVideoAd>)rewardedVideoAd {
    if (self.delegate) {
        [self.delegate rewardedVideoAdVideoDidLoad:self];
    }
}

/**
 This method is called when video ad slot will be showing.
 */
- (void)rewardedVideoAdWillVisible:(id<IRewardedVideoAd>)rewardedVideoAd {
    if (self.delegate) {
        [self.delegate rewardedVideoAdWillVisible:self];
    }
}

/**
 This method is called when video ad slot has been shown.
 */
- (void)rewardedVideoAdDidVisible:(id<IRewardedVideoAd>)rewardedVideoAd {
    if (self.delegate) {
        [self.delegate rewardedVideoAdDidVisible:self];
    }
}

/**
 This method is called when video ad is about to close.
 */
- (void)rewardedVideoAdWillClose:(id<IRewardedVideoAd>)rewardedVideoAd {
    if (self.delegate) {
        [self.delegate rewardedVideoAdWillClose:self];
    }
}

/**
 This method is called when video ad is closed.
 */
- (void)rewardedVideoAdDidClose:(id<IRewardedVideoAd>)rewardedVideoAd {
    if (self.delegate) {
        [self.delegate rewardedVideoAdDidClose:self];
    }
}

/**
 This method is called when video ad is clicked.
 */
- (void)rewardedVideoAdDidClick:(id<IRewardedVideoAd>)rewardedVideoAd {
    if (self.delegate) {
        [self.delegate rewardedVideoAdDidClick:self];
    }
}


/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)rewardedVideoAdDidPlayFinish:(id<IRewardedVideoAd>)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    if (self.delegate) {
        [self.delegate rewardedVideoAdDidPlayFinish:self didFailWithError:error];
    }
}

/**
 Server verification which is requested asynchronously is succeeded.
 @param verify :return YES when return value is 2000.
 */
- (void)rewardedVideoAdServerRewardDidSucceed:(id<IRewardedVideoAd>)rewardedVideoAd verify:(BOOL)verify {
    if (self.delegate) {
        [self.delegate rewardedVideoAdServerRewardDidSucceed:self verify:verify];
    }
}

/**
 Server verification which is requested asynchronously is failed.
 Return value is not 2000.
 */
- (void)rewardedVideoAdServerRewardDidFail:(id<IRewardedVideoAd>)rewardedVideoAd __attribute__((deprecated("Use rewardedVideoAdServerRewardDidFail: error: instead."))) {
    if (self.delegate) {
        [self.delegate rewardedVideoAdServerRewardDidFail:self];
    }
}

/**
  Server verification which is requested asynchronously is failed.
  @param rewardedVideoAd rewarded Video ad
  @param error request error info
 */
- (void)rewardedVideoAdServerRewardDidFail:(id<IRewardedVideoAd>)rewardedVideoAd error:(NSError *)error {
    if (self.delegate) {
        [self.delegate rewardedVideoAdServerRewardDidFail:self error:error];
    }
}

/**
 This method is called when the user clicked skip button.
 */
- (void)rewardedVideoAdDidClickSkip:(id<IRewardedVideoAd>)rewardedVideoAd {
    if (self.delegate) {
        [self.delegate rewardedVideoAdDidClickSkip:self];
    }
}

@end
