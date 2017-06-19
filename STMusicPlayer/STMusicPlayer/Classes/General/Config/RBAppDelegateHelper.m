//
//  RBAppDelegateHelper.m
//  基本结构
//
//  Created by 蓝其 on 16/10/19.
//  Copyright © 2016年 蓝其. All rights reserved.
//

#import "RBAppDelegateHelper.h"
//section
#import "STDiscoveryVC.h"
#import "STMessageVC.h"
#import "STAccountVC.h"

//loading
#import "RBSignInVC.h"
#import "RBTabBarController.h"
#import "RBTabBarButton.h"

#import "RBThemeConfig.h"
#import "UIImage+RBAdd.h"
#import "RBKeyConfig.h"
#import "RBPersistence.h"
#import "RBFeatureView.h"
#import "RBDefine.h"
#import "RBSignInManager.h"

@implementation RBAppDelegateHelper

+ (void)load
{
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note){
        [self setup];
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
    NSLog(@"%@", observer);
}

+ (void)setup
{
    [self setNavigationBarAppearance];
    [self setTabBarAppearance];
    [self setRootViewController];
}

#pragma mark - Appearance

+ (void)setNavigationBarAppearance
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //title颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [RBThemeConfig navigationBarTitleFont]};
    //bar颜色和bar下面阴影颜色
    [navigationBar setBackgroundImage:[UIImage rbImageWithColor:[RBThemeConfig themeColor]] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [UIImage rbImageWithColor:[RBThemeConfig themeColor]];
/*
 (1)导航栏透明问题:
 1.translucent = NO,强制不透明,barTintColor就不会变色了
 2.- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics
 这个取决于backgroundImage透明度,如果这个图片有透明度导航栏就透明,否则不透明
 
 (2)导航栏阴影问题:
 - (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics
 设置以后shadowImage才生效
 
 (3)控制器中view的起点问题:
 如果导航栏透明,起点从屏幕最上方开始,否则从导航栏下方开始,是否透明可以通过translucent
 判断,如果setBackgroundImage设置了不透明图片,translucent也会被设置为不透明
 
 (4)推论,tabBar问题同理
 */
    //item文字
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [RBThemeConfig navigationItemFont]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [RBThemeConfig navigationItemFont]} forState:UIControlStateHighlighted];
    //item返回箭头颜色
    navigationBar.tintColor = [UIColor whiteColor];
    //item返回图标 ....
}

+ (void)setTabBarAppearance
{
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.translucent = NO;
    tabBar.barTintColor = [UIColor colorWithWhite:0.97 alpha:1];
//    UITabBarItem *item = [UITabBarItem appearance];
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateSelected];
    //    tabBar.backgroundImage = [self imageWithColor:[UIColor clearColor]];
    //    tabBar.shadowImage = [self imageWithColor:[UIColor clearColor]];
}

#pragma mark - RootController

+ (void)setRootViewController
{
    
//    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
//    NSString *bundleVersion = info[@"CFBundleShortVersionString"];
//    NSString *currentVersion = [RBPersistence simpleReadObjectWithKey:RB_VERSION_KEY];
//
    UIWindow *keyWindow = [self keyWindow];
//    BOOL avaliableAccountAndPassword = NO;
//
//    if (avaliableAccountAndPassword)
//    {//1.有用户名密码,载入页发请求登录
//        keyWindow.rootViewController = [GXLoadingViewController new];
        __weak typeof(keyWindow) weakKeyWindow = keyWindow;
//        [[GXSignInManager new] signInWithCompletionHandler:^(BOOL success) {
//            if (success)
//            {//1.1登录成功,进入tabbar页
                weakKeyWindow.rootViewController = [self tabbarViewController];
//            }else
//            {//1.2登录失败,进入signIn页
//                weakKeyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[GXSignInViewController new]];
//            }
//        }];
//    }else
//    {//2.无用户名密码,进入signIn页
//        keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[RBSignInVC new]];
//    }
    
    BOOL showFeatureView = NO;
    if (showFeatureView/**[bundleVersion compare:currentVersion] == NSOrderedDescending*/)
    {//1.新版本,加新特性界面遮罩
        RBFeatureView *featureView = [[RBFeatureView alloc] initWithFrame:kRBMainScreenBounds];
        [keyWindow addSubview:featureView];
    }else
    {//2.无更新
        
    }
    
}

+ (UIViewController *)tabbarViewController
{
    RBTabBarController *tabBarController = [RBTabBarController new];
    [tabBarController setViewControllers:
     @[[self controllerWithClass:[STDiscoveryVC class] title:@"发现"],
       [self controllerWithClass:[STMessageVC class] title:@"消息"],
       [self controllerWithClass:[STAccountVC class] title:@"账户"]
       ]];
    
    [tabBarController setTabBarButtons:
     @[
       [self buttonWithTitle:@"发现" normalImage:[UIImage imageNamed:@"shouye_nor"] selectedImage:[UIImage imageNamed:@"shouye_pre"] buttonClass: [RBTabBarButton class]],
       [self buttonWithTitle:@"消息" normalImage:[UIImage imageNamed:@"mail_nor"] selectedImage:[UIImage imageNamed:@"mail_pre"] buttonClass: [RBTabBarButton class]],
       [self buttonWithTitle:@"账户" normalImage:[UIImage imageNamed:@"geren_nor"] selectedImage:[UIImage imageNamed:@"geren_pre"] buttonClass: [RBTabBarButton class]],
       ]withIndexesOfViewController:
     @[@0, @1, @2]
              proportionsOfTabBarWidth:
     @[@0.33, @0.34, @0.33]];
    
    tabBarController.autoSelectVC = NO;
    tabBarController.tabBarButtonTappedBlock = ^(RBTabBarController * _Nullable controller, UIButton *_Nullable button, NSInteger currentIndex, NSInteger fromIndex){
        if (fromIndex == currentIndex)
        {
            
        }else if((currentIndex == 1 || currentIndex == 2) && ![RBSignInManager manager].accountAvailable)
        {
            UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:[RBSignInVC new]];
            [controller presentViewController:navigationVC animated:YES completion:nil];
        }else
        {
            controller.selectedTabBarButtonIndex = currentIndex;
        }
    };
    
    return tabBarController;
}

+ (UIWindow *)keyWindow
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    NSAssert(window , @"Something is wrong, check it out");
    return window;
}

+ (UINavigationController *)controllerWithClass: (Class)controllerClass title: (NSString *)title
{
    UIViewController *controller = [controllerClass new];
    controller.title = title;
    return [[UINavigationController alloc] initWithRootViewController:controller];
}

+ (UIButton *)buttonWithTitle: (NSString *)title normalImage: (UIImage *)normalImage selectedImage: (UIImage *)selectedImage buttonClass: (Class)buttonClass
{
    UIColor *normalColor = [UIColor blackColor];
    UIColor *selectedColor = [UIColor orangeColor];
    UIButton *button = [buttonClass new];
    button.titleLabel.font = [RBThemeConfig tabBarTextFont];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    [button setTitleColor:selectedColor forState:UIControlStateHighlighted | UIControlStateSelected];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button setImage:selectedImage forState:UIControlStateHighlighted | UIControlStateSelected];
    return button;
}

@end
