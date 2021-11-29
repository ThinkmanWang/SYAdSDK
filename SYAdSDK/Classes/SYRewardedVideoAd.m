//
//  SYRewardedVideoAd.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/29.
//

#import "SYRewardedVideoAd.h"
#import "IRewardedVideoAd.h"

#import "log/SYLogUtils.h"
#import "utils/SlotUtils.h"
#import "IRewardedVideoAd.h"

@interface SYRewardedVideoAd () <IRewardedVideoAdDelegate>
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property (nonatomic, weak) UIViewController *rootViewController;

@property (nonatomic, strong) id<IRewardedVideoAd> rewardedVideoAd;
@end

@implementation SYRewardedVideoAd

- (id) init {
    self = [super init];
    if (self) {
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.delegate = nil;
        self.m_pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(SYRewardedVideoModel *)model {
    return self;
}

- (void)loadAdData {
    
}

- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    return YES;
}

@end
