//
//  InterstitialAdCSJ.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/19.
//

#import "InterstitialAdCSJ.h"

#import <UIKit/UIKit.h>
//#import "SYAdSDKManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "SYLogUtils.h"
#import "SYAdSDKManager.h"
#import "SlotUtils.h"
#import "IInterstitialAd.h"

@interface InterstitialAdCSJ () <BUNativeExpresInterstitialAdDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@property (nonatomic, weak, nullable) id<IInterstitialAdDelegate> syDelegate;
@property (nonatomic, weak) UIViewController *rootViewController;


@end

@implementation InterstitialAdCSJ

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszBuSlotID = @"";
        self.syDelegate = nil;
        self.rootViewController = nil;
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID adSize:(SYInterstitialAdSize)adsize {
    self.m_pszSlotID = slotID;
    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
#ifdef TEST_FOR_BYTEDANCE
    self.m_pszBuSlotID = @"945746799";
#endif
    
    CGFloat fWidth = 0;
    CGFloat fHeight = 0;
    
    switch (adsize) {
        case SYInterstitialAdSize600_600:
            fWidth = [UIScreen mainScreen].bounds.size.width * 6 / 10;
            fHeight = fWidth;
            break;
        case SYInterstitialAdSize600_900:
            fWidth = [UIScreen mainScreen].bounds.size.width * 6 / 10;
            fHeight = fWidth * 3 / 2;
            break;
        default:
            fWidth = [UIScreen mainScreen].bounds.size.width * 6 / 10;
            fHeight = fWidth;
            break;
    }
    
    self.delegate = self;
    
//    BUInterstitialAd* pAdView = [super initWithSlotID:self.m_pszBuSlotID adSize:CGSizeMake(fWidth, fHeight)];
    return self;
}

/**
 Load interstitial ad datas.
 */
- (void)loadAdData {
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11010];
    
    [super loadAdData];
}

/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:1];
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:1];
    self.rootViewController = rootViewController;
    
    return [super showAdFromRootViewController:self.rootViewController];
}

- (void)setSYDelegate:(id<IInterstitialAdDelegate>)delegate {
    self.syDelegate = delegate;
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}
    
#pragma mark -BUNativeExpresInterstitialAdDelegate
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidLoad");
    if (self.syDelegate) {
        [self.syDelegate interstitialAdDidLoad:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11011];
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    //NSLog(@"nativeExpresInterstitialAd");
    if (self.syDelegate) {
        [self.syDelegate interstitialAd:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11012];
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    //NSLog(@"nativeExpresInterstitialAdRenderSuccess");
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdRenderSuccess:self];
    }    
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    //NSLog(@"nativeExpresInterstitialAdRenderFail");
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdRenderFail:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11012];
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdWillVisible");
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdWillVisible:self];
    }
    
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:1];
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidClick");
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdDidClick:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:2];
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdWillClose");
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdWillClose:self];
    }
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidClose");
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdDidClose:self];
    }
}

- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
    //NSLog(@"nativeExpresInterstitialAdDidCloseOtherController");
    
}

@end
