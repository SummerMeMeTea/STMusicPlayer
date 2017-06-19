//
//  UIImage+RBAdd.m
//  GXSign
//
//  Created by 蓝其 on 16/11/14.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "UIImage+RBAdd.h"

@implementation UIImage(RBAdd)

+ (UIImage *)rbImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
