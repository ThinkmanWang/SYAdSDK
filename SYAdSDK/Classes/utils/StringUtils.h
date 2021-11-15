//
//  StringUtils.h
//  Masonry
//
//  Created by 王晓丰 on 2021/2/5.
//

#ifndef StringUtils_h
#define StringUtils_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StringUtils : NSObject

+ (BOOL)isEmpty:(NSString*) pszVal;
+ (NSDictionary*) strToDict: (NSString*) pszJson;
+ (NSString*) dictToStr: (NSDictionary*) dictData;

@end

NS_ASSUME_NONNULL_END

#endif
