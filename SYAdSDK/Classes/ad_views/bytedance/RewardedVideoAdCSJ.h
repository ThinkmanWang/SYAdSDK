//
//  RewardedVideoAdCSJ.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/29.
//

#ifndef RewardedVideoAdCSJ_h
#define RewardedVideoAdCSJ_h

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>
#import "IRewardedVideoAd.h"

NS_ASSUME_NONNULL_BEGIN

@interface RewardedVideoAdCSJ : NSObject<IRewardedVideoAd>
@property (nonatomic, weak, nullable) id<IRewardedVideoAdDelegate> syDelegate;
@end

NS_ASSUME_NONNULL_END

#endif
