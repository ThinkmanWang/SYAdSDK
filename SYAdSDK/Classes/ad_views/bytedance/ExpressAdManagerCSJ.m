//
//  ExpressAdManagerCSJ.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/19.
//

#import "ExpressAdManagerCSJ.h"

#import <UIKit/UIKit.h>
//#import "SYAdSDKManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "SYLogUtils.h"
#import "SYAdSDKManager.h"
#import "SlotUtils.h"
#import "IExpressAdManager.h"

@interface ExpressAdManagerCSJ ()

@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@property (nonatomic, weak, nullable) id<IExpressAdManagerDelegate> syDelegate;
@property (nonatomic, weak) UIViewController *rootViewController;

@property (strong, nonatomic) NSMutableArray<__kindof BUNativeExpressAdView *> *expressAdViews;
@property (strong, nonatomic) NSMutableArray<__kindof UIView *> *syExpressAdViews;

@end

@implementation ExpressAdManagerCSJ

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszBuSlotID = @"";
        self.m_pszRequestId = @"";
        self.syDelegate = nil;
        self.rootViewController = nil;
        
        self.expressAdViews = [NSMutableArray new];
        self.syExpressAdViews = [NSMutableArray new];
    }
    
    return self;
}

/**
 @param size expected ad view size，when size.height is zero, acture height will match size.width
 */
- (instancetype)initWithSlotID:(NSString *)slotID rootViewController:(UIViewController *)rootViewController adSize:(CGSize)size {
    self.m_pszSlotID = slotID;
    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
    
    self.rootViewController = rootViewController;
    
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = self.m_pszBuSlotID;
    slot.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot.imgSize = imgSize;
    slot.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
    BUNativeExpressAdManager* pObj = [super initWithSlot:slot adSize:size];

    self.delegate = self;
    
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
    
    [super loadAdDataWithCount:count];
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11010 adCount:count];
}

- (void)setSYDelegate:(id<IExpressAdManagerDelegate>)delegate {
    self.syDelegate = delegate;
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

#pragma mark -events
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
            UIView* syExpress = [[UIView alloc] init];
            [syExpress addSubview:expressView];
            
            [self.syExpressAdViews addObject:syExpress];
            
            [expressView render];
        }];
        
    }
    
    if (self.syDelegate) {
        [self.syDelegate expressAdSuccessToLoad:self views:self.syExpressAdViews];
    }
}

/**
 * Sent when views fail to load ad
 */
- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *_Nullable)error {
    if (self.syDelegate) {
        [self.syDelegate expressAdFailToLoad:self];
    }
}

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.syDelegate) {
        UIView* view = nativeExpressAdView.superview;
        view.frame = nativeExpressAdView.frame;
        
        [self.syDelegate expressAdViewRenderSuccess:view];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11011];
}

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error {
    if (self.syDelegate) {
        [self.syDelegate expressAdViewRenderFail:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11012];
}

/**
 * Sent when an ad view is about to present modal content
 */
- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.syDelegate) {
        [self.syDelegate expressAdViewWillShow:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:1];
}

/**
 * Sent when an ad view is clicked
 */
- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.syDelegate) {
        [self.syDelegate expressAdViewDidClick:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:2];
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
    if (self.syDelegate) {
        [self.syDelegate expressAdViewPlayerDidPlayFinish:nativeExpressAdView.superview];
    }
}

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    if (self.syDelegate) {
        [self.syDelegate expressAdView:nativeExpressAdView.superview];
    }
}

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.syDelegate) {
        [self.syDelegate expressAdViewWillPresentScreen:nativeExpressAdView.superview];
    }
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType {
    
}

@end
