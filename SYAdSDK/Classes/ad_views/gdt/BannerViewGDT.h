//
//  BannerViewGDT.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/23.
//

#ifndef BannerViewGDT_h
#define BannerViewGDT_h

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "../IBannerView.h"
#import <GDTMobSDK/GDTUnifiedBannerView.h>
#import "SYAdSDKDefines.h"


NS_ASSUME_NONNULL_BEGIN

@interface BannerViewGDT : GDTUnifiedBannerView<IBannerView>

@end

NS_ASSUME_NONNULL_END

#endif
