//
//  SlotUtils.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/8.
//

#import "SlotUtils.h"
#import "../SYAdSDKManager.h"

@implementation SlotUtils

+ (NSNumber*)getResourceType:(NSString *)slotID {
    NSArray* arySlot = SYAdSDKManager.dictConfig[@"data"][@"slotInfo"];
    if (nil == arySlot) {
        return [NSNumber numberWithInt:2];
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot) {
            return nil;
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSDictionary* dictSlotConfig = dictSlot[@"config"][0];
            
            NSNumber* nResourceType = dictSlotConfig[@"resourceType"];
            
            return nResourceType;
        }
    }
    
    return [NSNumber numberWithInt:2];
}

+ (NSString*)getRealSlotID:(NSString *)slotID {
    NSArray* arySlot = SYAdSDKManager.dictConfig[@"data"][@"slotInfo"];
    if (nil == arySlot) {
        return nil;
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot) {
            return nil;
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSDictionary* dictSlotConfig = dictSlot[@"config"][0];
            
            NSNumber* nResourceType = dictSlotConfig[@"resourceType"];
            switch ([nResourceType longValue]) {
                case 1:
                    return dictSlotConfig[@"configParams"][@"gdt_slot_id"];
                    break;
                case 2:
                    return dictSlotConfig[@"configParams"][@"tt_slot_id"];
                    break;
                case 3:
                    return dictSlotConfig[@"configParams"][@"shiyu_slot_id"];
                    break;
                default:
                    return dictSlotConfig[@"configParams"][@"tt_slot_id"];
                    break;
            }
        }
    }
    
    return nil;
}

@end
