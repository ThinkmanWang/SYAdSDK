//
//  StringUtils.m
//  Masonry
//
//  Created by 王晓丰 on 2021/2/5.
//

#import "StringUtils.h"

@implementation StringUtils

+ (BOOL) isEmpty:(NSString*) pszVal {
    if (nil == pszVal) {
        return YES;
    }
    
    if ([[pszVal stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet] isEqualToString:@""]) {
        return YES;
    }
        
    return YES;
}

@end
