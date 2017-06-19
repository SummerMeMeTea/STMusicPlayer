//
//  UIView+RBAdd.m
//  GXSign
//
//  Created by 蓝其 on 16/11/15.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "UIView+RBAdd.h"

@implementation UIView(RBAdd)

- (void)setRbX:(CGFloat)rbX
{
    CGRect frame = self.frame;
    frame.origin.x = rbX;
    self.frame = frame;
}

- (CGFloat)rbX
{
    return self.frame.origin.x;
}

- (void)setRbY:(CGFloat)rbY
{
    CGRect frame = self.frame;
    frame.origin.y = rbY;
    self.frame = frame;
}

- (CGFloat)rbY
{
    return self.frame.origin.y;
}

- (void)setRbCenterX:(CGFloat)rbCenterX
{
    CGPoint center = self.center;
    center.x = rbCenterX;
    self.center = center;
}

- (CGFloat)rbCenterX
{
    return self.center.x;
}

- (void)setRbCenterY:(CGFloat)rbCenterY
{
    CGPoint center = self.center;
    center.y = rbCenterY;
    self.center = center;
}

- (CGFloat)rbCenterY
{
    return self.center.y;
}

- (void)setRbWidth:(CGFloat)rbWidth
{
    CGRect frame = self.frame;
    frame.size.width = rbWidth;
    self.frame = frame;
}

- (CGFloat)rbWidth
{
    return self.frame.size.width;
}

- (void)setRbHeight:(CGFloat)rbHeight
{
    CGRect frame = self.frame;
    frame.size.height = rbHeight;
    self.frame = frame;
}

- (CGFloat)rbHeight
{
    return self.frame.size.height;
}

- (void)setRbSize:(CGSize)rbSize
{
    CGRect frame = self.frame;
    frame.size =rbSize;
    self.frame = frame;
}

- (CGSize)rbSize
{
    return self.frame.size;
}

- (void)setRbOrign:(CGPoint)rbOrign
{
    CGRect frame = self.frame;
    frame.origin = rbOrign;
    self.frame = frame;
}

- (CGPoint)rbOrign
{
    return self.frame.origin;
}

@end
