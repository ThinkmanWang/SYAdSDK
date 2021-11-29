//
//  RewardedVideoAdCSJ.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/29.
//

#import "RewardedVideoAdCSJ.h"
#import <BUAdSDK/BUAdSDK.h>

#import "IRewardedVideoAd.h"
#import "SYRewardedVideoAd.h"
#import "SlotUtils.h"
#import "SYAdSDKDefines.h"
#import "SYLogUtils.h"


@interface RewardedVideoAdCSJ () <BURewardedVideoAdDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;

@end

@implementation RewardedVideoAdCSJ

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszBuSlotID = @"";
        self.syDelegate = nil;
        self.rewardedVideoAd = nil;
        self.m_pszRequestId = nil;
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.m_pszSlotID = slotID;
    
    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
#ifdef TEST_REWARDED_VIDEO
    self.m_pszBuSlotID = @"947191441";
#endif
    
    BURewardedVideoModel* _model = [[BURewardedVideoModel alloc] init];
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.m_pszBuSlotID rewardedVideoModel:_model];
    self.rewardedVideoAd.delegate = self;
    
    return self;
}

- (void)loadAdData {
    [self.rewardedVideoAd loadAdData];
}

- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    [self.rewardedVideoAd showAdFromRootViewController:rootViewController];
    
    return YES;
}

- (void)setSYDelegate:(id<IRewardedVideoAdDelegate>)delegate {
    self.syDelegate = delegate;
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

#pragma mark - BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
//    NSLog(@"mediaExt-%@",rewardedVideoAd.mediaExt);
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdDidLoad:self];
    }
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdVideoLoadedSuccess;
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdVideoDidLoad:self];
    }
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAd:self didFailWithError:error];
    }
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdWillVisible:self];
    }
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd{
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdDidVisible:self];
    }
}

- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd{
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdWillClose:self];
    }
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
//    self.selectedView.promptStatus = BUDPromptStatusDefault;
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdDidClose:self];
    }
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdDidClick:self];
    }
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdDidPlayFinish:self didFailWithError:error];
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd error:(nonnull NSError *)error {
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdServerRewardDidFail:self error:error];
    }
}

- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd{
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdDidClickSkip:self];
    }
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    if (self.syDelegate) {
        [self.syDelegate rewardedVideoAdServerRewardDidSucceed:self verify:verify];
    }
}
- (void)rewardedVideoAdCallback:(BURewardedVideoAd *)rewardedVideoAd withType:(BURewardedVideoAdType)rewardedVideoAdType{
    NSLog(@"");
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
