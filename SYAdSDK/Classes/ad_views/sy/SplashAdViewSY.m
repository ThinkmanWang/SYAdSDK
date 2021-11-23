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

@interface SplashAdViewSY ()
@property(nonatomic, strong) NSString* m_pszSlotID;
@property(nonatomic, strong) NSString* m_pszSYSlotID;
@property(nonatomic, strong) NSString* m_pszRequestId;

@property (nonatomic, strong) SYDrawingCircleProgressButton* m_btnSkip;

@property (nonatomic, weak) UIViewController *rootViewController;

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
        self.m_pszSlotID = @"";
        self.m_pszSYSlotID = @"";
        self.syDelegate = nil;
        self.rootViewController = nil;
//        self.m_pszRequestId = [[SYLogUtils uuidString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self.m_pszSlotID = slotID;
    
//    self.delegate = self;
//    self.needSplashZoomOutAd = YES;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.frame = frame;
    
//    self.m_pszSYSlotID = [SlotUtils getRealSlotID:slotID];
//    self = [super initWithSlotID:self.m_pszBuSlotID frame:frame];
    

    
    return self;
}

- (SYDrawingCircleProgressButton *) m_btnSkip
{
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

- (void) onBtnClick:(id) sender {
    if (sender == self.m_btnSkip) {
        if (self.syDelegate) {
            [self.syDelegate splashAdWillClose:self];
        }
    } else {
        
    }
}

- (void)loadAdData {
    //optional
    
//    [super loadAdData];
//
//    [SYLogUtils report:self.m_pszSlotID requestID:self.m_pszRequestId sourceId:0 type:11010];
#ifdef TEST_SY_AD
    [self addSubview:self.m_btnSkip];
    self.backgroundColor = [UIColor redColor];
    [self.m_btnSkip startProgressAnimationWithDuration:5 completionHandler:^(SYDrawingCircleProgressButton *progressButton){
        if (self.syDelegate) {
            [self.syDelegate splashAdWillClose:self];
        }
    }];
    
    if (self.syDelegate) {
        [self.syDelegate splashAdDidLoad:self];
    }
#endif
}

- (void) removeMyself {
    [self removeFromSuperview];
}

- (void)setRequestID:(NSString*)requestID {
    self.m_pszRequestId = requestID;
}

- (CGRect)getFrame {
    return self.frame;
}

- (void)setSYRootViewController:(UIViewController*)rootViewController {
    self.rootViewController = rootViewController;
}

- (void)setSYDelegate:(id<ISplashAdViewDelegate>)delegate {
    self.syDelegate = delegate;
}

@end
