//
//  SYExpressViewController.m
//  SYAdSDK_Example
//
//  Created by 王晓丰 on 2021/1/26.
//  Copyright © 2021 Thinkman Wang. All rights reserved.
//

#import "SYExpressViewController.h"

#import <SYAdSDK/SYAdSDK.h>
#import <Masonry/Masonry.h>

@interface SYExpressViewController () <SYExpressAdViewDelegate>
@property (strong, nonatomic) SYExpressAdManager* expressAdManager;
@property (nonatomic, strong) SYExpressAdView* expressAdView;
@end

@implementation SYExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void) initView {
    self.expressAdManager = [[[SYExpressAdManager alloc] init] initWithSlotID:@"24012" rootViewController:self adSize:CGSizeMake(CGRectGetWidth(self.view.frame), 0)];
    self.expressAdManager.delegate = self;
    
    [self.expressAdManager loadAdDataWithCount:1];
}

/**
 * Sent when views successfully load ad
 */
- (void)expressAdSuccessToLoad:(SYExpressAdManager *) expressAd views:(NSArray<__kindof SYExpressAdView *> *)views {
    if (views.count >= 1) {
        self.expressAdView = views[0];
    }
}

/**
 * Sent when views fail to load ad
 */
- (void)expressAdFailToLoad:(SYExpressAdManager *)expressAd {
    
}

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)expressAdViewRenderSuccess:(SYExpressAdView *)expressAdView {
    [self.view addSubview:self.expressAdView];
    
    CGFloat topbarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height +
           (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    
    self.expressAdView.frame = CGRectMake(0
                                          , topbarHeight
                                          , CGRectGetWidth(self.expressAdView.frame)
                                          , CGRectGetHeight(self.expressAdView.frame));
}

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)expressAdViewRenderFail:(SYExpressAdView *)expressAdView {
    
}

/**
 * Sent when an ad view is about to present modal content
 */
- (void)expressAdViewWillShow:(SYExpressAdView *)expressAdView {
    
}

/**
 * Sent when an ad view is clicked
 */
- (void)expressAdViewDidClick:(SYExpressAdView *)expressAdView {
    NSLog(@"expressAdViewDidClick");
}

/**
 * Sent when a player finished
 * @param error : error of player
 */
- (void)expressAdViewPlayerDidPlayFinish:(SYExpressAdView *)expressAdView {
    
}

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)expressAdView:(SYExpressAdView *)expressAdView {
    
}

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)expressAdViewWillPresentScreen:(SYExpressAdView *)expressAdView {
    
}

@end
