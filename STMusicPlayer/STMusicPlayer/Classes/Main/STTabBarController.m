//
//  STTabBarController.m
//  STMusicPlayer
//
//  Created by Nie on 2017/6/15.
//  Copyright © 2017年 SummerMeMeTea. All rights reserved.
//

#import "STTabBarController.h"
#import "STNavigationController.h"

static NSString * const DiscoverMusicVC = @"STDiscoverMusicViewController";
static NSString * const MyMusicVC = @"STMyMusicViewController";
static NSString * const FriendVC = @"STFriendViewController";
static NSString * const AccountVC = @"STAccountViewController";

static NSString * const TabbarTitle = @"TabbarTitle";
static NSString * const TabbarImage = @"TabbarImage";
static NSString * const TabbarSelectedImage = @"TabbarSelectedImage";
static NSString * const TabbarItemBadgeValue = @"TabbarItemBadgeValue";

@interface STTabBarController ()

@property (nonatomic, strong) NSArray *vcsOrder;
@property (nonatomic, strong) NSDictionary *vcsInfoDict;

@end

@implementation STTabBarController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubVCs];
}

#pragma mark - setupSubVCs

- (void)setupSubVCs {
    
    [self.vcsOrder enumerateObjectsUsingBlock:^(id  _Nonnull vcName, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *vcInfo = [self.vcsInfoDict objectForKey:vcName];
        
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [clazz new];
        vc.title = vcInfo[TabbarTitle];
        vc.tabBarItem.image = [[UIImage imageNamed:vcInfo[TabbarImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        UIImage *selectedImage = [[UIImage imageNamed:vcInfo[TabbarSelectedImage]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = selectedImage;
        
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#9b9db1"],
                                                NSFontAttributeName : [UIFont systemFontOfSize:12]}
                                     forState:UIControlStateNormal];
        
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}
                                     forState:UIControlStateSelected];
        //        NSInteger badge = [vcInfo[TabbarItemBadgeValue] integerValue];
        
        STNavigationController *nav = [[STNavigationController alloc] initWithRootViewController:vc];
        //        nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)badge];
        [self addChildViewController:nav];
    }];
}

#pragma getters / setters

- (NSArray *)vcsOrder {
    
    return @[DiscoverMusicVC,MyMusicVC,FriendVC,AccountVC];
}

- (NSDictionary *)vcsInfoDict {
    
    return @{DiscoverMusicVC : @{
                     TabbarTitle        : @"发现音乐",
                     TabbarImage        : @"shouye_nor",
                     TabbarSelectedImage: @"shouye_pre",
                     TabbarItemBadgeValue: @(0)
                     },
              MyMusicVC : @{
                     TabbarTitle        : @"我的音乐",
                     TabbarImage        : @"shouye_nor",
                     TabbarSelectedImage: @"shouye_pre",
                     TabbarItemBadgeValue: @(0)
                     },
             FriendVC : @{
                     TabbarTitle        : @"朋友",
                     TabbarImage        : @"mail_nor",
                     TabbarSelectedImage: @"mail_pre",
                     TabbarItemBadgeValue: @(0)
                     },
             
             AccountVC : @{
                     TabbarTitle        : @"账号",
                     TabbarImage        : @"geren_nor",
                     TabbarSelectedImage: @"geren_pre",
                     TabbarItemBadgeValue: @(0)
                     }};
}

@end
