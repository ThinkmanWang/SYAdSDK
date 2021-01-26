//
//  SYInterstitialAd.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/1/26.
//

#import "SYInterstitialAd.h"

#import <BUAdSDK/BUAdSDK.h>

@interface SYInterstitialAd () <BUNativeExpresInterstitialAdDelegate>
@property(nonatomic, strong) NSString* slotID;
@property(nonatomic, strong) NSString* buSlotID;

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;

@end

@implementation SYInterstitialAd

- (id) init {
    self = [super init];
    if (self) {
        self.buSlotID = @"945746799";
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID adSize:(SYInterstitialAdSize)adsize {
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
    
    self.slotID = slotID;
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:self.buSlotID adSize:CGSizeMake(fWidth, fHeight)];
    self.interstitialAd.delegate = self;
    
    return self;
}

/**
 Load interstitial ad datas.
 */
- (void)loadAdData {
    return [self.interstitialAd loadAdData];
}

/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    
    self.rootViewController = rootViewController;
    
    if (self.interstitialAd) {
        return [self.interstitialAd showAdFromRootViewController:self.rootViewController];
    }
    
    return NO;
}

#pragma mark -BUNativeExpresInterstitialAdDelegate
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidLoad");
    if (self.delegate) {
        [self.delegate interstitialAdDidLoad:self];
    }
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    //NSLog(@"nativeExpresInterstitialAd");
    if (self.delegate) {
        [self.delegate interstitialAd:self];
    }
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    //NSLog(@"nativeExpresInterstitialAdRenderSuccess");
    
    if (self.delegate) {
        [self.delegate interstitialAdRenderSuccess:self];
    }
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    //NSLog(@"nativeExpresInterstitialAdRenderFail");
    
    if (self.delegate) {
        [self.delegate interstitialAdRenderFail:self];
    }
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdWillVisible");
    
    if (self.delegate) {
        [self.delegate interstitialAdWillVisible:self];
    }
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidClick");
    
    if (self.delegate) {
        [self.delegate interstitialAdDidClick:self];
    }
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdWillClose");
    
    if (self.delegate) {
        [self.delegate interstitialAdWillClose:self];
    }
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidClose");
    self.interstitialAd = nil;
    
    if (self.delegate) {
        [self.delegate interstitialAdDidClose:self];
    }
}

- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
    //NSLog(@"nativeExpresInterstitialAdDidCloseOtherController");
    
}

@end
