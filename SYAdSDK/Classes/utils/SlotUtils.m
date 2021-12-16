//
//  SlotUtils.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/2/8.
//

#import "SlotUtils.h"
#import "SYAdSDKManager.h"

#import "StringUtils.h"

@implementation SlotUtils

+ (BOOL) dadiOpen:(NSString*) slotID {
    if (nil == SYAdSDKManager.dictConfig) {
        return NO;
    }
    
    if (nil == [SYAdSDKManager.dictConfig valueForKey:@"data"]
        || NO == [[SYAdSDKManager.dictConfig valueForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    if (nil == [SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"]
        || NO == [[SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"] isKindOfClass:[NSArray class]]) {
        return NO;
    }
    
    NSArray* arySlot = SYAdSDKManager.dictConfig[@"data"][@"slotInfo"];
    if (nil == arySlot) {
        return NO;
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot
            || nil == dictSlot[@"slotId"]
            || nil == dictSlot[@"config"]) {
            return [NSNumber numberWithInt:1];
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSArray* aryConfig = dictSlot[@"config"];
            if (nil == aryConfig
                || NO == [aryConfig isKindOfClass: [NSArray class]]
                || [aryConfig count] <= 0) {
                continue;
            }
            
            NSDictionary* dictSlotConfig = aryConfig[0];
            if (nil == dictSlotConfig
                || nil == dictSlotConfig[@"configParams"]) {
                return NO;
            }
            
            if ([StringUtils isEmpty:dictSlotConfig[@"configParams"][@"dadi_open"]]) {
                return NO;
            }
            
            return [dictSlotConfig[@"configParams"][@"dadi_open"] isEqualToString:@"1"];            
        }
    }
        
    return NO;
}

+ (NSNumber*)getResourceType:(NSString *)slotID {
    if (nil == SYAdSDKManager.dictConfig) {
        return [NSNumber numberWithInt:1];
    }
    
    if (nil == [SYAdSDKManager.dictConfig valueForKey:@"data"]
        || NO == [[SYAdSDKManager.dictConfig valueForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
        return [NSNumber numberWithInt:1];
    }
    
    if (nil == [SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"]
        || NO == [[SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"] isKindOfClass:[NSArray class]]) {
        return [NSNumber numberWithInt:1];
    }
    
    NSArray* arySlot = SYAdSDKManager.dictConfig[@"data"][@"slotInfo"];
    if (nil == arySlot) {
        return [NSNumber numberWithInt:1];
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot
            || nil == dictSlot[@"slotId"]
            || nil == dictSlot[@"config"]) {
            return [NSNumber numberWithInt:1];
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSArray* aryConfig = dictSlot[@"config"];
            if (nil == aryConfig
                || NO == [aryConfig isKindOfClass: [NSArray class]]
                || [aryConfig count] <= 0) {
                continue;
            }
            
            NSDictionary* dictSlotConfig = aryConfig[0];
            if (nil == dictSlotConfig
                || nil == dictSlotConfig[@"resourceType"]
                || NO == [[dictSlotConfig valueForKey:@"resourceType"] isKindOfClass: [NSNumber class]] ) {
                return [NSNumber numberWithInt:1];
            }
            
            NSNumber* nResourceType = dictSlotConfig[@"resourceType"];
            
            return nResourceType;
        }
    }
    
    return [NSNumber numberWithInt:1];
}

+ (int) getSplashType:(NSString*) slotID
{
    if (nil == SYAdSDKManager.dictConfig) {
        return 5;
    }
    
    NSArray* arySlot = [SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"];
    if (nil == arySlot
        || NO == [arySlot isKindOfClass: [NSArray class]]) {
        return 5;
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot
            || NO == [dictSlot isKindOfClass: [NSDictionary class]]) {
            return 5;
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSArray* aryConfig = dictSlot[@"config"];
            if (nil == aryConfig
                || NO == [aryConfig isKindOfClass: [NSArray class]]
                || [aryConfig count] <= 0) {
                continue;
            }
            
            NSDictionary* dictSlotConfig = aryConfig[0];
            
            NSString* pszSlotType = dictSlotConfig[@"configParams"][@"splash_type"];
            
            if ([StringUtils isEmpty:pszSlotType]) {
                return 5;
            }
            
            @try {
                return [pszSlotType intValue];
            } @catch (NSException *exception) {
                return 5;
            } @finally {
                
            }
            
        }
    }
    
    return 5;
}

+ (NSString*) getRealSYDadiSlotID:(NSString*)slotID {
    if (nil == SYAdSDKManager.dictConfig) {
        return nil;
    }
    
    NSArray* arySlot = [SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"];
    if (nil == arySlot
        || NO == [arySlot isKindOfClass: [NSArray class]]) {
        return nil;
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot
            || NO == [dictSlot isKindOfClass: [NSDictionary class]]) {
            return nil;
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSArray* aryConfig = dictSlot[@"config"];
            if (nil == aryConfig
                || NO == [aryConfig isKindOfClass: [NSArray class]]
                || [aryConfig count] <= 0) {
                continue;
            }
            
            NSDictionary* dictSlotConfig = aryConfig[0];
            
            return dictSlotConfig[@"configParams"][@"dadi_slot_id"];
        }
    }
    
    return nil;
}

+ (NSString*) getRealSYSlotID:(NSString*)slotID {
    if (nil == SYAdSDKManager.dictConfig) {
        return nil;
    }
    
    NSArray* arySlot = [SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"];
    if (nil == arySlot
        || NO == [arySlot isKindOfClass: [NSArray class]]) {
        return nil;
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot
            || NO == [dictSlot isKindOfClass: [NSDictionary class]]) {
            return nil;
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSArray* aryConfig = dictSlot[@"config"];
            if (nil == aryConfig
                || NO == [aryConfig isKindOfClass: [NSArray class]]
                || [aryConfig count] <= 0) {
                continue;
            }
            
            NSDictionary* dictSlotConfig = aryConfig[0];
            
            return dictSlotConfig[@"configParams"][@"shiyu_slot_id"];
        }
    }
    
    return nil;
}

+ (NSString*) getRealCSJSlotID:(NSString*)slotID {
    if (nil == SYAdSDKManager.dictConfig) {
        return nil;
    }
    
    NSArray* arySlot = [SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"];
    if (nil == arySlot
        || NO == [arySlot isKindOfClass: [NSArray class]]) {
        return nil;
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot
            || NO == [dictSlot isKindOfClass: [NSDictionary class]]) {
            return nil;
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSArray* aryConfig = dictSlot[@"config"];
            if (nil == aryConfig
                || NO == [aryConfig isKindOfClass: [NSArray class]]
                || [aryConfig count] <= 0) {
                continue;
            }
            
            NSDictionary* dictSlotConfig = aryConfig[0];
            
            return dictSlotConfig[@"configParams"][@"tt_slot_id"];
        }
    }
    
    return nil;
}

+ (NSString*)getRealSlotID:(NSString *)slotID {
//    NSArray* arySlot = SYAdSDKManager.dictConfig[@"data"][@"slotInfo"];
    if (nil == SYAdSDKManager.dictConfig) {
        return nil;
    }
    
    NSArray* arySlot = [SYAdSDKManager.dictConfig valueForKeyPath:@"data.slotInfo"];
    if (nil == arySlot
        || NO == [arySlot isKindOfClass: [NSArray class]]) {
        return nil;
    }
    
    for (int i = 0; i < [arySlot count]; ++i) {
        NSDictionary* dictSlot = arySlot[i];
        if (nil == dictSlot
            || NO == [dictSlot isKindOfClass: [NSDictionary class]]) {
            return nil;
        }
        
        if ([slotID isEqualToString:[NSString stringWithFormat:@"%@", dictSlot[@"slotId"]]]) {
            NSArray* aryConfig = dictSlot[@"config"];
            if (nil == aryConfig
                || NO == [aryConfig isKindOfClass: [NSArray class]]
                || [aryConfig count] <= 0) {
                continue;
            }
            
            NSDictionary* dictSlotConfig = aryConfig[0];
            
            NSNumber* nResourceType = dictSlotConfig[@"resourceType"];
            if (nil == nResourceType
                || NO == [nResourceType isKindOfClass: [NSNumber class]]) {
                continue;
            }
            
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
