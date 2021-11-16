//
//  SYSkipButton.m
//  SYAdSDK
//
//  Created by 王晓丰 on 2021/5/25.
//

#import "SYSkipButton.h"

@implementation SYSkipButton

- (id) init {
//    self = (SYCountDownButton*)[super buttonWithType:UIButtonTypeCustom];
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor darkGrayColor];
//        self.m_btnCountDownSkip.backgroundColor = [UIColor clearColor].CGColor;
        CGRect rect = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(rect.size.width - 80.f, 100, 70, 30);
        [self setTitle:@"跳过" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.alpha = 0.4;
        self.layer.cornerRadius = 14;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
//        self.m_btnCountDownSkip.backgroundColor = [UIColor clearColor].CGColor;
        self.frame = frame;
        [self setTitle:@"跳过" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.alpha = 0.4;
        self.layer.cornerRadius = 14;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
