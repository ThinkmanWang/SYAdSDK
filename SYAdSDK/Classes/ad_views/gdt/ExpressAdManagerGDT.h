//
//  ExpressAdManagerGDT.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/3/20.
//

#ifndef ExpressAdManagerGDT_h
#define ExpressAdManagerGDT_h


#import <Foundation/Foundation.h>

#import "../IExpressAdManager.h"
#import "../../gdt/GDTNativeExpressAd.h"
#import "SYAdSDKDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpressAdManagerGDT : GDTNativeExpressAd <IExpressAdManager>

@end

NS_ASSUME_NONNULL_END

#endif
