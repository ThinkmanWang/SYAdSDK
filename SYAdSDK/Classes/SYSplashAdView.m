
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
    
    
    [self addSubview:self.splashAdView];
    [SYLogUtils report:self.slotID sourceId:0 type:11008];
}

#pragma mark -events

- (void)removeSplashAdView {
    //NSLog(@"removeSplashAdView");
    if (self.splashAdView) {
        [self.splashAdView removeFromSuperview];
        self.splashAdView = nil;
    }
}


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
    
    [self.delegate splashAdDidLoad:self];
    [SYLogUtils report:self.slotID sourceId:0 type:11020];
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClose");
    if (splashAd.zoomOutView) {
//        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView];
    } else{
        [splashAd removeFromSuperview];
    }
    
    [self.delegate splashAdDidClose:self];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClick");
    if (splashAd.zoomOutView) {
        [splashAd.zoomOutView removeFromSuperview];
    }
    // Be careful not to say 'self.splashadview = nil' here.
    // Subsequent agent callbacks will not be triggered after the 'splashAdView' is released early.
    [splashAd removeFromSuperview];
    
    [self.delegate splashAdDidClick:self];
    [SYLogUtils report:self.slotID sourceId:0 type:2];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdDidClickSkip");
    if (splashAd.zoomOutView) {
//        [[BUDAnimationTool sharedInstance] transitionFromView:splashAd toView:splashAd.zoomOutView];
    } else{
        // Click Skip, there is no subsequent operation, completely remove 'splashAdView', avoid memory leak
        [self removeSplashAdView];
    }
    
    [self.delegate splashAdDidClickSkip:self];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    //NSLog(@"splashAd");
    // Display fails, completely remove 'splashAdView', avoid memory leak
    [self removeSplashAdView];
    
    [self.delegate splashAd:self];
    [SYLogUtils report:self.slotID sourceId:0 type:11009];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdWillVisible");
    [self.delegate splashAdWillVisible:self];
    [SYLogUtils report:self.slotID sourceId:0 type:1];
}

- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    //NSLog(@"splashAdWillClose");
    
    [self.delegate splashAdWillClose:self];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashAdDidCloseOtherController");
    [self removeSplashAdView];
    
    [self.delegate splashAdDidCloseOtherController:self];
}



- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    // When the countdown is over, it is equivalent to clicking Skip to completely remove 'splashAdView' and avoid memory leak
    //NSLog(@"splashAdCountdownToZero");
    if (!splashAd.zoomOutView) {
        [self removeSplashAdView];
    }
    
    [self.delegate splashAdCountdownToZero:self];
}

#pragma mark - BUSplashZoomOutViewDelegate
- (void)splashZoomOutViewAdDidClick:(BUSplashZoomOutView *)splashAd {
    //NSLog(@"splashZoomOutViewAdDidClick");
}

- (void)splashZoomOutViewAdDidClose:(BUSplashZoomOutView *)splashAd {
    // Click close, completely remove 'splashAdView', avoid memory leak
    //NSLog(@"splashZoomOutViewAdDidClose");
    [self removeSplashAdView];
}

- (void)splashZoomOutViewAdDidAutoDimiss:(BUSplashZoomOutView *)splashAd {
    // Back down at the end of the countdown to completely remove the 'splashAdView' to avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidAutoDimiss");
    [self removeSplashAdView];
}

- (void)splashZoomOutViewAdDidCloseOtherController:(BUSplashZoomOutView *)splashAd interactionType:(BUInteractionType)interactionType {
    // No further action after closing the other Controllers, completely remove the 'splashAdView' and avoid memory leaks
    //NSLog(@"splashZoomOutViewAdDidCloseOtherController");
    [self removeSplashAdView];
}


@end
