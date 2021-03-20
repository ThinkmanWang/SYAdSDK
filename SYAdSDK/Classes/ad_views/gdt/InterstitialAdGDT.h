//
//  InterstitialAdGDT.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/3/20.
//

#ifndef InterstitialAdGDT_h
#define InterstitialAdGDT_h

#import <Foundation/Foundation.h>
#import "../IInterstitialAd.h"
#import "../../gdt/GDTUnifiedInterstitialAd.h"
#import "SYAdSDKDefines.h"


NS_ASSUME_NONNULL_BEGIN

@interface InterstitialAdGDT : GDTUnifiedInterstitialAd <IInterstitialAd>

@end

NS_ASSUME_NONNULL_END

#endif
