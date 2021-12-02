//
//  RandUtils.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/12/2.
//

#import "RandUtils.h"

@implementation RandUtils

+ (int) randomInt:(int)nMin nMax:(int)nMax {
    return (arc4random() % nMax) + nMin;
}

@end
