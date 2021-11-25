//
//  SplashAdViewCSJ.m
//  Masonry
//
//  Created by 王晓丰 on 2021/2/8.
//

#import "SplashAdViewCSJ.h"

#import <UIKit/UIKit.h>
//#import "SYAdSDKManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "SYLogUtils.h"
#import "SYAdSDKManager.h"
#import "SlotUtils.h"

@interface SplashAdViewCSJ () <BUSplashAdDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@end


@implementation SplashAdViewCSJ

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
    
    self.delegate = self;
//    self.needSplashZoomOutAd = YES;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.frame = frame;
    
    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
#ifdef TEST_FOR_BYTEDANCE
    self.m_pszBuSlotID = @"887620349";
#endif
#ifdef TEST_SY_AD
    self.m_pszBuSlotID = @"12345678";
#endif
    self = [super initWithSlotID:self.m_pszBuSlotID frame:frame];
    
    return self;
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

- (void)loadAdData {
    //optional
    [super loadAdData];
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11010];
}

- (void) removeMyself {
    if (self.zoomOutView) {
        [self.zoomOutView removeFromSuperview];
    }
        
    [self removeFromSuperview];
}

- (CGRect)getFrame {
    return self.frame;
}

- (void)setSYRootViewController:(UIViewController*)rootViewController {
    self.rootViewController = rootViewController;
}

- (void)setSYDelegate:(id<ISplashAdViewDelegate>)delegate {
    self.syDelegate = delegate;
}

#pragma mark -events


- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidLoad");
    if (self.zoomOutView) {
        UIViewController *parentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [parentVC.view addSubview:splashAd.zoomOutView];
        [parentVC.view bringSubviewToFront:splashAd];
        //Add this view to your container
        [parentVC.view insertSubview:splashAd.zoomOutView belowSubview:splashAd];
        self.zoomOutView.rootViewController = parentVC;
        self.zoomOutView.delegate = self;
    }
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidLoad:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11011];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClose");
//    [self removeMyself];
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidClose:self];
    }
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClick");
//    [self removeMyself];
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidClick:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:2];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClickSkip");
//    [self removeMyself];
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidClickSkip:self];
    }
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    //NSLog(@"splashAd");
    // Display fails, completely remove 'splashAdView', avoid memory leak
//    [self removeMyself];
    
    if (self.syDelegate) {
        [self.syDelegate splashAd:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11012];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdWillVisible");
    if (self.syDelegate) {
        [self.syDelegate splashAdWillVisible:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:1];
}

- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
//    [self removeMyself];

    if (self.syDelegate) {
        [self.syDelegate splashAdWillClose:self];
    }
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashAdDidCloseOtherController");
//    [self removeMyself];
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidCloseOtherController:self];
    }
}



- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    // When the countdown is over, it is equivalent to clicking Skip to completely remove 'splashAdView' and avoid memory leak
    //NSLog(@"splashAdCountdownToZero");
//    [self removeMyself];
    
    if (self.syDelegate) {
        [self.syDelegate splashAdCountdownToZero:self];
    }
}

#pragma mark - BUSplashZoomOutViewDelegate
- (void)splashZoomOutViewAdDidClick:(BUSplashZoomOutView *)splashAd {
    //NSLog(@"splashZoomOutViewAdDidClick");
//    [self removeMyself];
}

- (void)splashZoomOutViewAdDidClose:(BUSplashZoomOutView *)splashAd {
    // Click close, completely remove 'splashAdView', avoid memory leak
    //NSLog(@"splashZoomOutViewAdDidClose");
//    [self removeMyself];
}

- (void)splashZoomOutViewAdDidAutoDimiss:(BUSplashZoomOutView *)splashAd {
    // Back down at the end of the countdown to completely remove the 'splashAdView' to avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidAutoDimiss");
//    [self removeMyself];
}

- (void)splashZoomOutViewAdDidCloseOtherController:(BUSplashZoomOutView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidCloseOtherController");
//    [self removeMyself];
}

@end
