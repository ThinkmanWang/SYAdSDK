//
//  BannerViewGDT.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/23.
//

#import "BannerViewGDT.h"

#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "../../log/SYLogUtils.h"
#import "../../SYAdSDKManager.h"
#import "SlotUtils.h"
#import "SYAdSDKDefines.h"

#import <GDTMobSDK/GDTUnifiedBannerView.h>
#import "StringUtils.h"

@interface BannerViewGDT ()

@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, weak, nullable) id<ISYBannerViewDelegate> syDelegate;

@end

@implementation BannerViewGDT

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszBuSlotID = @"";
        self.m_pszRequestId = @"";
        
        self.rootViewController = nil;
        self.syDelegate = nil;        
    }
    
    return self;
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

    self.m_pszSlotID = slotID;
    self.m_pszBuSlotID = [SlotUtils getRealSlotID:slotID];
    self.rootViewController = rootViewController;
#ifdef TEST_FOR_GDT
    self.m_pszBuSlotID = @"1080958885885321";
#endif
    
    if (NO == [StringUtils isEmpty:self.m_pszBuSlotID]
        && NO == [StringUtils isEmpty:SYAdSDKManager.gdtAppID]) {
        CGRect rect = {CGPointZero, CGSizeMake(fWidth, fHeight)};
        self = [super initWithFrame:rect placementId:self.m_pszBuSlotID viewController:rootViewController];
    }
    
    self.accessibilityIdentifier = @"banner_ad";
    self.animated = NO;
    self.autoSwitchInterval = 30;
    self.delegate = self;
    
    return self;
}

- (void)loadAdData {
    if ([StringUtils isEmpty:self.m_pszBuSlotID]
        || [StringUtils isEmpty:SYAdSDKManager.gdtAppID]) {
        return;
    }
    
    [super loadAdAndShow];

    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11010];
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

#pragma mark - GDTUnifiedBannerViewDelegate
/**
 *  请求广告条数据成功后调用
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)unifiedBannerViewDidLoad:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"unified banner did load");
    
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewDidLoad:self];
    }
    
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewRenderSuccess:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11011];
}

/**
 *  请求广告条数据失败后调用
 *  当接收服务器返回的广告数据失败后调用该函数
 */

- (void)unifiedBannerViewFailedToLoad:(GDTUnifiedBannerView *)unifiedBannerView error:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewLoadFailed:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11012];
}

/**
 *  banner2.0曝光回调
 */
- (void)unifiedBannerViewWillExpose:(nonnull GDTUnifiedBannerView *)unifiedBannerView {
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewWillBecomVisible:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:1];

}

/**
 *  banner2.0点击回调
 */
- (void)unifiedBannerViewClicked:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate bannerAdViewDidClick:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:2];
}

/**
 *  应用进入后台时调用
 *  当点击应用下载或者广告调用系统程序打开，应用将被自动切换到后台
 */
- (void)unifiedBannerViewWillLeaveApplication:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页已经被关闭
 */
- (void)unifiedBannerViewDidDismissFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页即将被关闭
 */
- (void)unifiedBannerViewWillDismissFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0广告点击以后即将弹出全屏广告页
 */
- (void)unifiedBannerViewWillPresentFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0广告点击以后弹出全屏广告页完毕
 */
- (void)unifiedBannerViewDidPresentFullScreenModal:(GDTUnifiedBannerView *)unifiedBannerView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner2.0被用户关闭时调用
 */
- (void)unifiedBannerViewWillClose:(nonnull GDTUnifiedBannerView *)unifiedBannerView {
    NSLog(@"%s",__FUNCTION__);
}

@end
