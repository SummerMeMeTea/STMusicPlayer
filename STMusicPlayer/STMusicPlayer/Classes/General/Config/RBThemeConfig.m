//
//  RBConfig.m
//  基本结构
//
//  Created by 蓝其 on 16/10/19.
//  Copyright © 2016年 蓝其. All rights reserved.
//

#import "RBThemeConfig.h"

@implementation RBThemeConfig

+ (UIFont *)tabBarTextFont
{
    return [UIFont systemFontOfSize:13];
}

+ (UIFont *)navigationBarTitleFont
{
    return [UIFont systemFontOfSize:17];
}

+ (UIFont *)navigationItemFont
{
    return [UIFont systemFontOfSize:15];
}

+ (UIColor *)themeColor
{
    return [self redColor];
}

+ (UIColor *)lightGrayColor
{
    return [UIColor colorWithWhite:0.9 alpha:1];
}

+ (UIColor *)orangeColor
{
    return [UIColor orangeColor];
}

+ (UIColor *)redColor
{
    return [UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1];
}

+ (UIColor *)blackColor
{
    return [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
}

@end
