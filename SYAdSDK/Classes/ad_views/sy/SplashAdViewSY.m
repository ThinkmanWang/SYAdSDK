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
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSplashAdClick:)];
        singleTap.numberOfTapsRequired = 1;
        
        [_m_imgMain setUserInteractionEnabled:YES];
        [_m_imgMain addGestureRecognizer:singleTap];
    }
    
    return _m_imgMain;
}

- (void) onSplashAdClick:(id)sender {
    if (self.syDelegate) {
        [self.syDelegate splashAdDidClick:self];
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
    } else if (sender == self.m_imgMain) {
        if (self.syDelegate) {
            [self.syDelegate splashAdDidClick:self];
        }
    } else {
        
    }
}

- (void)loadAdData {
    //optional

    [SYAdUtils getSYAd:self.m_pszSYSlotID
            nAdCount:1
           onSuccess:^(NSDictionary* dictRet) {
        [self initDictCOnfig:dictRet];
        
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

- (void) initView {
    NSArray* aryAd = self.m_dictConfig[@"data"][@"ads"];
    NSDictionary* dictAd = aryAd[0];
    
    NSString *pszImgUrl = dictAd[@"ad"][@"img_url"];
    if ([StringUtils isEmpty:pszImgUrl]) {
        if (self.syDelegate) {
            [self.syDelegate splashAd:self];
        }
        return;
    }
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pszImgUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
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

@end
