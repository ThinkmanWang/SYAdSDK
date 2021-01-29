//
//  SYBannerViewController.m
//  SYAdSSDK_Example
//
//  Created by 王晓丰 on 2021/1/25.
//  Copyright © 2021 Thinkman Wang. All rights reserved.
//

#import "SYBannerViewController.h"
#import <SYAdSDK/SYAdSDK.h>

@interface SYBannerViewController ()
@property(nonatomic, strong) SYBannerView *bannerView;
@end

@implementation SYBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView {
    self.bannerView = [[[SYBannerView alloc] init] initWithSlotID:@"24013" rootViewController:self adSize:SYBannerSize600_300];
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
}

#pragma mark - SYAdSDK events

/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 */
- (void)bannerAdViewDidLoad:(SYBannerView *)bannerAdView {
    
}

/**
 This method is called when bannerAdView ad slot failed to load.
 */
- (void)bannerAdViewLoadFailed:(SYBannerView *)bannerAdView {
    
}


/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)bannerAdViewRenderSuccess:(SYBannerView *)bannerAdView {
    CGFloat topbarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height +
           (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    
    self.bannerView.frame = CGRectMake(0
                                       , topbarHeight
                                       , CGRectGetWidth(self.bannerView.frame)
                                       , CGRectGetHeight(self.bannerView.frame));
    
    [self.view addSubview:self.bannerView];
}


/**
 This method is called when a nativeExpressAdView failed to render.
 */
- (void)bannerAdViewRenderFail:(SYBannerView *)bannerAdView {
    
}


/**
 This method is called when bannerAdView ad slot showed new ad.
 */
- (void)bannerAdViewWillBecomVisible:(SYBannerView *)bannerAdView {
    
}


/**
 This method is called when bannerAdView is clicked.
 */
- (void)bannerAdViewDidClick:(SYBannerView *)bannerAdView {
    NSLog(@"bannerAdViewDidClick");
    
}


@end
