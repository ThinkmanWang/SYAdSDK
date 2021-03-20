//
//  ExpressAdManagerGDT.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/3/20.
//

#import "ExpressAdManagerGDT.h"

#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "../../gdt/GDTNativeExpressAd.h"
#import "../../gdt/GDTNativeExpressAdView.h"


#import "SYLogUtils.h"
#import "SYAdSDKManager.h"
#import "SlotUtils.h"
#import "IExpressAdManager.h"

@interface ExpressAdManagerGDT ()

@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;
@property (nonatomic, weak, nullable) id<IExpressAdManagerDelegate> syDelegate;
@property (nonatomic, weak) UIViewController *rootViewController;

@property (strong, nonatomic) NSMutableArray<__kindof GDTNativeExpressAdView *> *expressAdViews;
@property (strong, nonatomic) NSMutableArray<__kindof UIView *> *syExpressAdViews;

@end

@implementation ExpressAdManagerGDT

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
    
#ifdef TEST_FOR_GDT
    self.m_pszBuSlotID = @"5030722621265924";
#endif
    
    self.rootViewController = rootViewController;
    
    self = [super initWithPlacementId:self.m_pszBuSlotID adSize:size];
    self.delegate = self;
    
//    [self.nativeExpressAd loadAd:(NSInteger)self.adCountSliderValue];

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
    
    [self loadAd:count];

    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11010 adCount:count];
}

- (void)setSYDelegate:(id<IExpressAdManagerDelegate>)delegate {
    self.syDelegate = delegate;
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

#pragma mark - GDTNativeExpressAdDelegete
/**
 * 拉取广告成功的回调
 */
- (void)nativeExpressAdSuccessToLoad:(GDTNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof GDTNativeExpressAdView *> *)views
{
    NSLog(@"%s",__FUNCTION__);
    
    [self.expressAdViews removeAllObjects];
    [self.syExpressAdViews removeAllObjects];
    
    if (views.count) {
        [self.expressAdViews addObjectsFromArray:views];
        
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GDTNativeExpressAdView *expressView = (GDTNativeExpressAdView *)obj;
            expressView.controller = self.rootViewController;
            
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
    
    
//    self.expressAdViews = [NSMutableArray arrayWithArray:views];
//    if (self.expressAdViews.count) {
//        [self.expressAdViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            GDTNativeExpressAdView *expressView = (GDTNativeExpressAdView *)obj;
//            expressView.controller = self;
//            [expressView render];
//            NSLog(@"eCPM:%ld eCPMLevel:%@", [expressView eCPM], [expressView eCPMLevel]);
//        }];
//    }
//    [self.tableView reloadData];
}

/**
 * 拉取广告失败的回调
 */
- (void)nativeExpressAdRenderFail:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
    if (self.syDelegate) {
        [self.syDelegate expressAdViewRenderFail:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11012];
}

/**
 * 拉取原生模板广告失败
 */
- (void)nativeExpressAdFailToLoad:(GDTNativeExpressAd *)nativeExpressAd error:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"Express Ad Load Fail : %@",error);
    
    if (self.syDelegate) {
        [self.syDelegate expressAdFailToLoad:self];
    }
}

- (void)nativeExpressAdViewRenderSuccess:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
    if (self.syDelegate) {
        UIView* view = nativeExpressAdView.superview;
        view.frame = nativeExpressAdView.frame;
        
        [self.syDelegate expressAdViewRenderSuccess:view];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:11011];
}

- (void)nativeExpressAdViewClicked:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate expressAdViewDidClick:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:2];
}

- (void)nativeExpressAdViewClosed:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
    [self.expressAdViews removeObject:nativeExpressAdView];
}

- (void)nativeExpressAdViewExposure:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
    
    if (self.syDelegate) {
        [self.syDelegate expressAdViewWillShow:nativeExpressAdView.superview];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:3 type:1];
}

- (void)nativeExpressAdViewWillPresentScreen:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
    if (self.syDelegate) {
        [self.syDelegate expressAdViewWillPresentScreen:nativeExpressAdView.superview];
    }
}

- (void)nativeExpressAdViewDidPresentScreen:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewWillDismissScreen:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewDidDismissScreen:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 * 详解:当点击应用下载或者广告调用系统程序打开时调用
 */
- (void)nativeExpressAdViewApplicationWillEnterBackground:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"--------%s-------",__FUNCTION__);
}

@end
