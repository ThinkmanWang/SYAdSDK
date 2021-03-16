//
//  SYBannerView.m
//  SYAdSSDK
//
//  Created by 王晓丰 on 2021/1/25.
//

#import "SYBannerView.h"
#import "SYAdSDKDefines.h"
#import "SYAdSDKManager.h"


#import <BUAdSDK/BUAdSDK.h>
#import "log/SYLogUtils.h"
#import "utils/SlotUtils.h"
#import "ad_views/IBannerView.h"
#import "ad_views/bytedance/BannerViewCSJ.h"

@interface SYBannerView () <ISYBannerViewDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property (nonatomic, weak) UIViewController *rootViewController;

@property (nonatomic, weak) id<IBannerView> bannerView;
@end

@implementation SYBannerView

- (id) init {
    self = [super init];
    if (self) {
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.delegate = nil;
        self.m_pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(SYBannerSize)adsize {
    
    self.m_pszSlotID = slotID;
    self.m_nResourceType = [SlotUtils getResourceType:slotID];
    self.rootViewController = rootViewController;
    
    switch ([self.m_nResourceType longValue]) {
        case 1: //gdt
            self.bannerView = [[BannerViewCSJ alloc] init];
            break;
        case 2: //bytedance
            self.bannerView = [[BannerViewCSJ alloc] init];
            break;
        case 3: //SY
            self.bannerView = [[BannerViewCSJ alloc] init];
            break;
        default: //bytedance
            self.bannerView = [[BannerViewCSJ alloc] init];
            break;
    }
    
    [self.bannerView setSYDelegate:self];
    [self.bannerView setRequestID:self.m_pszRequestId];
    [self.bannerView initWithSlotID:self.m_pszSlotID rootViewController:rootViewController adSize:adsize];

    return self;
}

- (void)loadAdData {
    [self.bannerView loadAdData];
//    [self.nativeExpressAdManager loadAd:1];
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:-1 type:11008];
}

#pragma mark - events

/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 */
- (void)bannerAdViewDidLoad:(id<IBannerView>)bannerAdView {
    if (self.delegate) {
        [self.delegate bannerAdViewDidLoad:self];
    }
}

/**
 This method is called when bannerAdView ad slot failed to load.
 */
- (void)bannerAdViewLoadFailed:(id<IBannerView>)bannerAdView {
    if (self.delegate) {
        [self.delegate bannerAdViewLoadFailed:self];
    }
}

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)bannerAdViewRenderSuccess:(id<IBannerView>)bannerAdView {
    self.frame = [bannerAdView getFrame];
    [self addSubview:bannerAdView];
    
    if (self.delegate) {
        [self.delegate bannerAdViewRenderSuccess:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:-1 type:11020];    
}

/**
 This method is called when a nativeExpressAdView failed to render.
 */
- (void)bannerAdViewRenderFail:(id<IBannerView>)bannerAdView {
    if (self.delegate) {
        [self.delegate bannerAdViewRenderFail:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:-1 type:11009];
}

/**
 This method is called when bannerAdView ad slot showed new ad.
 */
- (void)bannerAdViewWillBecomVisible:(id<IBannerView>)bannerAdView {
    if (self.delegate) {
        [self.delegate bannerAdViewWillBecomVisible:self];
    }
    
}

/**
 This method is called when bannerAdView is clicked.
 */
- (void)bannerAdViewDidClick:(id<IBannerView>)bannerAdView {
    if (self.delegate) {
        [self.delegate bannerAdViewDidClick:self];
    }    
}

//#pragma mark - BUNativeExpressAdViewDelegate
//- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
//    if (views.count <= 0) {
//        return;
//    }
//
//    if (self.delegate) {
//        [self.delegate bannerAdViewDidLoad:self];
//    }
//
//    BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)views[0];
//    expressView.rootViewController = self.rootViewController;
//    [expressView render];
//
//    self.expressAdViews = expressView;
//}
//
//- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd {
//    if (self.delegate) {
//        [self.delegate bannerAdViewLoadFailed:self];
//    }
//}
//
//- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
////    NSLog(@"nativeExpressAdViewRenderSuccess");
//    self.frame = nativeExpressAdView.frame;
//    [self addSubview:self.expressAdViews];
//
//
//    if (self.delegate) {
//        [self.delegate bannerAdViewRenderSuccess:self];
//    }
//
//    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11011];
//    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11020];
//}
//
//- (void)updateCurrentPlayedTime {
//    //NSLog(@"nativeExpressAdViewRenderSuccess");
//
//}
//
//- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
//}
//
//- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView {
//    if (self.delegate) {
//        [self.delegate bannerAdViewRenderFail:self];
//    }
//
//    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11012];
//    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11009];
//}
//
//- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
//    if (self.delegate) {
//        [self.delegate bannerAdViewWillBecomVisible:self];
//    }
//
//    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:1];
//}
//
//- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
//    if (self.delegate) {
//        [self.delegate bannerAdViewDidClick:self];
//    }
//
//    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:2];
//}
//
//- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView {
//}
//
//- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
//
//}
//
//- (void)nativeExpressAdViewDidClosed:(BUNativeExpressAdView *)nativeExpressAdView {
//}
//
//- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
//}
//
//- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType {
//}


@end
