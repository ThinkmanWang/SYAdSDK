//
//  BaseAdViewSY.h
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAdViewSY : UIView

@property (nonatomic, weak) UIViewController *rootViewController;

@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszSYSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property(nonatomic, strong) NSDictionary* m_dictConfig;

- (instancetype)initWithSlotID:(NSString *)slotID;

@end

NS_ASSUME_NONNULL_END
