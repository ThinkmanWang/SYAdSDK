//
//  BaseAdViewSY.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/24.
//

#import "BaseAdViewSY.h"

#import "SYAdSDKDefines.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SYDrawingCircleProgressButton.h"
#import "SYCountDownButton.h"
#import "SYSkipButton.h"
#import "SYCircleCountDownButton.h"
#import "SYAdUtils.h"
#import "SlotUtils.h"
#import "SYLogUtils.h"
#import "StringUtils.h"
#import "TGWebViewController.h"


@interface BaseAdViewSY ()


@end

@implementation BaseAdViewSY

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszSYSlotID = @"";
        self.m_dictConfig = nil;
        self.m_dictAdConfig = nil;
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.m_pszSlotID = slotID;
    self.m_pszSYSlotID = [SlotUtils getRealSYSlotID:slotID];
    
    return self;
}

- (void)initDictConfig:(NSDictionary*) dictRet {
    if (nil == dictRet) {
        return;
    }
    
    NSLog(@"%@", dictRet);
    
    if ([StringUtils isEmpty:dictRet[@"code"]]) {
        return;
    }
    
    if (NO == [@"0" isEqualToString:dictRet[@"code"]]) {
        return;
    }
    
    if (nil == dictRet[@"data"]) {
        return;
    }
    
    NSArray* aryAd = dictRet[@"data"][@"ads"];
    if (nil == aryAd || [aryAd count] <= 0) {
        return;
    }
    
    self.m_dictConfig = dictRet;
}

- (void) removeMyself {
    [self removeFromSuperview];
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

- (CGRect)getFrame {
    return self.frame;
}

- (void)setSYRootViewController:(UIViewController*)rootViewController {
    self.rootViewController = rootViewController;
}

- (NSArray*)adList {
    if (nil == self.m_dictConfig) {
        return nil;
    }
    
    return self.m_dictConfig[@"data"][@"ads"];
}

- (void) openAppStore {
    if (nil == self.m_dictAdConfig) {
        return;
    }
    
    NSString* pszUrl = self.m_dictAdConfig[@"ad"][@"download_url"];
    if ([StringUtils isEmpty:pszUrl]) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pszUrl]];
}

- (void) showUrl {
    if (nil == self.m_dictAdConfig) {
        return;
    }
    
    NSString* pszUrl = self.m_dictAdConfig[@"ad"][@"loading_url"];
    if ([StringUtils isEmpty:pszUrl]) {
        return;
    }
    
    if (nil == self.rootViewController) {
        return;
    }
    
    TGWebViewController* web = [[TGWebViewController alloc] init];
    web.url = pszUrl;
//    web.webTitle = @"web";
    web.progressColor = [UIColor blueColor];
    [self.rootViewController.navigationController pushViewController:web animated:YES];
}

- (void) openDeeplink {
    if (nil == self.m_dictAdConfig) {
        return;
    }
    
    NSString* pszUrl = self.m_dictAdConfig[@"ad"][@"deeplink_url"];
    if ([StringUtils isEmpty:pszUrl]) {
        return;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:pszUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pszUrl]];
    } else {
        pszUrl = self.m_dictAdConfig[@"ad"][@"loading_url"];
        if ([StringUtils isEmpty:pszUrl]) {
            return;
        }
        
        TGWebViewController* web = [[TGWebViewController alloc] init];
        web.url = pszUrl;
    //    web.webTitle = @"web";
        web.progressColor = [UIColor blueColor];
        [self.rootViewController.navigationController pushViewController:web animated:YES];
    }
}

@end
