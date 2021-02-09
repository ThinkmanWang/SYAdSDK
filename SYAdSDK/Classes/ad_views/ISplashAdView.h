//
//  ISplashAdView.h
//  Pods
//
//  Created by 王晓丰 on 2021/2/8.
//

#ifndef ISplashAdView_h
#define ISplashAdView_h

@protocol ISplashAdView <NSObject>

- (instancetype)initWithSlotID:(NSString *)slotID;
- (void)loadAdData;

@end


#endif /* ISplashAdView_h */
