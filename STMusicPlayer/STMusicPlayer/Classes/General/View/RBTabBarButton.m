//
//  RBTabbarButton.m
//  基本结构
//
//  Created by 蓝其 on 16/10/19.
//  Copyright © 2016年 蓝其. All rights reserved.
//

#import "RBTabBarButton.h"

@implementation RBTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat totalWidth = contentRect.size.width;
    CGFloat totalHeight = contentRect.size.height;
    CGFloat y = totalHeight * 0.65;
    CGFloat height = totalHeight * 0.2;
    CGFloat width = totalWidth;;
    CGFloat x = 0;;
    return CGRectMake(x, y, width, height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat totalWidth = contentRect.size.width;
    CGFloat totalHeight = contentRect.size.height;
    CGFloat y = totalHeight * 0.15;
    CGFloat height = totalHeight * 0.4;
    CGFloat width = height;
    CGFloat x = (totalWidth - width) / 2;
    return CGRectMake(x, y, width, height);
}

/*
 0.15
 图 0.4
 0.1
 字 0.2
 0.15
 */

@end
