//
//  RBTabBarController.m
//  Base
//
//  Created by 蓝其 on 16/10/18.
//  Copyright © 2016年 蓝其. All rights reserved.
//

#import "RBTabBarController.h"
#import <objc/runtime.h>

static NSString *const RBTABBAR_POPTOROOT_NOTI = @"RBTABBAR_POPTOROOT_NOTI";

@interface UINavigationController(RBTabBar)

@end

@implementation UINavigationController(RBTabBar)

+ (void)load
{
    Method original = class_getInstanceMethod([UINavigationController class], @selector(popToRootViewControllerAnimated:));
    Method swizzled = class_getInstanceMethod([self class], @selector(swizzledPopToRootViewControllerAnimated:));
    method_exchangeImplementations(original, swizzled);
}

- (NSArray *)swizzledPopToRootViewControllerAnimated: (BOOL)animated
{
    NSArray *array = [self swizzledPopToRootViewControllerAnimated:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:RBTABBAR_POPTOROOT_NOTI object:nil];
    return array;
}

@end

@interface RBTabBarController ()

@property(nonatomic, strong)NSArray *buttons;
@property(nonatomic, strong)NSArray *indexes;
@property(nonatomic, strong)NSArray *proportions;

@end

@implementation RBTabBarController

#pragma mark - LifeCycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.autoSelectVC = YES;
        [self.tabBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        __weak typeof(self) weakSelf = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:RBTABBAR_POPTOROOT_NOTI object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //popToRoot后重新生成了UITbaBarButton
            [weakSelf clearUITabBarButtons];
        }];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self clearUITabBarButtons];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self clearUITabBarButtons];
}

- (void)dealloc
{
    [self.tabBar removeObserver:self forKeyPath:@"frame"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        [self layOutsubviewsOnTabBar];
    }
}

#pragma mark - Public

- (void)setTabBarButtons:(NSArray<__kindof UIButton *> *)buttons withIndexesOfViewController:(NSArray<__kindof NSNumber *> *)indexes proportionsOfTabBarWidth:(NSArray<__kindof NSNumber *> *)proportions
{
    self.buttons = buttons;
    self.indexes = indexes;
    self.proportions = proportions;
    [self clearUIButtons];
    [self layOutsubviewsOnTabBar];
    self.selectedTabBarButtonIndex = 0;
}

- (UIButton *)tabBarButtonAtIndex:(NSInteger)index
{
    return index < self.buttons.count? self.buttons[index]: nil;
}

- (CGRect)frameForTabBarButtonAtIndex:(NSInteger)index
{
    
    return [[self tabBarButtonAtIndex:index] frame];
}

- (void)layOutsubviewsOnTabBar
{
    CGFloat height = self.tabBar.frame.size.height;
    CGFloat width = 0;
    CGFloat y = 0;
    CGFloat x = 0;
    UIButton *button;
    for (NSInteger index = 0; index < self.buttons.count; index++)
    {
        button = self.buttons[index];
        width = self.tabBar.frame.size.width * [self.proportions[index] floatValue];
        [button setFrame:CGRectMake(x, y, width, height)];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchDown];
//        button.adjustsImageWhenHighlighted = NO;
        [self.tabBar addSubview:button];
        x += width;
    }
}

- (void)setSelectedTabBarButtonIndex:(NSInteger)index
{
    if (index >= self.buttons.count)
    {
        return;
    }
    NSInteger indexOfViewController = [self.indexes[index] integerValue];
    if (indexOfViewController != NSNotFound)
    {
        UIButton *lastButton = [self tabBarButtonAtIndex:_selectedTabBarButtonIndex];
        UIButton *currentButton = [self tabBarButtonAtIndex:index];
        //切换按钮
        lastButton.selected = NO;
        currentButton.selected = YES;
        //切换控制器
        self.selectedIndex = indexOfViewController;
        //更新选中序号
        _selectedTabBarButtonIndex = index;
    }
}

#pragma mark - Private

- (void)clearUIButtons
{
    for (UIView *subview in self.tabBar.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            [subview removeFromSuperview];
        }
    }
}
#pragma mark - 已知问题,popToRoot有问题,检查一下生命周期
- (void)clearUITabBarButtons
{
    for (UIView *subview in self.tabBar.subviews)
    {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [subview removeFromSuperview];
        }
    }
}

#pragma mark - Event

- (void)buttonTapped: (UIButton *)button
{
    NSInteger index = [self.buttons indexOfObject:button];
    if (self.tabBarButtonTappedBlock)
    {
        self.tabBarButtonTappedBlock(self, button, index, self.selectedTabBarButtonIndex);
    }
    if(index != self.selectedTabBarButtonIndex && self.autoSelectVC)
    {
        self.selectedTabBarButtonIndex = index;
    }
}

@end
