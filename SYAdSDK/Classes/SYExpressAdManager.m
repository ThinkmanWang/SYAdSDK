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
#import "SlotUtils.h"
#import "IExpressAdManager.h"
#import "ExpressAdManagerCSJ.h"

@interface SYExpressAdManager ()

@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* pszRequestId;

@property(nonatomic, strong) id<IExpressAdManager> nativeExpressAdManager;
//@property (nonatomic, strong) NSMutableArray<__kindof SYExpressAdView *> *expressAdViews;
@property (nonatomic, strong) NSMutableArray<__kindof SYExpressAdView *> *syExpressAdViews;

@end

@implementation SYExpressAdManager

- (id) init {
    self = [super init];
    if (self) {
        self.delegate = nil;
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.rootViewController = nil;
        
//        self.expressAdViews = [NSMutableArray new];
        self.syExpressAdViews = [NSMutableArray new];
        self.pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

/**
 @param size expected ad view size，when size.height is zero, acture height will match size.width
 */
- (instancetype)initWithSlotID:(NSString *)slotID rootViewController:(UIViewController *)rootViewController adSize:(CGSize)size {
    self.slotID = slotID;
    self.rootViewController = rootViewController;

    self.m_nResourceType = [SlotUtils getResourceType:slotID];
#ifdef TEST_FOR_BYTEDANCE
    self.m_nResourceType = [NSNumber numberWithInt:2];
#endif
    
    switch ([self.m_nResourceType longValue]) {
        case 1: //gdt
            self.nativeExpressAdManager = [[ExpressAdManagerCSJ alloc] init];
            break;
        case 2: //bytedance
            self.nativeExpressAdManager = [[ExpressAdManagerCSJ alloc] init];
            break;
        case 3: //SY
            self.nativeExpressAdManager = [[ExpressAdManagerCSJ alloc] init];
            break;
        default: //bytedance
            self.nativeExpressAdManager = [[ExpressAdManagerCSJ alloc] init];
            break;
    }
    
    [self.nativeExpressAdManager setSYDelegate:self];
    [self.nativeExpressAdManager setRequestID:self.pszRequestId];
    [self.nativeExpressAdManager initWithSlotID:self.slotID rootViewController:rootViewController adSize:size];
    
    return self;
}

/**
 The number of ads requested,The maximum is 3
 */
- (void)loadAdDataWithCount:(NSInteger)count {
    [self.nativeExpressAdManager loadAdDataWithCount:count];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:-1 type:11008 adCount:count];
}

/**
 * Sent when views successfully load ad
 */
- (void)expressAdSuccessToLoad:(id<IExpressAdManager>) expressAd views:(NSArray<__kindof UIView *> *)views {
//    [self.expressAdViews removeAllObjects];
    [self.syExpressAdViews removeAllObjects];
    
    if (views.count) {
//        [self.expressAdViews addObjectsFromArray:views];
        
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *expressView = (UIView *)obj;
            
            //TODO: Add to SYExpressVieew
            SYExpressAdView* syExpress = [[SYExpressAdView alloc] init];
            [syExpress addSubview:expressView];
            
            [self.syExpressAdViews addObject:syExpress];
        }];
        
    }
    
    if (self.delegate) {
        [self.delegate expressAdSuccessToLoad:self views:self.syExpressAdViews];
    }
}

/**
 * Sent when views fail to load ad
 */
- (void)expressAdFailToLoad:(id<IExpressAdManager>)expressAd {
    if (self.delegate) {
        [self.delegate expressAdFailToLoad:self];
    }
}

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)expressAdViewRenderSuccess:(UIView*)expressAdView {
    if (self.delegate) {
        SYExpressAdView* view = expressAdView.superview;
        view.frame = expressAdView.frame;
        
        [self.delegate expressAdViewRenderSuccess:view];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:-1 type:11020];
}

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)expressAdViewRenderFail:(UIView*)expressAdView {
    if (self.delegate) {
        [self.delegate expressAdViewRenderFail:expressAdView.superview];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:-1 type:11009];
}

/**
 * Sent when an ad view is about to present modal content
 */
- (void)expressAdViewWillShow:(UIView*)expressAdView {
    SYExpressAdView* view = expressAdView.superview;
    
    view.frame = CGRectMake(view.frame.origin.x
                            , view.frame.origin.y
                            , CGRectGetWidth(expressAdView.frame)
                            , CGRectGetHeight(expressAdView.frame));
    
    if (self.delegate) {
        [self.delegate expressAdViewWillShow:expressAdView.superview];
    }    
}

/**
 * Sent when an ad view is clicked
 */
- (void)expressAdViewDidClick:(UIView*)expressAdView {
    if (self.delegate) {
        [self.delegate expressAdViewDidClick:expressAdView.superview];
    }    
}

/**
Sent when a playerw playback status changed.
@param playerState : player state after changed
*/
//- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
//
//}

/**
 * Sent when a player finished
 * @param error : error of player
 */
- (void)expressAdViewPlayerDidPlayFinish:(UIView*)expressAdView {
    if (self.delegate) {
        [self.delegate expressAdViewPlayerDidPlayFinish:expressAdView.superview];
    }
}

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)expressAdView:(UIView*)expressAdView {
    if (self.delegate) {
        [self.delegate expressAdView:expressAdView.superview];
    }
}

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)expressAdViewWillPresentScreen:(UIView*)expressAdView {
    if (self.delegate) {
        [self.delegate expressAdViewWillPresentScreen:expressAdView.superview];
    }
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
//- (void)nativeExpressAdViewDidCloseOtherController:(UIView*)nativeExpressAdView interactionType:(BUInteractionType)interactionType {
//
//}

@end
