//
//  RBTimerButton.h
//  RBTimerButton
//
//  Created by Ran on 16/4/18.
//  Copyright © 2016年 Justice. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const RB_DEFAULT_PHONE_TIMER_KEY;
extern NSString *const RB_DEFAULT_MAIL_TIMER_KEY;

@interface RBTimerButton : UIButton

/**
 *  Different keys match different timers,RB_DEFAULT_PHONE_TIMER_KEY by default.
 */
@property(nonatomic, copy)NSString *timerKey;
/**
 *  Stop timer maxTimeInterval seconds later since fired,30.0 by default.
 */
@property(nonatomic, assign)NSTimeInterval maxTimeInterval;
/**
 *  eg: set displayLink.frameInterval = 60.
 */
@property(nonatomic, readonly)CADisplayLink *displayLink;
/**
 *  Has default value, you can customize
 */
@property(nonatomic, copy)void(^settingBlock)(NSTimeInterval timeInterval);

- (BOOL)hasReachedMaxTimeInterval;
- (void)startTimer;
- (void)restartTimer;
- (void)stopTimer;

@end
