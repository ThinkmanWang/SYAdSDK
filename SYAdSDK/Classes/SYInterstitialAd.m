//
//  SYInterstitialAd.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/1/26.
//

#import "SYInterstitialAd.h"
#import "SYAdSDKManager.h"

#import <BUAdSDK/BUAdSDK.h>

#import "log/SYLogUtils.h"

@interface SYInterstitialAd () <BUNativeExpresInterstitialAdDelegate>
@property(nonatomic, strong) NSString* slotID;
@property(nonatomic, strong) NSString* buSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;

@end

@implementation SYInterstitialAd

- (id) init {
    self = [super init];
    if (self) {
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

- (instancetype)initWithSlotID:(NSString *)slotID adSize:(SYInterstitialAdSize)adsize {
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
    
    self.slotID = slotID;
    self.buSlotID = [self getRealSlotID:slotID];
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:self.buSlotID adSize:CGSizeMake(fWidth, fHeight)];
    self.interstitialAd.delegate = self;
    
    return self;
}

/**
 Load interstitial ad datas.
 */
- (void)loadAdData {
    [SYLogUtils report:self.slotID sourceId:0 type:11008];
    return [self.interstitialAd loadAdData];
}

/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    
    [SYLogUtils report:self.slotID sourceId:0 type:1];
    self.rootViewController = rootViewController;
    
    if (self.interstitialAd) {
        return [self.interstitialAd showAdFromRootViewController:self.rootViewController];
    }
    
    return NO;
}

#pragma mark -BUNativeExpresInterstitialAdDelegate
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidLoad");
    if (self.delegate) {
        [self.delegate interstitialAdDidLoad:self];
    }
    
    [SYLogUtils report:self.slotID sourceId:0 type:11020];
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    //NSLog(@"nativeExpresInterstitialAd");
    if (self.delegate) {
        [self.delegate interstitialAd:self];
    }
    
    [SYLogUtils report:self.slotID sourceId:0 type:11009];
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    //NSLog(@"nativeExpresInterstitialAdRenderSuccess");
    
    if (self.delegate) {
        [self.delegate interstitialAdRenderSuccess:self];
    }
    
    [SYLogUtils report:self.slotID sourceId:0 type:1];
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    //NSLog(@"nativeExpresInterstitialAdRenderFail");
    
    if (self.delegate) {
        [self.delegate interstitialAdRenderFail:self];
    }
    
    [SYLogUtils report:self.slotID sourceId:0 type:11009];
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdWillVisible");
    
    if (self.delegate) {
        [self.delegate interstitialAdWillVisible:self];
    }
    
    [SYLogUtils report:self.slotID sourceId:0 type:1];
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidClick");
    
    if (self.delegate) {
        [self.delegate interstitialAdDidClick:self];
    }
    
    [SYLogUtils report:self.slotID sourceId:0 type:2];
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdWillClose");
    
    if (self.delegate) {
        [self.delegate interstitialAdWillClose:self];
    }
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    //NSLog(@"nativeExpresInterstitialAdDidClose");
    self.interstitialAd = nil;
    
    if (self.delegate) {
        [self.delegate interstitialAdDidClose:self];
    }
}

- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
    //NSLog(@"nativeExpresInterstitialAdDidCloseOtherController");
    
}

@end
