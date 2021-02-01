
#import "SYSplashAdView.h"

#import <UIKit/UIKit.h>
#import "SYAdSDKManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "log/SYLogUtils.h"


@interface SYSplashAdView () <BUSplashAdDelegate>
@property(nonatomic, strong) BUSplashAdView* splashAdView;
@property(nonatomic, strong) NSString* buSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* pszRequestId;
@end

@implementation SYSplashAdView

- (id) init {
    self = [super init];
    if (self) {
        self.tolerateTimeout = 3;
        self.hideSkipButton = NO;
        self.needSplashZoomOutAd = NO;
        self.delegate = nil;
        self.buSlotID = @"887421551";
        self.buSlotID = nil;
        self.m_nResourceType = [NSNumber numberWithInt:2];
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

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.slotID = slotID;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.buSlotID = [self getRealSlotID:slotID];
    self.splashAdView = [[BUSplashAdView alloc] initWithSlotID:self.buSlotID frame:frame];
    
    return self;
}

- (void)loadAdData {
    self.splashAdView.tolerateTimeout = self.tolerateTimeout;
    self.splashAdView.delegate = self;
    
    //optional
    [self.splashAdView loadAdData];
    self.splashAdView.rootViewController = self.rootViewController;
    
    self.frame = self.splashAdView.frame;
    [self addSubview:self.splashAdView];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11008];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11010];
}

- (void) removeMyself {
    if (self.splashAdView) {
        if (self.splashAdView.zoomOutView) {
            [self.splashAdView.zoomOutView removeFromSuperview];
        }
        
        [self.splashAdView removeFromSuperview];
    }
    [self removeFromSuperview];
}

#pragma mark -events

//- (void)removeSplashAdView {
//    //NSLog(@"removeSplashAdView");
//    if (self.splashAdView) {
//        [self.splashAdView removeFromSuperview];
//        self.splashAdView = nil;
//    }
//}


- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidLoad");
    if (splashAd.zoomOutView) {
        UIViewController *parentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [parentVC.view addSubview:splashAd.zoomOutView];
        [parentVC.view bringSubviewToFront:splashAd];
        //Add this view to your container
        [parentVC.view insertSubview:splashAd.zoomOutView belowSubview:splashAd];
        splashAd.zoomOutView.rootViewController = parentVC;
        splashAd.zoomOutView.delegate = self;
    }
    
    if (self.delegate) {
        [self.delegate splashAdDidLoad:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11011];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11020];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClose");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClose:self];
    }
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClick");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClick:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:2];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClickSkip");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidClickSkip:self];
    }
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    //NSLog(@"splashAd");
    // Display fails, completely remove 'splashAdView', avoid memory leak
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAd:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11012];
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:11009];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdWillVisible");
    if (self.delegate) {
        [self.delegate splashAdWillVisible:self];
    }
    
    [SYLogUtils report:self.slotID requestID:self.pszRequestId sourceId:0 type:1];
}

- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdWillClose:self];
    }
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashAdDidCloseOtherController");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdDidCloseOtherController:self];
    }
}



- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    // When the countdown is over, it is equivalent to clicking Skip to completely remove 'splashAdView' and avoid memory leak
    //NSLog(@"splashAdCountdownToZero");
    [self removeMyself];
    
    if (self.delegate) {
        [self.delegate splashAdCountdownToZero:self];
    }
}

#pragma mark - BUSplashZoomOutViewDelegate
- (void)splashZoomOutViewAdDidClick:(BUSplashZoomOutView *)splashAd {
    //NSLog(@"splashZoomOutViewAdDidClick");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidClose:(BUSplashZoomOutView *)splashAd {
    // Click close, completely remove 'splashAdView', avoid memory leak
    //NSLog(@"splashZoomOutViewAdDidClose");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidAutoDimiss:(BUSplashZoomOutView *)splashAd {
    // Back down at the end of the countdown to completely remove the 'splashAdView' to avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidAutoDimiss");
    [self removeMyself];
}

- (void)splashZoomOutViewAdDidCloseOtherController:(BUSplashZoomOutView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidCloseOtherController");
    [self removeMyself];
}


@end
