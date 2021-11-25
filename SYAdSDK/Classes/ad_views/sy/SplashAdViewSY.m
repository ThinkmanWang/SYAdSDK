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

- (void)loadAdData {
    //optional

    [SYAdUtils getSYAd:self.m_pszSYSlotID
            nAdCount:1
           onSuccess:^(NSDictionary* dictRet) {
        [self initDictConfig:dictRet];
        
        if (nil == self.m_dictConfig) {
            if (self.syDelegate) {
                [self.syDelegate splashAd:self];
            }
            
            return;
        }
        
        [self initView];
    }];
    
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11010];
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

    }
    
    return _m_btnSkip;
}

- (UIImageView*) m_imgMain {
    if (nil == _m_imgMain) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        _m_imgMain = [[UIImageView alloc] initWithFrame:rect];
        
        if (self.m_dictAdConfig) {
#ifdef TEST_SPLASH_SHAKE
            [self becomeFirstResponder];
#else
            if ([@"0" isEqualToString:self.m_dictAdConfig[@"ad"][@"invocationstyle"]]) {
                //0: 广告行为必须通过点击触发
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSplashAdClick:)];
                singleTap.numberOfTapsRequired = 1;
                
                [_m_imgMain setUserInteractionEnabled:YES];
                [_m_imgMain addGestureRecognizer:singleTap];
            } else if ([@"1" isEqualToString:self.m_dictAdConfig[@"ad"][@"invocationstyle"]]) {
                //1: 摇一摇(点击 上报时可以忽略点击坐标相关宏替换)
                [self becomeFirstResponder];
            } else if ([@"2" isEqualToString:self.m_dictAdConfig[@"ad"][@"invocationstyle"]]) {
                //2:滑动 (点击上报时可以忽略点击坐标相关宏替换)
                
            } else {
                
            }
#endif
        }
        
    }
    
    return _m_imgMain;
}

- (void) onSplashAdClick:(id)sender {
    if (self.syDelegate) {
        [self.syDelegate splashAdDidClick:self];
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
//    [self.rootViewController.navigationController pushViewController:web animated:YES];
    
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
    } else if (sender == self.m_imgMain) {
        if (self.syDelegate) {
            [self.syDelegate splashAdDidClick:self];
        }
    } else {
        
    }
}

- (void) initView {
    NSArray* aryAd = self.m_dictConfig[@"data"][@"ads"];
    NSDictionary* dictAd = aryAd[0];
    if (nil == dictAd) {
        if (self.syDelegate) {
            [self.syDelegate splashAd:self];
        }
        return;
    }
    
    self.m_dictAdConfig = dictAd;
    
    NSString *pszImgUrl = self.m_dictAdConfig[@"ad"][@"img_url"];
    if ([StringUtils isEmpty:pszImgUrl]) {
        if (self.syDelegate) {
            [self.syDelegate splashAd:self];
        }
        return;
    }
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pszImgUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            if (self.syDelegate) {
                [self.syDelegate splashAd:self];
            }
            return;
        }
        
        if (nil == data || nil == response) {
            if (self.syDelegate) {
                [self.syDelegate splashAd:self];
            }
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (200 != httpResponse.statusCode) {
            if (self.syDelegate) {
                [self.syDelegate splashAd:self];
            }
            return;
        }
        
//        self.m_imgMain = [[UIImageView alloc] init];
        self.m_imgMain.image = [UIImage imageWithData:data];
        [self addSubview:self.m_imgMain];
        
        [self addSubview:self.m_btnSkip];
        [self.m_btnSkip startProgressAnimationWithDuration:5 completionHandler:^(SYDrawingCircleProgressButton *progressButton){
            if (self.syDelegate) {
                [self.syDelegate splashAdWillClose:self];
            }
        }];
        
        if (self.syDelegate) {
            [self.syDelegate splashAdDidLoad:self];
            [self.syDelegate splashAdWillVisible:self];
        }
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
