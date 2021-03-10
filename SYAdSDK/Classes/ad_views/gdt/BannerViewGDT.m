//
//  BannerViewGDT.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/23.
//

#import "BannerViewGDT.h"

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "../../log/SYLogUtils.h"
#import "../../SYAdSDKManager.h"
#import "SlotUtils.h"
#import "SYAdSDKDefines.h"

#import "../../gdt/GDTNativeExpressAd.h"
#import "../../gdt/GDTNativeExpressAdView.h"

@interface BannerViewGDT ()

@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszBuSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property (nonatomic, strong) GDTNativeExpressAd *nativeExpressAd;
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
        
        self.nativeExpressAd = nil;
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
    self.m_pszBuSlotID = @"5030722621265924";
#endif
    
    return self;
}

- (void)loadAdData {
    
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


@end
