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
#import "DeviceUtils.h"
#import "SYAdSDKManager.h"
#import "UserInfoUtils.h"


@interface BaseAdViewSY ()

@property (nonatomic, assign) BOOL m_bTryDadi;

@end

@implementation BaseAdViewSY

- (id) init {
    self = [super init];
    if (self) {
        self.m_pszSlotID = @"";
        self.m_pszSYSlotID = @"";
        self.m_dictConfig = nil;
        self.m_dictAdConfig = nil;
        self.m_imgLogo = nil;
        self.m_bTryDadi = NO;
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID tryDadi:(BOOL) tryDadi {
    self.m_bTryDadi = tryDadi;
    self.m_pszSlotID = slotID;
    
    if (self.m_bTryDadi) {
        self.m_pszSYSlotID = [SlotUtils getRealSYDadiSlotID:slotID];
    } else {
        self.m_pszSYSlotID = [SlotUtils getRealSYSlotID:slotID];
    }
    
    return self;
}

- (void)initDictConfig:(NSDictionary*) dictRet {
    if (nil == dictRet) {
        return;
    }
    
//    NSLog(@"%@", dictRet);
    
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

//- (UIImageView*) _m_imgLogo {
//    if (nil == _m_imgLogo) {
//        _m_imgLogo = [[UIImageView alloc] init];
//        _m_imgLogo.layer.zPosition = 1;
//    }
//
//    return _m_imgLogo;
//}

- (void) setupLogo:(NSString*)pszUrl {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pszUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            return;
        }
        
        if (nil == data || nil == response) {
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (200 != httpResponse.statusCode) {
            return;
        }
        
        UIImage* pImg = [UIImage imageWithData:data];
        if (nil == pImg) {
            return;
        }
        
        float fWidth = pImg.size.width;
        float fHeight = pImg.size.height;
        float fX = self.frame.size.width - fWidth - 8;
        float fY = self.frame.size.height - fHeight - 8;

        CGRect imgRect = CGRectMake(fX, fY, fWidth, fHeight);

        self.m_imgLogo = [[UIImageView alloc] initWithFrame:imgRect];
        self.m_imgLogo.layer.zPosition = 1;
        [self.m_imgLogo setFrame:imgRect];
        self.m_imgLogo.image = pImg;
        
        [self addSubview:self.m_imgLogo];
    }];
}

- (NSString*) replaceMacro:(NSString*)pszUrl {
    if ([StringUtils isEmpty:pszUrl]) {
        return pszUrl;
    }
    
    
    NSString* pszRet = pszUrl;
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__OS__" withString:[DeviceUtils getOSVersion]];
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__IP__" withString:@""];
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__UA__" withString:[DeviceUtils userAgent]];
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__IMEI__" withString:@""];
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__IDFA__" withString:SYAdSDKManager.idfa];

    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__ANDROIDID__" withString:@""];
//    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__OPENUDID__" withString:]
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__MAC__" withString:[UserInfoUtils getMAC]];

    NSNumber* nTimestamp = [NSNumber numberWithUnsignedLong:[[NSDate date] timeIntervalSince1970]*1000];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[nTimestamp longValue]/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__TS__" withString:[formatter stringFromDate:date]];
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__STS__" withString:[NSString stringWithFormat:@"%ld", nTimestamp.longValue]];
    
    pszRet = [pszRet stringByReplacingOccurrencesOfString:@"__UUID__" withString:SYAdSDKManager.idfa];

    return pszRet;
}

- (NSArray*) mkReportUrls:(NSString*)pszUrlType {
    if (nil == self.m_dictAdConfig || [StringUtils isEmpty:pszUrlType]) {
        return nil;
    }
    
    NSArray* aryUrl = self.m_dictAdConfig[@"tracking_list"][pszUrlType];
    if (nil == aryUrl) {
        return nil;
    }
    
    NSMutableArray* aryRet = [NSMutableArray arrayWithCapacity:[aryUrl count]];
    for (int i = 0; i < [aryUrl count]; ++i) {
        NSString* pszUrl =aryUrl[i];
        pszUrl = [self replaceMacro:pszUrl];
        [aryRet addObject:pszUrl];
    }
    
    return aryRet;
}

- (void) doReport:(NSArray*)aryUrl {
    if (nil == aryUrl || [aryUrl count] <= 0) {
        return;
    }
    
    for (int i = 0; i < [aryUrl count]; ++i) {
        if ([StringUtils isEmpty:aryUrl[i]]) {
            continue;
        }
        
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:aryUrl[i]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error != nil) {
                NSLog(@"%@", error);
                return;
            }
            
            if (nil == data || nil == response) {
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (200 != httpResponse.statusCode) {
                return;
            }
            
            NSString* strRet  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", strRet);
        }];
    }
    
}

- (void) reportShow { //曝光上报地址
    [self doReport:[self mkReportUrls:@"show_url"]];
}

- (void) reportClick {  //点击上报地址
    [self doReport:[self mkReportUrls:@"click_url"]];
}

- (void) reportPptrackers { //deeplink 点击 上报地址
    if (nil == self.m_dictAdConfig) {
        return;
    }
}

- (void) reportDs {  //应用类下载上 报地址
    [self doReport:[self mkReportUrls:@"ds_url"]];
}

- (void) reportDf { //应用类下载完 成上报地址
    if (nil == self.m_dictAdConfig) {
        return;
    }
}

//- (void) reportSs; //应用类开始安 装上报地址
- (void) reportSf { //应用类完成安 上报地址
    if (nil == self.m_dictAdConfig) {
        return;
    }
}
//- (void) reportAct; //激活引用上报 地址
//- (void) reportPs; //视频类开始播 放上报地址
//- (void) reportPi; //视频类播放播放终止退出上报地址
//- (void) reportPc; //视频类播放完 成上报地址

@end
