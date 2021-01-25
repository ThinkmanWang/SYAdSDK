//
//  SYBannerView.m
//  SYAdSSDK
//
//  Created by 王晓丰 on 2021/1/25.
//

#import "SYBannerView.h"
#import "SYAdSDKDefines.h"

#import <BUAdSDK/BUAdSDK.h>

@interface SYBannerView () <BUNativeExpressBannerViewDelegate>
@property(nonatomic, strong) NSString* slotID;
@property(nonatomic, strong) NSString* buSlotID;

@property (nonatomic, weak) UIViewController *rootViewController;

@property (strong, nonatomic) BUNativeExpressAdManager *nativeExpressAdManager;
@property (strong, nonatomic) BUNativeExpressAdView *expressAdViews;
@end

@implementation SYBannerView

- (id) init {
    self = [super init];
    if (self) {
        self.buSlotID = @"945746795";
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(SYBannerSize)adsize {
//    NSValue *sizeValue = nil;
//    switch (adsize) {
//        case SYBannerSize600_300:
//            sizeValue = [sizeDcit objectForKey:@"945742204"];
//            break;
//        case SYBannerSize600_400:
//            sizeValue = [sizeDcit objectForKey:@"945742204"];
//            break;
//        case SYBannerSize600_500:
//            sizeValue = [sizeDcit objectForKey:@"945742204"];
//            break;
//        case SYBannerSize600_260:
//            sizeValue = [sizeDcit objectForKey:@"945741009"];
//            break;
//        case SYBannerSize600_90 :
//            sizeValue = [sizeDcit objectForKey:@"945741009"];
//            break;
//        case SYBannerSize600_150:
//            sizeValue = [sizeDcit objectForKey:@"945741009"];
//            break;
//        case SYBannerSize640_100:
//            sizeValue = [sizeDcit objectForKey:@"945741009"];
//            break;
//        case SYBannerSize690_388:
//            sizeValue = [sizeDcit objectForKey:@"945742204"];
//            break;
//        default:
//            sizeValue = [sizeDcit objectForKey:@"945741009"];
//            break;
//    }
    
    self.slotID = slotID;
    self.rootViewController = rootViewController;
    
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = self.buSlotID;
    slot.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot.imgSize = imgSize;
    slot.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot adSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0)];
    }
    self.nativeExpressAdManager.adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    self.nativeExpressAdManager.delegate = self;

    return self;
}

- (void)loadAdData {
    [self.nativeExpressAdManager loadAd:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    if (views.count <= 0) {
        return;
    }
    
    [self.delegate bannerAdViewDidLoad:self];
    
    BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)views[0];
    expressView.rootViewController = self.rootViewController;
    [expressView render];
    
    self.expressAdViews = expressView;
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    [self.delegate bannerAdViewLoadFailed:self];
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"nativeExpressAdViewRenderSuccess");
    [self.delegate bannerAdViewRenderSuccess:self];
    
    [self addSubview:self.expressAdViews];
}

- (void)updateCurrentPlayedTime {
    NSLog(@"nativeExpressAdViewRenderSuccess");

}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    [self.delegate bannerAdViewRenderFail:self];
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.delegate bannerAdViewWillBecomVisible:self];
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.delegate bannerAdViewDidClick:self];
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
