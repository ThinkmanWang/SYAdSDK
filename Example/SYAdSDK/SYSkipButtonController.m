//
//  SYSkipButtonControllerViewController.m
//  SYAdSDK_Example
//
//  Created by 王晓丰 on 2021/5/25.
//  Copyright © 2021 Thinkman Wang. All rights reserved.
//

#import "SYSkipButtonController.h"
#import <SYAdSDK/SYDrawingCircleProgressButton.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <SYAdSDK/SYCountDownButton.h>
#import <SYAdSDK/SYSkipButton.h>
#import <SYAdSDK/SYCircleCountDownButton.h>

@interface SYSkipButtonController ()
@property (nonatomic, strong) SYDrawingCircleProgressButton *progressButton;
@property (nonatomic, strong) SYCountDownButton* m_btnCountDown;
@property (nonatomic, strong) SYSkipButton* m_btnSkip;
@property (nonatomic, strong) SYCircleCountDownButton* m_btnCircleCountDown;
@end

@implementation SYSkipButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView {
    if (nil != self.progressButton) {
        [self.view addSubview:self.progressButton];
    }
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.m_btnCountDown = [[SYCountDownButton alloc] initWithFrame:CGRectMake(rect.size.width - 80.f, 100, 70, 30)];
    [self.view addSubview:self.m_btnCountDown];
    
    self.m_btnSkip = [[SYSkipButton alloc] initWithFrame:CGRectMake(rect.size.width - 80.f, 150, 70, 30)];
    [self.view addSubview:self.m_btnSkip];
    
    self.m_btnCircleCountDown = [[SYCircleCountDownButton alloc] initWithFrame:CGRectMake(rect.size.width - 60.f, 260, 50, 50)];
    [self.view addSubview:self.m_btnCircleCountDown];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_progressButton startProgressAnimationWithDuration:5 completionHandler:nil];
}

- (SYDrawingCircleProgressButton *)progressButton
{
    if (nil == _progressButton) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        CGRect buttonFrame = (CGRect) {
            .origin.x = rect.size.width - 55.f,
            .origin.y = 200.f,
            .size.width = 45.f,
            .size.height = 45.f
        };
        
        _progressButton = [[SYDrawingCircleProgressButton alloc] initWithFrame:buttonFrame];
//        _progressButton = [[SYDrawingCircleProgressButton alloc] init];
        _progressButton.lineWidth = 2.f;
        [_progressButton setTitle:@"跳过" forState:UIControlStateNormal];
        _progressButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_progressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_progressButton addTarget:self action:@selector(__skipButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _progressButton;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
