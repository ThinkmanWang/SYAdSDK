//
//  BannerViewCSJ.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/18.
//

#ifndef BannerViewCSJ_h
#define BannerViewCSJ_h

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "../IBannerView.h"

NS_ASSUME_NONNULL_BEGIN

//@protocol SYBannerViewDelegate;

@interface BannerViewCSJ : UIView<IBannerView>

@property (nonatomic, weak, nullable) id<ISYBannerViewDelegate> syDelegate;

@end

NS_ASSUME_NONNULL_END

#endif
