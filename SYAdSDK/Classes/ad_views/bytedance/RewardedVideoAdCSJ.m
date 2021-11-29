//
//  RewardedVideoAdCSJ.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/29.
//

#import "RewardedVideoAdCSJ.h"

#import "IRewardedVideoAd.h"
#import "SYRewardedVideoAd.h"
#import "SlotUtils.h"
#import "SYAdSDKDefines.h"


@interface RewardedVideoAdCSJ () <BURewardedVideoAdDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@end

@implementation RewardedVideoAdCSJ

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszBuSlotID = @"";
        self.syDelegate = nil;
//        self.m_pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
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
    self = [super initWithSlotID:self.m_pszBuSlotID rewardedVideoModel:_model];
    self.delegate = self;
    
    return self;
}

- (void)loadAdData {
    [self loadAdData];
}

- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    [super showAdFromRootViewController:rootViewController];
    
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
    NSLog(@"%st",__func__);
//    NSLog(@"mediaExt-%@",rewardedVideoAd.mediaExt);
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdVideoLoadedSuccess;
    NSLog(@"%s",__func__);
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    NSLog(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__func__);
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s",__func__);
}

- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s",__func__);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
//    self.selectedView.promptStatus = BUDPromptStatusDefault;
    NSLog(@"%s",__func__);
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__func__);
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"%s",__func__);
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd error:(nonnull NSError *)error {
    NSLog(@"%s error = %@",__func__,error);
}

- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s",__func__);

}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    NSLog(@"%s",__func__);
    NSLog(@"%@",[NSString stringWithFormat:@"verify:%@ rewardName:%@ rewardMount:%ld",verify?@"true":@"false",rewardedVideoAd.rewardedVideoModel.rewardName,(long)rewardedVideoAd.rewardedVideoModel.rewardAmount]);
}
- (void)rewardedVideoAdCallback:(BURewardedVideoAd *)rewardedVideoAd withType:(BURewardedVideoAdType)rewardedVideoAdType{
    NSLog(@"%s",__func__);
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
