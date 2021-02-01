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


@interface SYBannerView () <BUNativeExpressBannerViewDelegate>
@property(nonatomic, strong) NSString* slotID;
@property(nonatomic, strong) NSString* buSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* pszRequestId;

@property (nonatomic, strong) UIViewController *rootViewController;

@property (strong, nonatomic) BUNativeExpressAdManager *nativeExpressAdManager;
@property (strong, nonatomic) BUNativeExpressAdView *expressAdViews;
@end

@implementation SYBannerView

- (id) init {
    self = [super init];
    if (self) {
        self.buSlotID = nil;
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.delegate = nil;
        self.pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (NSString*)getRealSlotID:(NSString *)slotID {
    NSArray* arySlot = SYAdSDKManager.dictConfig[@"data"][@"slotInfo"];
    if (nil == arySlot) {
        return nil;
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot) {
            return nil;
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSDictionary* dictSlotConfig = dictSlot[@"config"][0];
            
            self.m_nResourceType = dictSlotConfig[@"resourceType"];
            switch ([self.m_nResourceType longValue]) {
                case 1:
                    self.buSlotID = dictSlotConfig[@"configParams"][@"gdt_slot_id"];
                    break;
                case 2:
                    self.buSlotID = dictSlotConfig[@"configParams"][@"tt_slot_id"];
                    break;
                case 3:
                    self.buSlotID = dictSlotConfig[@"configParams"][@"shiyu_slot_id"];
                    break;
                default:
                    self.buSlotID = dictSlotConfig[@"configParams"][@"tt_slot_id"];
                    break;
            }
            
            return self.buSlotID;
        }
    }
    
    return self.buSlotID;
}

- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(SYBannerSize)adsize {

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
    
    self.slotID = slotID;
    self.buSlotID = [self getRealSlotID:slotID];
    self.rootViewController = rootViewController;
    
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = self.buSlotID;
    slot.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    slot.imgSize = imgSize;
    slot.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot adSize:CGSizeMake(fWidth, fHeight)];
    }
//    self.nativeExpressAdManager.adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    self.nativeExpressAdManager.delegate = self;

    return self;
}

- (void)loadAdData {
    [self.nativeExpressAdManager loadAd:1];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11008];
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
    
    if (self.delegate) {
        [self.delegate bannerAdViewDidLoad:self];
    }
    
    BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)views[0];
    expressView.rootViewController = self.rootViewController;
    [expressView render];
    
    self.expressAdViews = expressView;
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    if (self.delegate) {
        [self.delegate bannerAdViewLoadFailed:self];
    }
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
//    NSLog(@"nativeExpressAdViewRenderSuccess");
    self.frame = nativeExpressAdView.frame;
    [self addSubview:self.expressAdViews];

    
    if (self.delegate) {
        [self.delegate bannerAdViewRenderSuccess:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11020];
}

- (void)updateCurrentPlayedTime {
    //NSLog(@"nativeExpressAdViewRenderSuccess");

}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    if (self.delegate) {
        [self.delegate bannerAdViewRenderFail:self];
    }
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11009];
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.delegate) {
        [self.delegate bannerAdViewWillBecomVisible:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:1];
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.delegate) {
        [self.delegate bannerAdViewDidClick:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:2];
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
