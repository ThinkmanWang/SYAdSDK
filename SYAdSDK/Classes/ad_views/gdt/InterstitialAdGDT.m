//
//  InterstitialAdGDT.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/3/20.
//

#import "InterstitialAdGDT.h"

#import <UIKit/UIKit.h>
//#import "SYAdSDKManager.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "SYLogUtils.h"
#import "SYAdSDKManager.h"
#import "SlotUtils.h"
#import "IInterstitialAd.h"

@interface InterstitialAdGDT ()
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@property (nonatomic, weak, nullable) id<IInterstitialAdDelegate> syDelegate;
@property (nonatomic, weak) UIViewController *rootViewController;


@end

@implementation InterstitialAdGDT

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

- (instancetype)initWithSlotID:(NSString *)slotID adSize:(SYInterstitialAdSize)adsize {
    self.m_pszSlotID = slotID;
    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
    
    CGFloat fWidth = 0;
    CGFloat fHeight = 0;
    
    switch (adsize) {
        case SYInterstitialAdSize600_600:
            fWidth = [UIScreen mainScreen].bounds.size.width * 6 / 10;
            fHeight = fWidth;
            break;
        case SYInterstitialAdSize600_900:
            fWidth = [UIScreen mainScreen].bounds.size.width * 6 / 10;
            fHeight = fWidth * 3 / 2;
            break;
        default:
            fWidth = [UIScreen mainScreen].bounds.size.width * 6 / 10;
            fHeight = fWidth;
            break;
    }
    
    self.delegate = self;
    
#ifdef TEST_FOR_GDT
    self.m_pszBuSlotID = @"1050652855580392";
#endif
    
    self = [super initWithPlacementId:self.m_pszBuSlotID];
    
    self.delegate = self;
    self.videoMuted = YES;
    self.detailPageVideoMuted = YES;
    self.videoAutoPlayOnWWAN = YES;
    self.minVideoDuration = 5;
    self.maxVideoDuration = 30;
    
//    BUInterstitialAd* pAdVieew = [super initWithSlotID:self.m_pszBuSlotID adSize:CGSizeMake(fWidth, fHeight)];
    return self;
}

/**
 Load interstitial ad datas.
 */
- (void)loadAdData {
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11010];
    
    [super loadAd];
}

/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:1];
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:1];
    self.rootViewController = rootViewController;
    
    [self presentAdFromRootViewController:self.rootViewController];
    return YES;
//    return [super showAdFromRootViewController:self.rootViewController];
}

- (void)setSYDelegate:(id<IInterstitialAdDelegate>)delegate {
    self.syDelegate = delegate;
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

#pragma mark - GDTUnifiedInterstitialAdDelegate

/**
 *  插屏2.0广告预加载成功回调
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)unifiedInterstitialSuccessToLoadAd:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"eCPM:%ld eCPMLevel:%@", [unifiedInterstitial eCPM], [unifiedInterstitial eCPMLevel]);
    NSLog(@"videoDuration:%lf isVideo: %@", unifiedInterstitial.videoDuration, @(unifiedInterstitial.isVideoAd));
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdDidLoad:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11011];
}

/**
 *  插屏2.0广告预加载失败回调
 *  当接收服务器返回的广告数据失败后调用该函数
 */
- (void)unifiedInterstitialFailToLoadAd:(GDTUnifiedInterstitialAd *)unifiedInterstitial error:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"interstitial fail to load, Error : %@",error);
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAd:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11012];
}

/**
 *  插屏2.0广告将要展示回调
 *  插屏2.0广告即将展示回调该函数
 */
- (void)unifiedInterstitialWillPresentScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    if (self.syDelegate) {
        [self.syDelegate interstitialAdRenderSuccess:self];
    }   
}

- (void)unifiedInterstitialFailToPresent:(GDTUnifiedInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdRenderFail:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11012];
}

/**
 *  插屏2.0广告视图展示成功回调
 *  插屏2.0广告展示成功回调该函数
 */
- (void)unifiedInterstitialDidPresentScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdWillVisible:self];
    }
}

/**
 *  插屏2.0广告展示结束回调
 *  插屏2.0广告展示结束回调该函数
 */
- (void)unifiedInterstitialDidDismissScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  当点击下载应用时会调用系统程序打开
 */
- (void)unifiedInterstitialWillLeaveApplication:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  插屏2.0广告曝光回调
 */
- (void)unifiedInterstitialWillExposure:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  插屏2.0广告点击回调
 */
- (void)unifiedInterstitialClicked:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate interstitialAdDidClick:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:2];
}

/**
 *  点击插屏2.0广告以后即将弹出全屏广告页
 */
- (void)unifiedInterstitialAdWillPresentFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  点击插屏2.0广告以后弹出全屏广告页
 */
- (void)unifiedInterstitialAdDidPresentFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页将要关闭
 */
- (void)unifiedInterstitialAdWillDismissFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页被关闭
 */
- (void)unifiedInterstitialAdDidDismissFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}


/**
 * 插屏2.0视频广告 player 播放状态更新回调
 */
- (void)unifiedInterstitialAd:(GDTUnifiedInterstitialAd *)unifiedInterstitial playerStatusChanged:(GDTMediaPlayerStatus)status
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 * 插屏2.0视频广告详情页 WillPresent 回调
 */
- (void)unifiedInterstitialAdViewWillPresentVideoVC:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 * 插屏2.0视频广告详情页 DidPresent 回调
 */
- (void)unifiedInterstitialAdViewDidPresentVideoVC:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 * 插屏2.0视频广告详情页 WillDismiss 回调
 */
- (void)unifiedInterstitialAdViewWillDismissVideoVC:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 * 插屏2.0视频广告详情页 DidDismiss 回调
 */
- (void)unifiedInterstitialAdViewDidDismissVideoVC:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

@end
