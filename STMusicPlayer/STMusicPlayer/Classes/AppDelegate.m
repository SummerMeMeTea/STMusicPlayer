//
//  AppDelegate.m
//  STMusicPlayer
//
//  Created by Lan on 2017/6/15.
//  Copyright © 2017年 SummerMeMeTea. All rights reserved.
//

#import "AppDelegate.h"
#if DEBUG
#import "FLEX.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
//#if DEBUG
//    [[FLEXManager sharedManager] showExplorer];
//#endif
    //转移了非必要代码到RBAppdelegateHelper
    return YES;
}

@end
