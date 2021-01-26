//
//  SYInterstitialAdViewController.m
//  SYAdSDK_Example
//
//  Created by 王晓丰 on 2021/1/26.
//  Copyright © 2021 Thinkman Wang. All rights reserved.
//

#import "SYInterstitialAdViewController.h"
#import <SYAdSDK/SYAdSDK.h>

@interface SYInterstitialAdViewController ()
@property(nonatomic, strong) SYInterstitialAd* interstitialAd;
@end

@implementation SYInterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView {
    self.interstitialAd = [[[SYInterstitialAd alloc] init] initWithSlotID:@"945746799" adSize:SYInterstitialAdSize600_600];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}


/**
 This method is called when interstitial ad material loaded successfully.
 */
- (void)interstitialAdDidLoad:(SYInterstitialAd *)interstitialAd {
    
}

/**
 This method is called when interstitial ad material failed to load.
 */
- (void)interstitialAd:(SYInterstitialAd *)interstitialAd {
    
}

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)interstitialAdRenderSuccess:(SYInterstitialAd *)interstitialAd {
    if (self.interstitialAd) {
       [self.interstitialAd showAdFromRootViewController:self];
    }
}

/**
 This method is called when a nativeExpressAdView failed to render.
 */
- (void)interstitialAdRenderFail:(SYInterstitialAd *)interstitialAd {
    
}

/**
 This method is called when interstitial ad slot will be showing.
 */
- (void)interstitialAdWillVisible:(SYInterstitialAd *)interstitialAd {
    
}

/**
 This method is called when interstitial ad is clicked.
 */
- (void)interstitialAdDidClick:(SYInterstitialAd *)interstitialAd {
    
}

/**
 This method is called when interstitial ad is about to close.
 */
- (void)interstitialAdWillClose:(SYInterstitialAd *)interstitialAd {
    
}

/**
 This method is called when interstitial ad is closed.
 */
- (void)interstitialAdDidClose:(SYInterstitialAd *)interstitialAd {
    
}

@end
