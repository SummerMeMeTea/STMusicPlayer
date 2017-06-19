//
//  RBTimerButton.m
//  RBTimerButton
//
//  Created by Ran on 16/4/18.
//  Copyright © 2016年 Justice. All rights reserved.
//

#import "RBTimerButton.h"
NSString *const RB_DEFAULT_PHONE_TIMER_KEY = @"RB_DEFAULT_PHONE_TIMER_KEY";
NSString *const RB_DEFAULT_MAIL_TIMER_KEY = @"RB_DEFAULT_MAIL_TIMER_KEY";

//Copied from YYImage
@interface RBTimerProxy : NSProxy

@property (nonatomic, weak, readonly) id target;
- (instancetype)initWithTarget:(id)target;
+ (instancetype)proxyWithTarget:(id)target;

@end

@implementation RBTimerProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}
+ (instancetype)proxyWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}
- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}
- (BOOL)isEqual:(id)object {
    return [_target isEqual:object];
}
- (NSUInteger)hash {
    return [_target hash];
}
- (Class)superclass {
    return [_target superclass];
}
- (Class)class {
    return [_target class];
}
- (BOOL)isKindOfClass:(Class)aClass {
    return [_target isKindOfClass:aClass];
}
- (BOOL)isMemberOfClass:(Class)aClass {
    return [_target isMemberOfClass:aClass];
}
- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_target conformsToProtocol:aProtocol];
}
- (BOOL)isProxy {
    return YES;
}
- (NSString *)description {
    return [_target description];
}
- (NSString *)debugDescription {
    return [_target debugDescription];
}
@end

@interface RBTimerButton ()

@property(nonatomic, strong)CADisplayLink *displayLink;

@end
@implementation RBTimerButton

#pragma mark - System

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)dealloc
{
    
#if DEBUG
    NSLog(@"timer button dealloc");
#endif
    [_displayLink invalidate];
    _displayLink = nil;
}

#pragma mark - Public

- (BOOL)hasReachedMaxTimeInterval
{
    NSDate *fireDate = [self getFireDate];
    if(fireDate && self.maxTimeInterval > [[NSDate date] timeIntervalSinceDate:fireDate])
    {
        return NO;
    }
    return YES;
}

- (void)startTimer
{
    NSDate *fireDate = [self getFireDate];
    if (fireDate && [[NSDate date] timeIntervalSinceDate:fireDate] > self.maxTimeInterval)
    {
        [self removeFireDate];
    }
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)restartTimer
{
    [self stopTimer];
    [self startTimer];
}

- (void)stopTimer
{
    [self removeFireDate];
    [_displayLink invalidate];
    _displayLink = nil;
    if (self.settingBlock) {
        self.settingBlock(self.maxTimeInterval + 1);
    }
}

#pragma mark - Private

- (void)setup
{
    self.timerKey = RB_DEFAULT_PHONE_TIMER_KEY;
    self.maxTimeInterval = 30.0;
    __weak typeof(self) weakSelf = self;
    self.settingBlock = ^(NSTimeInterval time){
        if (time <= weakSelf.maxTimeInterval)
        {
            weakSelf.enabled = NO;
            weakSelf.backgroundColor = [UIColor whiteColor];
            [weakSelf setAttributedTitle:({
                NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1fS", weakSelf.maxTimeInterval - time] attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:243/255.0 green:152/255.0 blue:0 alpha:1], NSFontAttributeName: [UIFont systemFontOfSize:15]}]];
                [stringM appendAttributedString:[[NSAttributedString alloc] initWithString:@"后可重发" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:88/255.0 green:88/255.0 blue:88/255.0 alpha:1], NSFontAttributeName: [UIFont systemFontOfSize:15]}]];
                stringM;
                
            }) forState:UIControlStateDisabled];
        }
        else
        {
            weakSelf.enabled = YES;
            weakSelf.backgroundColor = [UIColor colorWithRed:65/255.0 green:199/255.0 blue:156/255. alpha:1];
            [weakSelf setAttributedTitle:[[NSAttributedString alloc] initWithString:@"获取验证码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:15]}] forState:UIControlStateNormal];
        }
    };
}

- (NSDate *)getFireDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.timerKey];
}

- (void)storeFireDate: (NSDate *)date
{
    if(!date)return;
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:self.timerKey];
}

- (void)removeFireDate
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.timerKey];
}

#pragma mark - Event

- (void)linkEvent
{
    NSDate *fireDate = [self getFireDate];
    if (!fireDate)
    {
        fireDate = [NSDate date];
        [self storeFireDate:fireDate];
    }
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:fireDate];
    if (self.settingBlock)
    {
        self.settingBlock(timeInterval);
    }
    if (self.maxTimeInterval <= timeInterval)
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
        [self removeFireDate];
    }
}

#pragma mark - Getter

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:[RBTimerProxy proxyWithTarget:self] selector:@selector(linkEvent)];
        self.displayLink = link;
    }
    return _displayLink;
}

@end
