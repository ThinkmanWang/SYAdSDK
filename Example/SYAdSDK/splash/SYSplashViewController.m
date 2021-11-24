//
//  SYSplashViewController.m
//  SYAdSDK_Example
//
//  Created by 王晓丰 on 2021/5/19.
//  Copyright © 2021 Thinkman Wang. All rights reserved.
//

#import "SYSplashViewController.h"

#import <SYAdSDK/SYAdSDK.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

#import "SYViewController.h"

@interface SYSplashViewController() <SYSplashAdDelegate>
@property SYSplashAdView* splashAdView;
@end

@implementation SYSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView {
    self.splashAdView = [[[SYSplashAdView alloc] init] initWithSlotID:@"24032"];
    self.splashAdView.delegate = self;
    
    [self.view addSubview:self.splashAdView];
    self.splashAdView.rootViewController = self.navigationController;

    [self.splashAdView loadAdData];
}

#pragma mark launchscreeen events
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)splashAdDidLoad:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidLoad");
}

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)splashAd:(SYSplashAdView *)splashAd {
    NSLog(@"splashAd load failed");
}

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdWillVisible");
}

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidClick");
}

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidClose");
}

/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdWillClose");
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashAdDidCloseOtherController:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidCloseOtherController");
}

/**
 This method is called when spalashAd skip button  is clicked.
 */
- (void)splashAdDidClickSkip:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidClickSkip");
}

/**
 This method is called when spalashAd countdown equals to zero
 */
- (void)splashAdCountdownToZero:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdCountdownToZero");
}

@end
