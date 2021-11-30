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
@property(nonatomic, strong) NSDictionary* m_dictAdConfig;

@property (nonatomic, strong) UIImageView* m_imgLogo;

- (instancetype)initWithSlotID:(NSString *)slotID;
- (NSArray*)adList;

- (void)initDictConfig:(NSDictionary*) dictRet;
- (void) openDeeplink;
- (void) showUrl;
- (void) openAppStore;
- (void) setupLogo:(NSString*)pszUrl;

- (void) reportShow;  //曝光上报地址
- (void) reportClick;  //点击上报地址
- (void) reportPptrackers; //deeplink 点击 上报地址
- (void) reportDs;  //应用类下载上 报地址
- (void) reportDf; //应用类下载完 成上报地址
//- (void) reportSs; //应用类开始安 装上报地址
- (void) reportSf; //应用类完成安 上报地址
//- (void) reportAct; //激活引用上报 地址
//- (void) reportPs; //视频类开始播 放上报地址
//- (void) reportPi; //视频类播放播放终止退出上报地址
//- (void) reportPc; //视频类播放完 成上报地址

@end

NS_ASSUME_NONNULL_END
