
#import "SYSplashAdView.h"

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>


@interface SYSplashAdView () <BUSplashAdDelegate>
@property(nonatomic, strong) BUSplashAdView* splashAdView;
@property(nonatomic, strong) NSString* buSlotID;
@end

@implementation SYSplashAdView

- (id) init {
    self = [super init];
    if (self) {
        self.tolerateTimeout = 3;
        self.hideSkipButton = NO;
        self.needSplashZoomOutAd = NO;
        self.delegate = nil;
        self.buSlotID = @"887421551";
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.slotID = slotID;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.splashAdView = [[BUSplashAdView alloc] initWithSlotID:self.buSlotID frame:frame];
    
    return self;
}

- (void)loadAdData {
    self.splashAdView.tolerateTimeout = self.tolerateTimeout;
    self.splashAdView.delegate = self;
    
    //optional
    [self.splashAdView loadAdData];
    self.splashAdView.rootViewController = self.rootViewController;
    
    
    [self addSubview:self.splashAdView];
}

#pragma mark events

- (void)removeSplashAdView {
    NSLog(@"removeSplashAdView");
    if (self.splashAdView) {
        [self.splashAdView removeFromSuperview];
        self.splashAdView = nil;
    }
}


- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    NSLog(@"splashAdDidLoad");
    if (splashAd.zoomOutView) {
        UIViewController *parentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [parentVC.view addSubview:splashAd.zoomOutView];
        [parentVC.view bringSubviewToFront:splashAd];
        //Add this view to your container
        [parentVC.view insertSubview:splashAd.zoomOutView belowSubview:splashAd];
        splashAd.zoomOutView.rootViewController = parentVC;
        splashAd.zoomOutView.delegate = self;
    }
    
    [self.delegate splashAdDidLoad:self];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    NSLog(@"splashAdDidClose");
    if (splashAd.zoomOutView) {
//        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView];
    } else{
        [splashAd removeFromSuperview];
    }
    
    [self.delegate splashAdDidClose:self];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    NSLog(@"splashAdDidClick");
    if (splashAd.zoomOutView) {
        [splashAd.zoomOutView removeFromSuperview];
    }
    // Be careful not to say 'self.splashadview = nil' here.
    // Subsequent agent callbacks will not be triggered after the 'splashAdView' is released early.
    [splashAd removeFromSuperview];
    
    [self.delegate splashAdDidClick:self];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    NSLog(@"splashAdDidClickSkip");
    if (splashAd.zoomOutView) {
//        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView];
    } else{
        // Click Skip, there is no subsequent operation, completely remove 'splashAdView', avoid memory leak
        [self removeSplashAdView];
    }
    
    [self.delegate splashAdDidClickSkip:self];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"splashAd");
    // Display fails, completely remove 'splashAdView', avoid memory leak
    [self removeSplashAdView];
    
    [self.delegate splashAd:self];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    NSLog(@"splashAdWillVisible");
    [self.delegate splashAdWillVisible:self];
}

- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    NSLog(@"splashAdWillClose");
    
    [self.delegate splashAdWillClose:self];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    NSLog(@"splashAdDidCloseOtherController");
    [self removeSplashAdView];
    
    [self.delegate splashAdDidCloseOtherController:self];
}



- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    // When the countdown is over, it is equivalent to clicking Skip to completely remove 'splashAdView' and avoid memory leak
    NSLog(@"splashAdCountdownToZero");
    if (!splashAd.zoomOutView) {
        [self removeSplashAdView];
    }
    
    [self.delegate splashAdCountdownToZero:self];
}

#pragma mark - BUSplashZoomOutViewDelegate
- (void)splashZoomOutViewAdDidClick:(BUSplashZoomOutView *)splashAd {
    NSLog(@"splashZoomOutViewAdDidClick");
}

- (void)splashZoomOutViewAdDidClose:(BUSplashZoomOutView *)splashAd {
    // Click close, completely remove 'splashAdView', avoid memory leak
    NSLog(@"splashZoomOutViewAdDidClose");
    [self removeSplashAdView];
}

- (void)splashZoomOutViewAdDidAutoDimiss:(BUSplashZoomOutView *)splashAd {
    // Back down at the end of the countdown to completely remove the 'splashAdView' to avoid memory leaks
    NSLog(@"splashZoomOutViewAdDidAutoDimiss");
    [self removeSplashAdView];
}

- (void)splashZoomOutViewAdDidCloseOtherController:(BUSplashZoomOutView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    NSLog(@"splashZoomOutViewAdDidCloseOtherController");
    [self removeSplashAdView];
}


@end
