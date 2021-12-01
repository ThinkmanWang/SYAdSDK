//
//  SplashAdView.m
//  Masonry
//
//  Created by 王晓丰 on 2021/11/22.
//

#import "SplashAdViewSY.h"
#import "SYAdSDKDefines.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SYDrawingCircleProgressButton.h"
#import "SYCountDownButton.h"
#import "SYSkipButton.h"
#import "SYCircleCountDownButton.h"
#import "SYAdUtils.h"
#import "SlotUtils.h"
#import "SYLogUtils.h"
#import "StringUtils.h"
#import "TGWebViewController.h"


@interface SplashAdViewSY ()

@property (nonatomic, strong) UIImageView* m_imgMain;
@property (nonatomic, strong) SYDrawingCircleProgressButton* m_btnSkip;
@property (nonatomic, strong) UIImageView* m_imgShake;

@end

@implementation SplashAdViewSY

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init {
    self = [super init];
    if (self) {
        self.syDelegate = nil;
        self.rootViewController = nil;
        self.m_imgMain = nil;
        self.m_imgShake = nil;
//        self.m_pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self = [super initWithSlotID:slotID];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.frame = frame;
        
    return self;
}

- (void) onFailed {
    if (self.syDelegate) {
        [self.syDelegate splashAd:self];
    }
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:1 type:11012];
}

- (void)loadAdData {
    //optional

    [SYAdUtils getSYAd:self.m_pszSYSlotID
            nAdCount:1
           onSuccess:^(NSDictionary* dictRet) {
        
#ifdef TEST_DOWNLOAD_APP
        dictRet = @{
            @"msg": @"NO_ERROR",
            @"code": @"0",
            @"adslot_id": @24011,
            @"data": @{
                @"ads": @[
                    @{
                        @"ad": @{
                            @"app_size": @"1000",
                            @"logo_url": @"http://palmar.huina365.cn/sy_logo_1.0.1.png",
                            @"app_package": @"com.yaya.zone",
                            @"line": @1,
                            @"interaction_type": @3,
                            @"description": @"叮咚买菜",
                            @"img_id": @"20fa4a8a749b681b4bc68a5265db4725",
                            @"source": @"SY-300",
                            @"title": @"叮咚买菜1",
                            @"invocationstyle": @"1",
                            @"app_name": @"叮咚买菜",
                            @"acceleration": @10,
                            @"ad_id": @"2652",
                            @"img_url": @"http://palmar.huina365.cn/c779036be3db4fe795f0bb856ff3418e.jfif",
                            @"creative_type": @2,
                            @"download_url": @"https://apps.apple.com/cn/app/id768082524",
                            @"showType": @1
                        },
                        @"tracking_list": @{
                            @"sf_url": @[
                                @"http://openapi.jiegames.com/Advertise/report/887421551,675e390cd31c41d1b960887047ab9150,1,5,it:3,mo=__OS__&ns=__IP__&m1=__IMEI__&m2=__IDFA__&m3=__DUID__&m1a=__ANDROIDID__&m2a=__OPENUDID__&m9=__MAC1__&m9b=__MAC__&m1b=__AAID__&m1c=__ANDROIDID1__&m9c=__ODIN__&ts=__TS__&st=__STS__&uuid=__UUID__&reqid=6bbc786354074d9abaa0945093849a5a"
                            ],
                            @"ds_url": @[
                                @"http://openapi.jiegames.com/Advertise/report/887421551,675e390cd31c41d1b960887047ab9150,1,3,it:3,mo=__OS__&ns=__IP__&m1=__IMEI__&m2=__IDFA__&m3=__DUID__&m1a=__ANDROIDID__&m2a=__OPENUDID__&m9=__MAC1__&m9b=__MAC__&m1b=__AAID__&m1c=__ANDROIDID1__&m9c=__ODIN__&ts=__TS__&st=__STS__&uuid=__UUID__&reqid=6bbc786354074d9abaa0945093849a5a"
                            ],
                            @"click_url": @[
                                @"http://openapi.jiegames.com/Advertise/report/887421551,675e390cd31c41d1b960887047ab9150,1,2,it:3,mo=__OS__&ns=__IP__&m1=__IMEI__&m2=__IDFA__&m3=__DUID__&m1a=__ANDROIDID__&m2a=__OPENUDID__&m9=__MAC1__&m9b=__MAC__&m1b=__AAID__&m1c=__ANDROIDID1__&m9c=__ODIN__&ts=__TS__&st=__STS__&uuid=__UUID__&sw=375&sh=667&adw=__AD_W__&adh=__AD_H__&cdx=CLK_D_X&cdy=CLK_D_Y&cux=CLK_UP_X&cuy=CLK_UP_Y&reqid=6bbc786354074d9abaa0945093849a5a"
                            ],
                            @"df_url": @[
                                @"http://openapi.jiegames.com/Advertise/report/887421551,675e390cd31c41d1b960887047ab9150,1,4,it:3,mo=__OS__&ns=__IP__&m1=__IMEI__&m2=__IDFA__&m3=__DUID__&m1a=__ANDROIDID__&m2a=__OPENUDID__&m9=__MAC1__&m9b=__MAC__&m1b=__AAID__&m1c=__ANDROIDID1__&m9c=__ODIN__&ts=__TS__&st=__STS__&uuid=__UUID__&reqid=6bbc786354074d9abaa0945093849a5a"
                            ],
                            @"show_url": @[
                                @"http://openapi.jiegames.com/Advertise/report/887421551,675e390cd31c41d1b960887047ab9150,1,1,it:3,mo=__OS__&ns=__IP__&m1=__IMEI__&m2=__IDFA__&m3=__DUID__&m1a=__ANDROIDID__&m2a=__OPENUDID__&m9=__MAC1__&m9b=__MAC__&m1b=__AAID__&m1c=__ANDROIDID1__&m9c=__ODIN__&ts=__TS__&st=__STS__&uuid=__UUID__&reqid=6bbc786354074d9abaa0945093849a5a"
                            ]
                        }
                    }
                ]
            },
            @"adReportToken": @"5bc545a8f1b7dff14ba16a579cad63ef",
            @"expiration_time": @1637821259,
            @"request_id": @"6bbc786354074d9abaa0945093849a5a"
        };
#endif

#ifdef TEST_DEEPLINK
        dictRet = @{
            @"msg": @"NO_ERROR",
            @"code": @"0",
            @"adslot_id": @24011,
            @"data": @{
                @"ads": @[
                    @{
                        @"ad": @{
                            @"logo_url": @"http://palmar.huina365.cn/sy_logo_1.0.1.png",
                            @"line": @1,
                            @"interaction_type": @1,
                            @"description": @"支付宝",
                            @"deeplink_url": @"alipays://platformapi/startapp?appId=20000067&url=https%3A%2F%2Frender.alipay.com%2Fp%2Fopx%2Fnormal-k89zo22y%2Fa.html%3FsceneCode%3DKF_ZHCPA%26shareChannel%3DQRCode%26partnerId%3Dxhm0003%26benefit%3Ddnsffl200908%26growthScene%3DIN_INVITE_UNTARGET_USER%26shareUserId%3D2088531041937287",
                            @"img_id": @"fbf97f0ff0779651f4adc22bac02995e",
                            @"source": @"SY-300",
                            @"title": @"支付宝",
                            @"invocationstyle": @"0",
                            @"acceleration": @10,
                            @"ad_id": @"2653",
                            @"img_url": @"http://palmar.huina365.cn/3ef9ecd314544832ac9a935d3439d2fd.png",
                            @"creative_type": @2,
                            @"showType": @1,
                            @"loading_url": @"https://m.tb.cn/h.fgzy4be"
                        },
                        @"tracking_list": @{
                            @"click_url": @[
                                @"http://openapi.jiegames.com/Advertise/report/887421551,9a1daa9932ec423186b45771dc124b04,1,2,it:1,mo=__OS__&ns=__IP__&m1=__IMEI__&m2=__IDFA__&m3=__DUID__&m1a=__ANDROIDID__&m2a=__OPENUDID__&m9=__MAC1__&m9b=__MAC__&m1b=__AAID__&m1c=__ANDROIDID1__&m9c=__ODIN__&ts=__TS__&st=__STS__&uuid=__UUID__&sw=375&sh=667&adw=__AD_W__&adh=__AD_H__&cdx=CLK_D_X&cdy=CLK_D_Y&cux=CLK_UP_X&cuy=CLK_UP_Y&reqid=0b2425e67e3f4c1187098bc8e9a0f7de"
                            ],
                            @"show_url": @[
                                @"http://openapi.jiegames.com/Advertise/report/887421551,9a1daa9932ec423186b45771dc124b04,1,1,it:1,mo=__OS__&ns=__IP__&m1=__IMEI__&m2=__IDFA__&m3=__DUID__&m1a=__ANDROIDID__&m2a=__OPENUDID__&m9=__MAC1__&m9b=__MAC__&m1b=__AAID__&m1c=__ANDROIDID1__&m9c=__ODIN__&ts=__TS__&st=__STS__&uuid=__UUID__&reqid=0b2425e67e3f4c1187098bc8e9a0f7de"
                            ]
                        }
                    }
                ]
            },
            @"adReportToken": @"5f1ef81562fdf4884ebcc88380182109",
            @"expiration_time": @1637824320,
            @"request_id": @"0b2425e67e3f4c1187098bc8e9a0f7de"
        };
#endif
        
        [self initDictConfig:dictRet];
        
        if (nil == self.m_dictConfig) {
            [self onFailed];
            
            return;
        }
                
        [self initView];
    }];
    
    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:1 type:11010];
}

- (SYDrawingCircleProgressButton *) m_btnSkip {
    if (nil == _m_btnSkip) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        CGRect buttonFrame = (CGRect) {
            .origin.x = rect.size.width - 60.f,
            .origin.y = 45.f,
            .size.width = 45.f,
            .size.height = 45.f
        };
        
        _m_btnSkip = [[SYDrawingCircleProgressButton alloc] initWithFrame:buttonFrame];
        _m_btnSkip.lineWidth = 2.f;
        [_m_btnSkip setTitle:@"跳过" forState:UIControlStateNormal];
        _m_btnSkip.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_m_btnSkip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_m_btnSkip addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _m_btnSkip.layer.zPosition = 1;
    }
    
    return _m_btnSkip;
}

- (UIImageView*) m_imgShake {
    if (nil == _m_imgShake) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        float fWidth = screenRect.size.width * 0.4;
        float fHeight = fWidth;
        float fX = (screenRect.size.width - fWidth) / 2;
        float fY = screenRect.size.height - (fHeight * 2);

        CGRect imgRect = CGRectMake(fX, fY, fWidth, fHeight);
        
        _m_imgShake = [[UIImageView alloc] initWithFrame:imgRect];
        _m_imgShake.animationImages = [NSArray arrayWithObjects:
                                       [UIImage imageNamed:@"shake_01.png"]
                                       , [UIImage imageNamed:@"shake_02.png"]
                                       , nil];
        _m_imgShake.animationDuration = 0.5f;
        _m_imgShake.animationRepeatCount = 0;
        _m_imgShake.contentMode = UIViewContentModeScaleAspectFill;
        
        // 超出边框的内容都剪掉
        _m_imgShake.clipsToBounds = YES;
        
//        _m_imgShake.backgroundColor = [UIColor redColor];
        _m_imgShake.layer.zPosition = 1;
        
        [_m_imgShake startAnimating];
    }
    
    return _m_imgShake;
}

- (UIImageView*) m_imgMain {
    if (nil == _m_imgMain) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        _m_imgMain = [[UIImageView alloc] initWithFrame:rect];
        _m_imgMain.layer.zPosition = 0;
    }
    
    return _m_imgMain;
}

- (void) showUrl {
    if (nil == self.m_dictAdConfig) {
        return;
    }
    
    NSString* pszUrl = self.m_dictAdConfig[@"ad"][@"loading_url"];
    if ([StringUtils isEmpty:pszUrl]) {
        return;
    }
    
    if (nil == self.rootViewController) {
        return;
    }
    
    TGWebViewController* web = [[TGWebViewController alloc] init];
    web.url = pszUrl;
//    web.webTitle = @"web";
    web.progressColor = [UIColor blueColor];
    [(UINavigationController*)self.rootViewController pushViewController:web animated:YES];
}

- (void) openDeeplink {
    if (nil == self.m_dictAdConfig) {
        return;
    }
    
    NSString* pszUrl = self.m_dictAdConfig[@"ad"][@"deeplink_url"];
    if ([StringUtils isEmpty:pszUrl]) {
        return;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:pszUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pszUrl]];
    } else {
        pszUrl = self.m_dictAdConfig[@"ad"][@"loading_url"];
        if ([StringUtils isEmpty:pszUrl]) {
            return;
        }
        
        TGWebViewController* web = [[TGWebViewController alloc] init];
        web.url = pszUrl;
    //    web.webTitle = @"web";
        web.progressColor = [UIColor blueColor];
        [(UINavigationController*)self.rootViewController pushViewController:web animated:YES];
    }
}

- (void) onSplashAdClick:(id)sender {
    if (self.syDelegate) {
        [self.syDelegate splashAdDidClick:self];
        [self reportClick];
        [self reportDs];
        [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:1 type:2];
    }
    
    if (nil == self.m_dictAdConfig) {
        return;
    }
    
    NSNumber* nInteractionType = self.m_dictAdConfig[@"ad"][@"interaction_type"];
    if (nil == nInteractionType) {
        return;
    }
    
    switch (nInteractionType.intValue) {
        case 1: //deeplink
            [self openDeeplink];
            break;
        case 2: //show url
            [self showUrl];
            break;
        case 3: //download app
            [self openAppStore];
            break;
        default:
            break;
    }
}

- (void) onBtnClick:(id) sender {
    if (sender == self.m_btnSkip) {
        
        if (self.syDelegate) {
            [self.syDelegate splashAdDidClickSkip:self];
        }
        
        if (self.syDelegate) {
            [self.syDelegate splashAdWillClose:self];
        }
        
        if (self.syDelegate) {
            [self.syDelegate splashAdDidClose:self];
        }
    } else {
        
    }
}

- (void) initSplash:(NSData*)data {
//        self.m_imgMain = [[UIImageView alloc] init];
    self.m_imgMain.image = [UIImage imageWithData:data];
    [self addSubview:self.m_imgMain];
    [self addSubview:self.m_btnSkip];
    
    [self.m_btnSkip startProgressAnimationWithDuration:5 completionHandler:^(SYDrawingCircleProgressButton *progressButton){
        if (self.syDelegate) {
            [self.syDelegate splashAdWillClose:self];
        }
    }];
    
    if (self.m_dictAdConfig) {
#ifdef TEST_SPLASH_SHAKE
        [self becomeFirstResponder];
        [self addSubview:self.m_imgShake];
#else
        if ([@"0" isEqualToString:self.m_dictAdConfig[@"ad"][@"invocationstyle"]]
            || [@"2" isEqualToString:self.m_dictAdConfig[@"ad"][@"invocationstyle"]]) {
            //0: 广告行为必须通过点击触发
            //2:滑动 (点击上报时可以忽略点击坐标相关宏替换)
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSplashAdClick:)];
            singleTap.numberOfTapsRequired = 1;
            
            [_m_imgMain setUserInteractionEnabled:YES];
            [_m_imgMain addGestureRecognizer:singleTap];
        } else if ([@"1" isEqualToString:self.m_dictAdConfig[@"ad"][@"invocationstyle"]]) {
            //1: 摇一摇(点击 上报时可以忽略点击坐标相关宏替换)
            [self becomeFirstResponder];
            [self addSubview:self.m_imgShake];
        } else {
            
        }
#endif
    }

    if (self.syDelegate) {
        [self.syDelegate splashAdDidLoad:self];
        [self.syDelegate splashAdWillVisible:self];
        [self reportShow];
        [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:1 type:11011];
        [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:1 type:1];

    }
}

- (void) initView {
    if (nil == self.m_dictConfig) {
        [self onFailed];
        return;
    }
    
    NSArray* aryAd = self.m_dictConfig[@"data"][@"ads"];
    NSDictionary* dictAd = aryAd[0];
    if (nil == dictAd) {
        [self onFailed];
        return;
    }
    
    self.m_dictAdConfig = dictAd;
    if (nil == self.m_dictAdConfig) {
        [self onFailed];
        return;
    }
    
    NSString *pszImgUrl = self.m_dictAdConfig[@"ad"][@"img_url"];
    if ([StringUtils isEmpty:pszImgUrl]) {
        [self onFailed];
        return;
    }
    
    NSString* pszLogoUrl = self.m_dictAdConfig[@"ad"][@"logo_url"];
    if (NO == [StringUtils isEmpty:pszImgUrl]) {
        [self setupLogo:pszLogoUrl];
    }
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pszImgUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            [self onFailed];
            return;
        }
        
        if (nil == data || nil == response) {
            [self onFailed];
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (200 != httpResponse.statusCode) {
            [self onFailed];
            return;
        }
        
        [self initSplash:data];
    }];
}

- (void)setSYDelegate:(id<ISplashAdViewDelegate>)delegate {
    self.syDelegate = delegate;
}

#pragma mark - 摇动

- (BOOL) canBecomeFirstResponder {
    return YES;
}

/**
 *  摇动开始
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"开始摇了");
        [self resignFirstResponder];
        [self onSplashAdClick:self];
    }
}

/**
 *  摇动结束
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"摇动结束");
}

/**
 *  摇动取消
 */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"摇动取消");
}

//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    if ( event.subtype == UIEventSubtypeMotionShake ) {
//        // Put in code here to handle shake
//    }
//
//    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] ) {
//        [super motionEnded:motion withEvent:event];
//    }
//}

@end
