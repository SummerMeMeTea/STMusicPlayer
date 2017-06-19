//
//  RBSignInManager.m
//  Master
//
//  Created by Lan on 2017/6/2.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import "RBSignInManager.h"

@implementation RBSignInManager

id instance;
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

@end
