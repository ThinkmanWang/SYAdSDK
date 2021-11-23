
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
#import "ad_views/sy/SplashAdViewSY.h"

#import "SYAdSDKDefines.h"

@interface SYSplashAdView () <ISplashAdViewDelegate>
@property(nonatomic, strong) id<ISplashAdView> splashAdView;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* pszRequestId;
@end

@implementation SYSplashAdView

- (id) init {
    self = [super init];
    if (self) {
        self.tolerateTimeout = 3;
        self.hideSkipButton = NO;
        self.needSplashZoomOutAd = YES;
        self.delegate = nil;
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.slotID = slotID;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.m_nResourceType = [SlotUtils getResourceType:slotID];
    
#ifdef TEST_FOR_BYTEDANCE
    self.m_nResourceType = [NSNumber numberWithInt:2];
#endif
    
#ifdef TEST_FOR_GDT
    self.m_nResourceType = [NSNumber numberWithInt:1];
#endif
    
#ifdef TEST_SY_AD
    self.m_nResourceType = [NSNumber numberWithInt:3];
#endif
    
    switch ([self.m_nResourceType longValue]) {
        case 1: //gdt
            self.splashAdView = [[SplashAdViewCSJ alloc] init];
            break;
        case 2: //bytedance
            self.splashAdView = [[SplashAdViewCSJ alloc] init];
            break;
        case 3: //SY
            self.splashAdView = [[SplashAdViewSY alloc] init];
            break;
        default: //bytedance
            self.splashAdView = [[SplashAdViewCSJ alloc] init];
            break;
    }
    
    [self.splashAdView setRequestID:self.pszRequestId];
    [self.splashAdView initWithSlotID:self.slotID];
    
    return self;
}

- (void) reInitSYSlot {
    self.m_nResourceType = [SlotUtils getResourceType:self.slotID];
}

- (void)loadAdData {
    
    [self.splashAdView setSYRootViewController:self.rootViewController];
    [self.splashAdView setSYDelegate:self];

    [self.splashAdView loadAdData];

    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:-1 type:11008];
}

- (void) removeMyself {
    if (self.splashAdView) {
        [self.splashAdView removeMyself];
    }
    [self removeFromSuperview];
}

#pragma mark -events


- (void)splashAdDidLoad:(id<ISplashAdView>)splashAd {
    //NSLog(@"splashAdDidLoad");
    
    self.frame = [self.splashAdView getFrame];
    [self addSubview:splashAd];
    
    if (self.delegate) {
        [self.delegate splashAdDidLoad:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:-1 type:11020];
}

- (void)splashAdDidClose:(id<ISplashAdView>)splashAd {
    //NSLog(@"splashAdDidClose");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClose:self];
    }
}

- (void)splashAdDidClick:(id<ISplashAdView>)splashAd {
    //NSLog(@"splashAdDidClick");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClick:self];
    }
    
}

- (void)splashAdDidClickSkip:(id<ISplashAdView>)splashAd {
    //NSLog(@"splashAdDidClickSkip");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClickSkip:self];
    }
}

- (void)splashAd:(id<ISplashAdView>)splashAd {
    //NSLog(@"splashAd");
    // Display fails, completely remove 'splashAdView', avoid memory leak
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAd:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:-1 type:11009];
}

- (void)splashAdWillVisible:(id<ISplashAdView>)splashAd {
    //NSLog(@"splashAdWillVisible");
    if (self.delegate) {
        [self.delegate splashAdWillVisible:self];
    }
    
}

- (void)splashAdWillClose:(id<ISplashAdView>)splashAd {
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdWillClose:self];
    }
}

- (void)splashAdDidCloseOtherController:(id<ISplashAdView>)splashAd {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashAdDidCloseOtherController");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidCloseOtherController:self];
    }
}



- (void)splashAdCountdownToZero:(id<ISplashAdView>)splashAd {
    // When the countdown is over, it is equivalent to clicking Skip to completely remove 'splashAdView' and avoid memory leak
    //NSLog(@"splashAdCountdownToZero");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdCountdownToZero:self];
    }
}

#pragma mark - BUSplashZoomOutViewDelegate
- (void)splashZoomOutViewAdDidClick:(id<ISplashAdView>)splashAd {
    //NSLog(@"splashZoomOutViewAdDidClick");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidClose:(id<ISplashAdView>)splashAd {
    // Click close, completely remove 'splashAdView', avoid memory leak
    //NSLog(@"splashZoomOutViewAdDidClose");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidAutoDimiss:(id<ISplashAdView>)splashAd {
    // Back down at the end of the countdown to completely remove the 'splashAdView' to avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidAutoDimiss");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidCloseOtherController:(id<ISplashAdView>)splashAd {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidCloseOtherController");
    [self removeMyself];
}


@end
