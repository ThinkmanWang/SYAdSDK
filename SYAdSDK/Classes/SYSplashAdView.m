
#import "SYSplashAdView.h"

#import <UIKit/UIKit.h>
#import "SYAdSDKManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "log/SYLogUtils.h"
#import "ad_views/ISplashAdView.h"
#import "utils/SlotUtils.h"
#import "ad_views/bytedance/SplashAdViewCSJ.h"


@interface SYSplashAdView () <BUSplashAdDelegate>
@property(nonatomic, strong) id<ISplashAdView> splashAdView;
@property(nonatomic, strong) NSString* buSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* pszRequestId;
@end

@implementation SYSplashAdView

- (id) init {
    self = [super init];
    if (self) {
        self.tolerateTimeout = 3;
        self.hideSkipButton = NO;
        self.needSplashZoomOutAd = NO;
        self.delegate = nil;
        self.buSlotID = nil;
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.slotID = slotID;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.buSlotID = [SlotUtils getRealSlotID:slotID];
    self.m_nResourceType = [SlotUtils getResourceType:slotID];
    
    switch ([self.m_nResourceType longValue]) {
        case 1: //gdt
            self.splashAdView = [[SplashAdViewCSJ alloc] init];
            break;
        case 2: //bytedance
            self.splashAdView = [[SplashAdViewCSJ alloc] init];
            break;
        case 3: //SY
            self.splashAdView = [[SplashAdViewCSJ alloc] init];
            break;
        default: //bytedance
            self.splashAdView = [[SplashAdViewCSJ alloc] init];
            break;
    }
    
    [self.splashAdView initWithSlotID:slotID];
    
    return self;
}

- (void)loadAdData {
    
    [self.splashAdView setSYRootViewController:self.rootViewController];
    self.frame = [self.splashAdView getFrame];
    [self.splashAdView loadAdData];
    [self.splashAdView setSYDelegate:self];

    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11008];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11010];
}

- (void) removeMyself {
    if (self.splashAdView) {
        [self.splashAdView removeMyself];
    }
    [self removeFromSuperview];
}

#pragma mark -events


- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidLoad");
//    if (splashAd.zoomOutView) {
//        UIViewController *parentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//        [parentVC.view addSubview:splashAd.zoomOutView];
//        [parentVC.view bringSubviewToFront:splashAd];
//        //Add this view to your container
//        [parentVC.view insertSubview:splashAd.zoomOutView belowSubview:splashAd];
//        splashAd.zoomOutView.rootViewController = parentVC;
//        splashAd.zoomOutView.delegate = self;
//    }
    
    if (self.delegate) {
        [self.delegate splashAdDidLoad:self];
    }
    
    [self addSubview:splashAd];
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11011];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11020];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClose");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClose:self];
    }
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClick");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClick:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:2];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClickSkip");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClickSkip:self];
    }
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    //NSLog(@"splashAd");
    // Display fails, completely remove 'splashAdView', avoid memory leak
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAd:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11012];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11009];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdWillVisible");
    if (self.delegate) {
        [self.delegate splashAdWillVisible:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:1];
}

- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdWillClose:self];
    }
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashAdDidCloseOtherController");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidCloseOtherController:self];
    }
}



- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    // When the countdown is over, it is equivalent to clicking Skip to completely remove 'splashAdView' and avoid memory leak
    //NSLog(@"splashAdCountdownToZero");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdCountdownToZero:self];
    }
}

#pragma mark - BUSplashZoomOutViewDelegate
- (void)splashZoomOutViewAdDidClick:(BUSplashZoomOutView *)splashAd {
    //NSLog(@"splashZoomOutViewAdDidClick");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidClose:(BUSplashZoomOutView *)splashAd {
    // Click close, completely remove 'splashAdView', avoid memory leak
    //NSLog(@"splashZoomOutViewAdDidClose");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidAutoDimiss:(BUSplashZoomOutView *)splashAd {
    // Back down at the end of the countdown to completely remove the 'splashAdView' to avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidAutoDimiss");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidCloseOtherController:(BUSplashZoomOutView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidCloseOtherController");
    [self removeMyself];
}


@end
