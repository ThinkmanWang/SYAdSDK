//
//  ExpressAdManagerCSJ.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/19.
//

#ifndef ExpressAdManagerCSJ_h
#define ExpressAdManagerCSJ_h

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "../IExpressAdManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpressAdManagerCSJ : BUNativeExpressAdManager <IExpressAdManager>

/**
 @param size expected ad view size，when size.height is zero, acture height will match size.width
 */
- (instancetype)initWithSlotID:(NSString *)slotID rootViewController:(UIViewController *)rootViewController adSize:(CGSize)size;

/**
 The number of ads requested,The maximum is 3
 */
- (void)loadAdDataWithCount:(NSInteger)count;

- (void)setSYDelegate:(id<IExpressAdManagerDelegate>)delegate;
- (void)setRequestID:(NSString*)requestID;

@end

NS_ASSUME_NONNULL_END

#endif
