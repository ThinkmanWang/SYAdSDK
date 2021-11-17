//
//  SYInterstitialAd.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/1/26.
//

#import "SYInterstitialAd.h"
#import "SYAdSDKManager.h"

#import <BUAdSDK/BUAdSDK.h>

#import "log/SYLogUtils.h"
#import "ad_views/IInterstitialAd.h"
#import "ad_views/bytedance/InterstitialAdCSJ.h"
#import "SlotUtils.h"

@interface SYInterstitialAd () <SYInterstitialAdDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, strong) id<IInterstitialAd> interstitialAd;

@end

@implementation SYInterstitialAd

- (id) init {
    self = [super init];
    if (self) {
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.m_pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID adSize:(SYInterstitialAdSize)adsize {
    self.m_pszSlotID = slotID;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.m_nResourceType = [SlotUtils getResourceType:slotID];
#ifdef TEST_FOR_GDT
    self.m_nResourceType = [NSNumber numberWithInt:1];
#endif
#ifdef TEST_FOR_BYTEDANCE
    self.m_nResourceType = [NSNumber numberWithInt:2];
#endif
    
    switch ([self.m_nResourceType longValue]) {
        case 1: //gdt
            self.interstitialAd = [[InterstitialAdCSJ alloc] init];
            break;
        case 2: //bytedance
            self.interstitialAd = [[InterstitialAdCSJ alloc] init];
            break;
        case 3: //SY
            self.interstitialAd = [[InterstitialAdCSJ alloc] init];
            break;
        default: //bytedance
            self.interstitialAd = [[InterstitialAdCSJ alloc] init];
            break;
    }
    
    [self.interstitialAd setSYDelegate:self];
    [self.interstitialAd setRequestID:self.m_pszRequestId];
    [self.interstitialAd initWithSlotID:self.m_pszSlotID adSize:adsize];
    
    return self;
}

/**
 Load interstitial ad datas.
 */
- (void)loadAdData {
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:-1 type:11008];
    return [self.interstitialAd loadAdData];
}

/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:-1 type:1];
    self.rootViewController = rootViewController;
    
    if (self.interstitialAd) {
        return [self.interstitialAd showAdFromRootViewController:self.rootViewController];
    }
    
    return NO;
}

#pragma mark -events
/**
 This method is called when interstitial ad material loaded successfully.
 */
- (void)interstitialAdDidLoad:(id<IInterstitialAd>)interstitialAd {
    if (self.delegate) {
        [self.delegate interstitialAdDidLoad:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:-1 type:11020];
}

/**
 This method is called when interstitial ad material failed to load.
 */
- (void)interstitialAd:(id<IInterstitialAd>)interstitialAd {
    if (self.delegate) {
        [self.delegate interstitialAd:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:-1 type:11009];
}

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)interstitialAdRenderSuccess:(id<IInterstitialAd>)interstitialAd {
    if (self.delegate) {
        [self.delegate interstitialAdRenderSuccess:self];
    }
    
    
}

/**
 This method is called when a nativeExpressAdView failed to render.
 */
- (void)interstitialAdRenderFail:(id<IInterstitialAd>)interstitialAd {
    if (self.delegate) {
        [self.delegate interstitialAdRenderFail:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:-1 type:11009];
}

/**
 This method is called when interstitial ad slot will be showing.
 */
- (void)interstitialAdWillVisible:(id<IInterstitialAd>)interstitialAd {
    if (self.delegate) {
        [self.delegate interstitialAdWillVisible:self];
    }
}

/**
 This method is called when interstitial ad is clicked.
 */
- (void)interstitialAdDidClick:(id<IInterstitialAd>)interstitialAd {
    if (self.delegate) {
        [self.delegate interstitialAdDidClick:self];
    }    
}

/**
 This method is called when interstitial ad is about to close.
 */
- (void)interstitialAdWillClose:(id<IInterstitialAd>)interstitialAd {
    if (self.delegate) {
        [self.delegate interstitialAdWillClose:self];
    }
}

/**
 This method is called when interstitial ad is closed.
 */
- (void)interstitialAdDidClose:(id<IInterstitialAd>)interstitialAd {
    if (self.delegate) {
        [self.delegate interstitialAdDidClose:self];
    }
}


//#pragma mark -BUNativeExpresInterstitialAdDelegate
//- (void)nativeExpresInterstitialAdDidLoad:(id<IInterstitialAd>)interstitialAd {
//    //NSLog(@"nativeExpresInterstitialAdDidLoad");
//    if (self.delegate) {
//        [self.delegate interstitialAdDidLoad:self];
//    }
//
//}
//
//- (void)nativeExpresInterstitialAd:(id<IInterstitialAd>)interstitialAd {
////    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
//    //NSLog(@"nativeExpresInterstitialAd");
//    if (self.delegate) {
//        [self.delegate interstitialAd:self];
//    }
//
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11012];
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11009];
//}
//
//- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
////    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
//    //NSLog(@"nativeExpresInterstitialAdRenderSuccess");
//
//    if (self.delegate) {
//        [self.delegate interstitialAdRenderSuccess:self];
//    }
//
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11011];
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11020];
//}
//
//- (void)nativeExpresInterstitialAdRenderFail:(id<IInterstitialAd>)interstitialAd {
////    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
//    //NSLog(@"nativeExpresInterstitialAdRenderFail");
//
//    if (self.delegate) {
//        [self.delegate interstitialAdRenderFail:self];
//    }
//
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11009];
//}
//
//- (void)nativeExpresInterstitialAdWillVisible:(id<IInterstitialAd>)interstitialAd {
//    //NSLog(@"nativeExpresInterstitialAdWillVisible");
//
//    if (self.delegate) {
//        [self.delegate interstitialAdWillVisible:self];
//    }
//
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:1];
//}
//
//- (void)nativeExpresInterstitialAdDidClick:(id<IInterstitialAd>)interstitialAd {
//    //NSLog(@"nativeExpresInterstitialAdDidClick");
//
//    if (self.delegate) {
//        [self.delegate interstitialAdDidClick:self];
//    }
//
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:2];
//}
//
//- (void)nativeExpresInterstitialAdWillClose:(id<IInterstitialAd>)interstitialAd {
//    //NSLog(@"nativeExpresInterstitialAdWillClose");
//
//    if (self.delegate) {
//        [self.delegate interstitialAdWillClose:self];
//    }
//}
//
//- (void)nativeExpresInterstitialAdDidClose:(id<IInterstitialAd>)interstitialAd {
//    //NSLog(@"nativeExpresInterstitialAdDidClose");
//    self.interstitialAd = nil;
//
//    if (self.delegate) {
//        [self.delegate interstitialAdDidClose:self];
//    }
//}
//
//- (void)nativeExpresInterstitialAdDidCloseOtherController:(id<IInterstitialAd>)interstitialAd interactionType:(BUInteractionType)interactionType {
//    //NSLog(@"nativeExpresInterstitialAdDidCloseOtherController");
//
//}

@end
