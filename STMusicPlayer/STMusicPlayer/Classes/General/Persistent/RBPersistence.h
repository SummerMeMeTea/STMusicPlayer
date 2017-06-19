//
//  GXPersistent.h
//  GXSign
//
//  Created by 蓝其 on 16/11/15.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBPersistence : NSObject

/* 暂存偏好,有需求可更改 */
+ (void)simpleSaveObject: (id)object withKey: (NSString *)key;
+ (id)simpleReadObjectWithKey: (NSString *)key;

/* 加密存储,暂留 */
+ (void)securitySaveObject: (id)object withKey: (NSString *)key;
+ (id)securityReadObjectWithKey: (NSString *)key;


@end
