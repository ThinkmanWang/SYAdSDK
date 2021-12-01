//
//  BannerViewCSJ.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/18.
//

#import "BannerViewCSJ.h"

#import <UIKit/UIKit.h>
//#import "SYAdSDKManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "SYLogUtils.h"
#import "SYAdSDKManager.h"
#import "SlotUtils.h"

@interface BannerViewCSJ () <BUNativeExpressBannerViewDelegate>

@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@property (strong, nonatomic) BUNativeExpressAdManager *nativeExpressAdManager;
@property (nonatomic, weak) UIViewController *rootViewController;
@property CGFloat m_fWidth;
@property CGFloat m_fHeight;

//@property (nonatomic, weak, nullable) id<SYBannerViewDelegate> syDelegate;

@end

@implementation BannerViewCSJ

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszBuSlotID = @"";
        self.m_pszRequestId = @"";
        self.nativeExpressAdManager = nil;
        self.rootViewController = nil;
        
        self.syDelegate = nil;
        self.m_fWidth = 0;
        self.m_fHeight = 0;
        
//        self.m_pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(SYBannerSize)adsize {
    self.m_pszSlotID = slotID;
    self.rootViewController = rootViewController;
    
    CGFloat fWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat fHeight = 0;
    switch (adsize) {
        case SYBannerSize600_300:
            fHeight = 300 * fWidth / 600;
            break;
        case SYBannerSize600_400:
            fHeight = 400 * fWidth / 600;
            break;
        case SYBannerSize600_500:
            fHeight = 500 * fWidth / 600;
            break;
        case SYBannerSize600_260:
            fHeight = 260 * fWidth / 600;
            break;
        case SYBannerSize600_90 :
            fHeight = 90 * fWidth / 600;
            break;
        case SYBannerSize600_150:
            fHeight = 150 * fWidth / 600;
            break;
        case SYBannerSize640_100:
            fHeight = 100 * fWidth / 640;
            break;
        case SYBannerSize690_388:
            fHeight = 388 * fWidth / 690;
            break;
        default:
            fHeight = 300 * fWidth / 600;
            break;
    }
    
    self.m_fWidth = fWidth;
    self.m_fHeight = fHeight;

    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
#ifdef TEST_FOR_BYTEDANCE
    self.m_pszBuSlotID = @"947093826";
#endif
    self.rootViewController = rootViewController;

    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = self.m_pszBuSlotID;
    slot.AdType = BUAdSlotAdTypeFeed;
    slot.supportRenderControl = YES;
//    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
//    slot.imgSize = imgSize;
    slot.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot adSize:CGSizeMake(fWidth, fHeight)];
    }
    self.nativeExpressAdManager.adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    self.nativeExpressAdManager.delegate = self;
    
    return self;
}

- (void)loadAdData {
//    [self.nativeExpressAdManager loadAd:1];
    [self.nativeExpressAdManager loadAdDataWithCount:1];
//    [self.nativeExpressAdManager setExp]
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11010];
}

- (CGRect)getFrame {
    return self.frame;
}
- (void)setSYDelegate:(id<ISYBannerViewDelegate>)delegate {
    self.syDelegate = delegate;
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    if (views.count <= 0) {
        return;
    }
    
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewDidLoad:self];
    }
    
    BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)views[0];
    expressView.rootViewController = self.rootViewController;
    [expressView render];
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewLoadFailed:self];
    }
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    self.frame = nativeExpressAdView.frame;
    [self addSubview:nativeExpressAdView];
    
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewRenderSuccess:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11011];
}

- (void)updateCurrentPlayedTime {
    //NSLog(@"nativeExpressAdViewRenderSuccess");

}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewRenderFail:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11012];
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewWillBecomVisible:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:1];
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewDidClick:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:2];
}

- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    
}

- (void)nativeExpressAdViewDidClosed:(BUNativeExpressAdView *)nativeExpressAdView {
}

- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
}

- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType {
}


@end
