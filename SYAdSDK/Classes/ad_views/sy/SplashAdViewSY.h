//
//  SplashAdView.h
//  Masonry
//
//  Created by 王晓丰 on 2021/11/22.
//

#ifndef SplashAdViewSY_h
#define SplashAdViewSY_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "ISplashAdView.h"
#import "BaseAdViewSY.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SYSplashAdDelegate;

@interface SplashAdViewSY : BaseAdViewSY<ISplashAdView>

/**
 The delegate for receiving state change messages.
 */
@property (nonatomic, weak, nullable) id<ISplashAdViewDelegate> syDelegate;

- (instancetype)initWithSlotID:(NSString *)slotID;
- (void)initDictConfig:(NSDictionary*) dictRet;

@end

NS_ASSUME_NONNULL_END

#endif
