//
//  SYDrawingCircleProgressButton.h
//  Masonry
//
//  Created by 王晓丰 on 2021/5/19.
//

#ifndef SYDrawingCircleProgressButton_h
#define SYDrawingCircleProgressButton_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class SYDrawingCircleProgressButton;

typedef void (^SYDrawingCircleProgressCompletionHanlder)(SYDrawingCircleProgressButton *progressButton);

@interface SYDrawingCircleProgressButton : UIButton

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat lineWidth;

- (void)startProgressAnimationWithDuration:(double)duration completionHandler:(SYDrawingCircleProgressCompletionHanlder)completionHandler;

@end


NS_ASSUME_NONNULL_END

#endif
