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
#import "StringUtils.h"


#ifdef USE_CIRCLE_PROGREESS_BUTTON
#import "../button/SYDrawingCircleProgressButton.h"
#import "../button/SYCountDownButton.h"
#import "../button/SYSkipButton.h"
#import "../button/SYCircleCountDownButton.h"
#endif


@interface SplashAdViewGDT () <GDTSplashAdDelegate,GDTSplashZoomOutViewDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@property (nonatomic, weak, nullable) id<ISplashAdViewDelegate> syDelegate;
@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, strong) GDTSplashAd *splashAd;

#ifdef USE_CIRCLE_PROGREESS_BUTTON
@property (nonatomic, strong) SYCountDownButton* m_btnCountDown; //1,2
@property (nonatomic, strong) SYSkipButton* m_btnSkip; //3,4
@property (nonatomic, strong) SYDrawingCircleProgressButton *progressButton; //5,6
@property (nonatomic, strong) SYCircleCountDownButton* m_btnCircleCountDown; //7,8
#endif

@end

static int g_nSplashSkipType = 5;

@implementation SplashAdViewGDT

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszBuSlotID = @"";
        self.syDelegate = nil;
        self.rootViewController = nil;
#ifdef USE_CIRCLE_PROGREESS_BUTTON
        self.m_btnCountDown = nil;
        self.m_btnSkip = nil;
        self.progressButton = nil;
        self.m_btnCircleCountDown = nil;
#endif
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.m_pszSlotID = slotID;
    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
    g_nSplashSkipType = [SlotUtils getSplashType:self.m_pszSlotID];
#ifdef TEST_FOR_GDT
    self.m_pszBuSlotID = @"9040714184494018";
#endif
    
    return self;
}

#ifdef USE_CIRCLE_PROGREESS_BUTTON
- (SYCountDownButton*) m_btnCountDown
{
    if (nil == _m_btnCountDown) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        if (1 == g_nSplashSkipType) {
            _m_btnCountDown = [[SYCountDownButton alloc] initWithFrame:CGRectMake(rect.size.width - 80.f, 30, 70, 30)];
        } else if (2 == g_nSplashSkipType) {
            _m_btnCountDown = [[SYCountDownButton alloc] initWithFrame:CGRectMake(rect.size.width - 80.f, rect.size.height - 60, 70, 30)];
        } else {
            _m_btnCountDown = [[SYCountDownButton alloc] initWithFrame:CGRectMake(rect.size.width - 80.f, 30, 70, 30)];
        }
    }
    
    return _m_btnCountDown;
}

- (SYSkipButton*) m_btnSkip
{
    if (nil == _m_btnSkip) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        if (3 == g_nSplashSkipType) {
            _m_btnSkip = [[SYSkipButton alloc] initWithFrame:CGRectMake(rect.size.width - 80.f, 30, 70, 30)];
        } else if (4 == g_nSplashSkipType) {
            _m_btnSkip = [[SYSkipButton alloc] initWithFrame:CGRectMake(rect.size.width - 80.f, rect.size.height - 60, 70, 30)];
        } else {
            _m_btnSkip = [[SYSkipButton alloc] initWithFrame:CGRectMake(rect.size.width - 80.f, 30, 70, 30)];
        }
    }
    
    return _m_btnSkip;
}

- (SYDrawingCircleProgressButton*)progressButton
{
    if (nil == _progressButton) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        CGRect buttonFrame = (CGRect) {
            .origin.x = rect.size.width - 55.f,
            .origin.y = 30.f,
            .size.width = 45.f,
            .size.height = 45.f
        };
        
        if (6 == g_nSplashSkipType) {
            buttonFrame = (CGRect) {
                .origin.x = rect.size.width - 55.f,
                .origin.y = rect.size.height - 75.f,
                .size.width = 45.f,
                .size.height = 45.f
            };
        }
        
        _progressButton = [[SYDrawingCircleProgressButton alloc] initWithFrame:buttonFrame];
//        _progressButton = [[SYDrawingCircleProgressButton alloc] init];
        _progressButton.lineWidth = 2.f;
        [_progressButton setTitle:@"跳过" forState:UIControlStateNormal];
        _progressButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_progressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_progressButton addTarget:self action:@selector(__skipButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _progressButton;
}

- (SYCircleCountDownButton*) m_btnCircleCountDown
{
    if (nil == _m_btnCircleCountDown) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        if (7 == g_nSplashSkipType) {
            _m_btnCircleCountDown = [[SYCircleCountDownButton alloc] initWithFrame:CGRectMake(rect.size.width - 60.f, 30, 50, 50)];
        } else if (8 == g_nSplashSkipType) {
            _m_btnCircleCountDown = [[SYCircleCountDownButton alloc] initWithFrame:CGRectMake(rect.size.width - 60.f, rect.size.height - 80, 50, 50)];
        } else {
            _m_btnCircleCountDown = [[SYCircleCountDownButton alloc] initWithFrame:CGRectMake(rect.size.width - 60.f, 30, 50, 50)];
        }
    }
    
    return _m_btnCircleCountDown;
}

#endif

- (void)loadAdData {
    if ([StringUtils isEmpty:self.m_pszBuSlotID]
        || [StringUtils isEmpty:SYAdSDKManager.gdtAppID]) {
        return;
    }
    
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
#ifdef USE_CIRCLE_PROGREESS_BUTTON
    
    switch (g_nSplashSkipType) {
        case 1:
        case 2:
            [self.splashAd showAdInWindow:fK withBottomView:nil skipView:self.m_btnCountDown];
            break;
        case 3:
        case 4:
            [self.splashAd showAdInWindow:fK withBottomView:nil skipView:self.m_btnSkip];
            break;
        case 5:
        case 6:
            [self.splashAd showAdInWindow:fK withBottomView:nil skipView:self.progressButton];
            break;
        case 7:
        case 8:
            [self.splashAd showAdInWindow:fK withBottomView:nil skipView:self.m_btnCircleCountDown];
            break;
        default:
            [self.splashAd showAdInWindow:fK withBottomView:nil skipView:nil];
            break;
    }
    
#else
    [self.splashAd showAdInWindow:fK withBottomView:nil skipView:nil];
#endif
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidLoad:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11011];
}

- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    
#ifdef USE_CIRCLE_PROGREESS_BUTTON
    if (nil != self.progressButton
        && (5 == g_nSplashSkipType
            || 6 == g_nSplashSkipType
            || g_nSplashSkipType < 1
            || g_nSplashSkipType > 8)) {
        [_progressButton startProgressAnimationWithDuration:5 completionHandler:nil];
    }
#endif
    
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
