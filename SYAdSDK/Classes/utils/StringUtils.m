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
    
    if (NO == [pszVal isKindOfClass: [NSString class]]) {
        return YES;
    }
    
    if ([[pszVal stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet] isEqualToString:@""]) {
        return YES;
    }
        
    return NO;
}

+(NSDictionary*) strToDict: (NSString*) pszJson {
    NSData *data = [pszJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return tempDic;
}

+ (NSString*) dictToStr: (NSDictionary*) dictData {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictData options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
        return nil;
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    //    NSRange range = {0,jsonString.length};
    //    //去掉字符串中的空格
    //    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

@end
