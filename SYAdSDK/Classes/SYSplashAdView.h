
#import <UIKit/UIKit.h>

@protocol SYSplashAdDelegate;

@interface SYSplashAdView : UIView

/**
The unique identifier of splash ad.
 */
@property (nonatomic, copy, nonnull) NSString *slotID;

/**
 Maximum allowable load timeout, default 3s, unit s.
 */
@property (nonatomic, assign) double tolerateTimeout;

/**
 Whether hide skip button, default NO.
 If you hide the skip button, you need to customize the countdown.
 */
@property (nonatomic, assign) BOOL hideSkipButton;

///optional: Whether need splashZoomOutAd, default NO.
@property (nonatomic, assign) BOOL needSplashZoomOutAd;

/**
 The delegate for receiving state change messages.
 */
@property (nonatomic, weak, nullable) id<SYSplashAdDelegate> delegate;

/*
 required.
 Root view controller for handling ad actions.
 */
@property (nonatomic, weak) UIViewController *rootViewController;

/**
 Initializes splash ad with slot id and frame.
 @param slotID : the unique identifier of splash ad
 @param frame : the frame of splashAd view. It is recommended for the mobile phone screen.
 @return BUSplashAdView
 */
- (instancetype)initWithSlotID:(NSString *)slotID;

- (void)loadAdData;

@end

#pragma mark - SYSplashAdDelegate

@protocol SYSplashAdDelegate <NSObject>

@optional
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)splashAdDidLoad:(SYSplashAdView *)splashAd;

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)splashAd:(SYSplashAdView *)splashAd;

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(SYSplashAdView *)splashAd;

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(SYSplashAdView *)splashAd;

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(SYSplashAdView *)splashAd;

/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(SYSplashAdView *)splashAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashAdDidCloseOtherController:(SYSplashAdView *)splashAd;

/**
 This method is called when spalashAd skip button  is clicked.
 */
- (void)splashAdDidClickSkip:(SYSplashAdView *)splashAd;

/**
 This method is called when spalashAd countdown equals to zero
 */
- (void)splashAdCountdownToZero:(SYSplashAdView *)splashAd;

@end
