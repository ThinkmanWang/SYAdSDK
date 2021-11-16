//
//  SYCircleCountDownButton.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/5/25.
//

#import "SYCircleCountDownButton.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYCircleCountDownButton ()
@property (nonatomic, strong) NSTimer* m_timer;
@end

static int m_nCountdown = 5;

@implementation SYCircleCountDownButton

- (id) init {
//    self = (SYCountDownButton*)[super buttonWithType:UIButtonTypeCustom];
    self = [super init];
    
    if (self) {
        m_nCountdown = 5;
        
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor darkGrayColor];
//        self.m_btnCountDownSkip.backgroundColor = [UIColor clearColor].CGColor;
        CGRect rect = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(rect.size.width - 80.f, 100, 70, 70);
        [self setTitle:[NSString stringWithFormat:@"跳过\n%d", m_nCountdown] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.alpha = 0.4;
        self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2.f;
        self.layer.masksToBounds = YES;
        
        
        _m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = (SYCircleCountDownButton*)[super initWithFrame:frame];
    
    if (self) {
        m_nCountdown = 5;
        
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor darkGrayColor];
//        self.m_btnCountDownSkip.backgroundColor = [UIColor clearColor].CGColor;
        self.frame = frame;
        [self setTitle:[NSString stringWithFormat:@"跳过\n%d", m_nCountdown] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.alpha = 0.4;
        self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2.f;
        self.layer.masksToBounds = YES;
        
        
        _m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
    }
    
    return self;
}

- (void) timerFired {
    if(m_nCountdown>0)
    {
        m_nCountdown -= 1;
        [self setTitle:[NSString stringWithFormat:@"跳过\n%d", m_nCountdown] forState:UIControlStateNormal];
    }
    else
    {
        [_m_timer invalidate];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
