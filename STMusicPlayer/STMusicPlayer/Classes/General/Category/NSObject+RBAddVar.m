//
//  NSObject+RBAddVar.m
//  GXSign
//
//  Created by 蓝其 on 16/11/14.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "NSObject+RBAddVar.h"
#import <objc/runtime.h>

@implementation NSObject(RBAddVar)

- (void)addVarWithKey:(NSString *)key value:(id)value policy:(RBAssociationPolicy)policy
{
    objc_setAssociatedObject(self, key.UTF8String, value, (objc_AssociationPolicy)policy);
}

- (id)getVarWithKey:(NSString *)key
{
    return objc_getAssociatedObject(self, key.UTF8String);
}

@end
