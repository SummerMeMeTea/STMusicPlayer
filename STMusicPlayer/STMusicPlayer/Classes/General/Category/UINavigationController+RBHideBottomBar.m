//
//  UINavigationController+hideBottomBar.m
//  基本结构
//
//  Created by 蓝其 on 16/10/19.
//  Copyright © 2016年 蓝其. All rights reserved.
//

#import "UINavigationController+RBHideBottomBar.h"
#import <objc/runtime.h>
#import "NSObject+RBAddVar.h"

@implementation UIViewController(RBHideBottomBar)


@end

@implementation UINavigationController(RBHideBottomBar)

+ (void)load
{
    Method original = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzled = class_getInstanceMethod([self class], @selector(swizzledPushViewController:animated:));
    method_exchangeImplementations(original, swizzled);
}

- (void)swizzledPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self swizzledPushViewController:viewController animated:animated];
}

@end
