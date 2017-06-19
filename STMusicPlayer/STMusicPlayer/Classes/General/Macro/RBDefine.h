//
//  RBDefine.h
//  基本结构
//
//  Created by 蓝其 on 16/10/20.
//  Copyright © 2016年 蓝其. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRBMainScreenBounds [UIScreen mainScreen].bounds
#define kRBMainScreenSize kRBMainScreenBounds.size
#define kRBMainScreenWidth kRBMainScreenSize.width
#define kRBMainScreenHeight kRBMainScreenSize.height

#define kRBStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kRBNavigationBarHeight self.navigationController.navigationBar.bounds.size.height
#define kRBTabBarHeight self.tabBarController.tabBar.bounds.size.height

#define kRBFactor (kRBMainScreenWidth/320.0) //UI图调成640后统一对比

//结合navigationBar.translucent,决定在控制器中view的起点y
#define kRBViewYInController (self.navigationController.navigationBar.translucent? kRBStatusBarHeight + kRBNavigationBarHeight: 0)
//结合navigationBar.translucent,决定在控制器中view的起点height
#define kRBViewHeightInController (kRBMainScreenHeight - kRBStatusBarHeight - kRBNavigationBarHeight - kRBTabBarHeight)
//充满试图控制器的可见范围
#define kRBViewFrameFillInController CGRectMake(0, kRBViewYInController, kRBMainScreenWidth, kRBViewHeightInController)

#define kRBWeakSelf __weak typeof(self) weak_self = self;
#define kRBRemoveBackTitle self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

@interface RBDefine : NSObject

@end
