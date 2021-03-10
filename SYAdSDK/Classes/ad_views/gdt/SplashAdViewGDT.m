//
//  SplashAdViewGDT.m
//  Masonry
//
//  Created by 王晓丰 on 2021/2/22.
//

#import "SplashAdViewGDT.h"

#import "../../gdt/GDTSplashAd.h"
#import "../../gdt/GDTSDKConfig.h"

//#import "GDTSplashZoomOutView.h"

#import "../../SYAdSDKDefines.h"
#import "../../log/SYLogUtils.h"
#import "../../SYAdSDKManager.h"
#import "SlotUtils.h"
#import "SYAdSDKDefines.h"

@interface SplashAdViewGDT () <GDTSplashAdDelegate,GDTSplashZoomOutViewDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@property (nonatomic, weak, nullable) id<ISplashAdViewDelegate> syDelegate;
@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, strong) GDTSplashAd *splashAd;

@end

@implementation SplashAdViewGDT

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

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.m_pszSlotID = slotID;
    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
#ifdef TEST_FOR_GDT
    self.m_pszBuSlotID = @"9040714184494018";
#endif
    
    return self;
}

- (void)loadAdData {
    self.splashAd = [[GDTSplashAd alloc] initWithPlacementId:self.m_pszBuSlotID];
    self.splashAd.delegate = self;
    self.splashAd.fetchDelay = 5;
    self.splashAd.needZoomOut = NO;
    [self.splashAd loadAd];
}

- (void)removeMyself {
    [self removeFromSuperview];
}

- (CGRect)getFrame {
    return self.frame;
}

- (void)setSYRootViewController:(UIViewController*)rootViewController {
    self.rootViewController = rootViewController;
}

- (void)setSYDelegate:(id<ISplashAdViewDelegate>)delegate {
    self.syDelegate = delegate;
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

#pragma mark - GDTSplashAdDelegate

- (void)splashAdDidLoad:(GDTSplashAd *)splashAd {
    NSLog(@"%s", __func__);
    NSLog(@"ecpmLevel:%@", splashAd.eCPMLevel);
    
    UIWindow *fK = [[UIApplication sharedApplication] keyWindow];
    [self.splashAd showAdInWindow:fK withBottomView:nil skipView:nil];
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidLoad:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11011];
}

- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate splashAdWillVisible:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:1];
}

- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    NSLog(@"%s%@",__FUNCTION__,error);
    if (self.syDelegate) {
        [self.syDelegate splashAd:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11012];
}

- (void)splashAdExposured:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdClicked:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);

    if (self.syDelegate) {
        [self.syDelegate splashAdDidClick:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:2];
}

- (void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate splashAdWillClose:self];
    }
}

- (void)splashAdClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    self.splashAd = nil;
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidClose:self];
    }
}

- (void)splashAdWillPresentFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdDidPresentFullScreenModal:(GDTSplashAd *)splashAd
{
     NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillDismissFullScreenModal:(GDTSplashAd *)splashAd
{
     NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdDidDismissFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - GDTSplashZoomOutViewDelegate
- (void)splashZoomOutViewDidClick:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashZoomOutViewAdDidClose:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashZoomOutViewAdVideoFinished:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashZoomOutViewAdDidPresentFullScreenModal:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashZoomOutViewAdDidDismissFullScreenModal:(GDTSplashZoomOutView *)splashZoomOutView
{
    NSLog(@"%s",__FUNCTION__);
}

@end
