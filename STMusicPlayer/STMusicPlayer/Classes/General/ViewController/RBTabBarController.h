//
//  RBTabBarController.h
//  Base
//
//  Created by 蓝其 on 16/10/18.
//  Copyright © 2016年 蓝其. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBTabBarController : UITabBarController

#pragma mark 初始化

/**
 * 设置tabBar内容
 *
 * @indexes: 每个button对应一个需要切换的视图控制器序号,如果这个序号是NSNotFound,
 *           那么这个按钮点击后不会切换视图,需要在代理中自定义操作。
 *                  |---------------|
 *                  | 1  2  X  3  4 |
 *                  |---------------|
 *          比如：中间"X"按钮与众不同,点击后发起活动，就不需要设置切换视图控制器,
                 vc:@[vc1,vc2,vc3,vc4] indexes:@[@0,@1,@(NSNotFound),@2,@3]
 * @proportions: 按钮会按自左至右的顺序无缝隙平铺到tabBar上,高度为tabBar高度,宽度
 *               则为tabBar宽度 * proportion,
 *               如: @[@0.15, @0.15, @0.4, @0.15, @0.15],中间按钮比较宽
 * @buttons: 设置button在normal、selected以及normal | selected 3种状态下的参数,
 *           状态将自动与视图切换同步,如果button对应的切换视图序号为NSNotFound,默认只
 *           显示normal状态,需要在代理中自定义操作，比如变色，缩放,旋转之类的
 *
 */
- (void)setTabBarButtons: (NSArray<__kindof UIButton *> * _Nonnull)buttons withIndexesOfViewController: (NSArray<__kindof NSNumber *> * _Nonnull)indexes proportionsOfTabBarWidth: (NSArray<__kindof NSNumber *> * _Nonnull)proportions;

#pragma mark 扩展

/** 点按底部按钮 自动选择相应控制器，默认YES */
@property(nonatomic, assign) BOOL autoSelectVC;

/* 通过序号找到tabBar上对应按钮 */
- (UIButton * __nullable)tabBarButtonAtIndex: (NSInteger)index;

/* 通过序号获取tabBar上对应按钮的frame */
- (CGRect)frameForTabBarButtonAtIndex: (NSInteger)index;

/* 重新排列tabBar上按钮布局 */
- (void)layOutsubviewsOnTabBar;

/* 可以通过设置此参数,切换视图控制器,如果按钮没有对应控制器序号,只会block,
 并且也不记录为当前选中编号,如下,参数只可能取值:0,1,3,4
 |---------------|
 | 1  2  X  3  4 |
 |---------------|
 */
@property(nonatomic, assign)NSInteger selectedTabBarButtonIndex;

/**
 * tabBar上任一按钮被点击,都会触发
 * @button: 当前点击按钮
 * @currentIndex:  该按钮在tabBar中的序号(从左到右顺序)
 * @fromIndex: 上个被选中的按钮
 *
 */
@property(nonatomic, copy, nullable)void(^tabBarButtonTappedBlock)(RBTabBarController * _Nullable controller, UIButton *_Nullable button, NSInteger currentIndex, NSInteger fromIndex);

@end
