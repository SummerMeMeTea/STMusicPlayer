//
//  STNavigationController.m
//  STMusicPlayer
//
//  Created by Nie on 2017/6/15.
//  Copyright © 2017年 SummerMeMeTea. All rights reserved.
//

#import "STNavigationController.h"

@interface STNavigationController ()

@end

@implementation STNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


@end
