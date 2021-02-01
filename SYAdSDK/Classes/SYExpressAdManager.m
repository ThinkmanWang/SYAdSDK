//
//  SYExpressAdManager.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/1/26.
//

#import "SYExpressAdManager.h"

#import "SYExpressAdView.h"
#import "SYAdSDKManager.h"

#import <BUAdSDK/BUAdSDK.h>
#import "log/SYLogUtils.h"


@interface SYExpressAdManager () <BUSplashAdDelegate>

@property(nonatomic, strong) NSString* buSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* pszRequestId;

@property(nonatomic, strong) BUNativeExpressAdManager* nativeExpressAdManager;
@property (strong, nonatomic) NSMutableArray<__kindof BUNativeExpressAdView *> *expressAdViews;
@property (strong, nonatomic) NSMutableArray<__kindof SYExpressAdView *> *syExpressAdViews;

@end

@implementation SYExpressAdManager

- (id) init {
    self = [super init];
    if (self) {
        self.delegate = nil;
        self.buSlotID = nil;
        self.m_nResourceType = [NSNumber numberWithInt:2];
        
        self.expressAdViews = [NSMutableArray new];
        self.syExpressAdViews = [NSMutableArray new];
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

/**
 @param size expected ad view size，when size.height is zero, acture height will match size.width
 */
- (instancetype)initWithSlotID:(NSString *)slotID rootViewController:(UIViewController *)rootViewController adSize:(CGSize)size {
    self.slotID = slotID;
    self.buSlotID = [self getRealSlotID:slotID];
    
    self.rootViewController = rootViewController;
    
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = self.buSlotID;
    slot.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot.imgSize = imgSize;
    slot.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot adSize:size];
    }

    self.nativeExpressAdManager.delegate = self;
    
    return self;
}

/**
 The number of ads requested,The maximum is 3
 */
- (void)loadAdDataWithCount:(NSInteger)count {
    if (count < 1) {
        count = 1;
    }
    
    if (count > 3) {
        count = 3;
    }
    
    [self.nativeExpressAdManager loadAdDataWithCount:count];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11008 adCount:count];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11010 adCount:count];
}

/**
 * Sent when views successfully load ad
 */
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    [self.expressAdViews removeAllObjects];
    [self.syExpressAdViews removeAllObjects];
    
    if (views.count) {
        [self.expressAdViews addObjectsFromArray:views];
        
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self.rootViewController;
            
            //TODO: Add to SYExpressVieew
            SYExpressAdView* syExpress = [[SYExpressAdView alloc] init];
            [syExpress addSubview:expressView];
            
            [self.syExpressAdViews addObject:syExpress];
            
            
            [expressView render];
        }];
        
    }
    
    if (self.delegate) {
        [self.delegate expressAdSuccessToLoad:self views:self.syExpressAdViews];
    }
}

/**
 * Sent when views fail to load ad
 */
- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *_Nullable)error {
    if (self.delegate) {
        [self.delegate expressAdFailToLoad:self];
    }
}

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.delegate) {
        SYExpressAdView* view = nativeExpressAdView.superview;
        view.frame = nativeExpressAdView.frame;
        
        [self.delegate expressAdViewRenderSuccess:view];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11011];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11020];
}

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error {
    if (self.delegate) {
        [self.delegate expressAdViewRenderFail:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11012];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11009];
}

/**
 * Sent when an ad view is about to present modal content
 */
- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.delegate) {
        [self.delegate expressAdViewWillShow:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:1];
}

/**
 * Sent when an ad view is clicked
 */
- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.delegate) {
        [self.delegate expressAdViewDidClick:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:2];
}

/**
Sent when a playerw playback status changed.
@param playerState : player state after changed
*/
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
    
}

/**
 * Sent when a player finished
 * @param error : error of player
 */
- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    if (self.delegate) {
        [self.delegate expressAdViewPlayerDidPlayFinish:nativeExpressAdView.superview];
    }
}

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    if (self.delegate) {
        [self.delegate expressAdView:nativeExpressAdView.superview];
    }
}

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.delegate) {
        [self.delegate expressAdViewWillPresentScreen:nativeExpressAdView.superview];
    }
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType {
    
}

@end
