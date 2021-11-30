//
//  SYRewardedVideoControllerViewController.m
//  SYAdSDK_Example
//
//  Created by 王晓丰 on 2021/11/29.
//  Copyright © 2021 Thinkman Wang. All rights reserved.
//

#import "SYRewardedVideoControllerViewController.h"
#import "SYRewardedVideoAd.h"

@interface SYRewardedVideoControllerViewController () <SYRewardedVideoAdDelegate>
@property (nonatomic, strong) SYRewardedVideoAd *rewardedVideoAd;
@end

@implementation SYRewardedVideoControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    SYRewardedVideoModel *model = [[SYRewardedVideoModel alloc] init];
    self.rewardedVideoAd = [[[SYRewardedVideoAd alloc] init] initWithSlotID:@"24040"];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SYRewardedVideoAdDelegate

/**
 This method is called when video ad material loaded successfully.
 */
- (void)rewardedVideoAdDidLoad:(SYRewardedVideoAd *)rewardedVideoAd {
    if (self.rewardedVideoAd) {
        [self.rewardedVideoAd showAdFromRootViewController:self];
    }
}

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)rewardedVideoAd:(SYRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    
}

/**
 This method is called when video cached successfully.
 */
- (void)rewardedVideoAdVideoDidLoad:(SYRewardedVideoAd *)rewardedVideoAd {
    
}

/**
 This method is called when video ad slot will be showing.
 */
- (void)rewardedVideoAdWillVisible:(SYRewardedVideoAd *)rewardedVideoAd {
    
}

/**
 This method is called when video ad slot has been shown.
 */
- (void)rewardedVideoAdDidVisible:(SYRewardedVideoAd *)rewardedVideoAd {
    
}

/**
 This method is called when video ad is about to close.
 */
- (void)rewardedVideoAdWillClose:(SYRewardedVideoAd *)rewardedVideoAd {
    
}

/**
 This method is called when video ad is closed.
 */
- (void)rewardedVideoAdDidClose:(SYRewardedVideoAd *)rewardedVideoAd {
    
}

/**
 This method is called when video ad is clicked.
 */
- (void)rewardedVideoAdDidClick:(SYRewardedVideoAd *)rewardedVideoAd {
    
}


/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)rewardedVideoAdDidPlayFinish:(SYRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    
}

/**
 Server verification which is requested asynchronously is succeeded.
 @param verify :return YES when return value is 2000.
 */
- (void)rewardedVideoAdServerRewardDidSucceed:(SYRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    
}

/**
 Server verification which is requested asynchronously is failed.
 Return value is not 2000.
 */
- (void)rewardedVideoAdServerRewardDidFail:(SYRewardedVideoAd *)rewardedVideoAd __attribute__((deprecated("Use rewardedVideoAdServerRewardDidFail: error: instead."))) {
    
}

/**
  Server verification which is requested asynchronously is failed.
  @param rewardedVideoAd rewarded Video ad
  @param error request error info
 */
- (void)rewardedVideoAdServerRewardDidFail:(SYRewardedVideoAd *)rewardedVideoAd error:(NSError *)error {
    
}

/**
 This method is called when the user clicked skip button.
 */
- (void)rewardedVideoAdDidClickSkip:(SYRewardedVideoAd *)rewardedVideoAd {
    
}

@end
