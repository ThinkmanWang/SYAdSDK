//
//  SYAppDelegate.m
//  SYAdSDK
//
//  Created by Thinkman Wang on 01/25/2021.
//  Copyright (c) 2021 Thinkman Wang. All rights reserved.
//

#import "SYAppDelegate.h"
#import <SYAdSDK/SYAdSDK.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import "SYViewController.h"

@interface SYAppDelegate() <SYSplashAdDelegate>
@property SYSplashAdView* splashAdView;
@end

@implementation SYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[SYViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    [self requestIDFA];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - SYAdSDK
- (void)requestIDFA {
    if (@available(iOS 14.0, *)) {
        ATTrackingManagerAuthorizationStatus states = [ATTrackingManager trackingAuthorizationStatus];
        if (ATTrackingManagerAuthorizationStatusAuthorized == states) {
            NSLog(@"Request IDFA SUCCESS!!!");
        }
    }
    
    [self initLaunchScreen];
    
}

- (void) initLaunchScreen {
    [SYAdSDKManager initSSDK:@"MjUzMDU3MDAyNzU2" level:SYAdSDKLogLevelDebug onInitFinish:^(BOOL bSuccess) {
        if (bSuccess) {
            self.splashAdView = [[[SYSplashAdView alloc] init] initWithSlotID:@"887421551"];
            self.splashAdView.delegate = self;
            
            [self.window.rootViewController.view addSubview:self.splashAdView];
            self.splashAdView.rootViewController = self.window.rootViewController;

            [self.splashAdView loadAdData];
        }
    }];
}


#pragma mark launchscreeen events
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)splashAdDidLoad:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidLoad");
}

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)splashAd:(SYSplashAdView *)splashAd {
    NSLog(@"splashAd");
}

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdWillVisible");
}

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidClick");
}

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidClose");
}

/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdWillClose");
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashAdDidCloseOtherController:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidCloseOtherController");
}

/**
 This method is called when spalashAd skip button  is clicked.
 */
- (void)splashAdDidClickSkip:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdDidClickSkip");
}

/**
 This method is called when spalashAd countdown equals to zero
 */
- (void)splashAdCountdownToZero:(SYSplashAdView *)splashAd {
    NSLog(@"splashAdCountdownToZero");
}

@end
