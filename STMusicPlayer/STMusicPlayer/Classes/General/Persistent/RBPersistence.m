//
//  GXPersistent.m
//  GXSign
//
//  Created by 蓝其 on 16/11/15.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "RBPersistence.h"

@implementation RBPersistence

+ (void)simpleSaveObject:(id)object withKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)simpleReadObjectWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)securitySaveObject:(id)object withKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)securityReadObjectWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
