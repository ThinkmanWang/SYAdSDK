//
//  SYBannerView.m
//  SYAdSSDK
//
//  Created by 王晓丰 on 2021/1/25.
//

#import "SYBannerView.h"
#import "SYAdSDKDefines.h"

#import <BUAdSDK/BUAdSDK.h>

@interface SYBannerView () <BUNativeExpressBannerViewDelegate>
@property(nonatomic, strong) NSString* slotID;
@property(nonatomic, strong) NSString* buSlotID;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView;
@end

@implementation SYBannerView

- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(SYBannerSize)adsize {
    
    NSDictionary* sizeDcit = @{
        @"945742204"         :  [NSValue valueWithCGSize:CGSizeMake(600, 300)]
        , @"945741009"         :  [NSValue valueWithCGSize:CGSizeMake(600, 260)]
    };
    
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    if (![window isKindOfClass:[UIView class]]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    CGFloat bottom = 0.0;
    if (@available(iOS 11.0, *)) {
        bottom = window.safeAreaInsets.bottom;
    } else {
        // Fallback on earlier versions
    }
    
    NSValue *sizeValue = nil;
    switch (adsize) {
        case SYBannerSize600_300:
            sizeValue = [sizeDcit objectForKey:@"945742204"];
            break;
        case SYBannerSize600_400:
            sizeValue = [sizeDcit objectForKey:@"945742204"];
            break;
        case SYBannerSize600_500:
            sizeValue = [sizeDcit objectForKey:@"945742204"];
            break;
        case SYBannerSize600_260:
            sizeValue = [sizeDcit objectForKey:@"945741009"];
            break;
        case SYBannerSize600_90 :
            sizeValue = [sizeDcit objectForKey:@"945741009"];
            break;
        case SYBannerSize600_150:
            sizeValue = [sizeDcit objectForKey:@"945741009"];
            break;
        case SYBannerSize640_100:
            sizeValue = [sizeDcit objectForKey:@"945741009"];
            break;
        case SYBannerSize690_388:
            sizeValue = [sizeDcit objectForKey:@"945742204"];
            break;
        default:
            sizeValue = [sizeDcit objectForKey:@"945741009"];
            break;
    }
    
    CGSize size = [sizeValue CGSizeValue];
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:@"945742204" rootViewController:rootViewController adSize:size];
    self.bannerView.delegate = self;
    
    return self;
}

- (void)loadAdData {
    [self.bannerView loadAdData];
    [self addSubview:self.bannerView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - events

- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {

}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        self.bannerView = nil;
    }];

}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
}


@end
