//
//  SplashAdViewCSJ.h
//  Masonry
//
//  Created by 王晓丰 on 2021/2/8.
//

#ifndef SplashAdViewCSJ_h
#define SplashAdViewCSJ_h

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "../ISplashAdView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SYSplashAdDelegate;

@interface SplashAdViewCSJ : BUSplashAdView<ISplashAdView>

/**
 The delegate for receiving state change messages.
 */
@property (nonatomic, weak, nullable) id<ISplashAdViewDelegate> syDelegate;

- (instancetype)initWithSlotID:(NSString *)slotID;
- (void)loadAdData;

@end

NS_ASSUME_NONNULL_END

#endif
