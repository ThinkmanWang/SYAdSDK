//
//  SlotUtils.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/8.
//

#ifndef SlotUtils_h
#define SlotUtils_h

#import <Foundation/Foundation.h>


@interface SlotUtils : NSObject

+ (NSString*)getRealSlotID:(NSString *)slotID;
+ (NSString*) getRealSYDadiSlotID:(NSString*)slotID;
+ (NSString*) getRealSYSlotID:(NSString*)slotID;
+ (NSNumber*)getResourceType:(NSString *)slotID;
+ (int) getSplashType:(NSString*) slotID;
+ (BOOL) dadiOpen:(NSString*) slotID;

@end

#endif
