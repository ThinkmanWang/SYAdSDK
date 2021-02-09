//
//  SplashAdViewCSJ.m
//  Masonry
//
//  Created by 王晓丰 on 2021/2/8.
//

#import "SplashAdViewCSJ.h"

#import <UIKit/UIKit.h>
//#import "SYAdSDKManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "../../log/SYLogUtils.h"
#import "../../SYAdSDKManager.h"
#import "SlotUtils.h"

@interface SplashAdViewCSJ () <BUSplashAdDelegate>
@property(nonatomic, strong) NSString *slotID;
@property(nonatomic, strong) NSString* buSlotID;
@property(nonatomic, strong) NSNumber* m_nResourceType;
@property(nonatomic, strong) NSString* pszRequestId;
@end


@implementation SplashAdViewCSJ

- (id) init {
    self = [super init];
    if (self) {
        self.delegate = nil;
        self.buSlotID = @"";
        self.buSlotID = nil;
        self.syDelegate = nil;
        self.m_nResourceType = [NSNumber numberWithInt:2];
        self.pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    NSArray* arySlot = SYAdSDKManager.dictConfig[@"data"][@"slotInfo"];
    if (nil == arySlot) {
        return nil;
    }
    
    return self;
}

- (void)loadAdData {
    
}

@end
