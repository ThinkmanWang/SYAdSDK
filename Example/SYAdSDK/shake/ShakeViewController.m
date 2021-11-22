//
//  ShakeViewController.m
//  SYAdSDK_Example
//
//  Created by 王晓丰 on 2021/11/19.
//  Copyright © 2021 Thinkman Wang. All rights reserved.
//

#import "ShakeViewController.h"

@interface ShakeViewController ()

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 摇动

/**
 *  摇动开始
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake) {
        
        NSLog(@"开始摇了");
        
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

@end
