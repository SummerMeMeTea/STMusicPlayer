//
//  NSObject+RBAddVar.h
//  GXSign
//
//  Created by 蓝其 on 16/11/14.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef OBJC_ENUM(uintptr_t, RBAssociationPolicy)
{
  RB_ASSOCIATION_ASSIGN = 0,           /**< Specifies a weak reference to the associated object. */
  RB_ASSOCIATION_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object.
                                        *   The association is not made atomically. */
  RB_ASSOCIATION_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied.
                                        *   The association is not made atomically. */
  RB_ASSOCIATION_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
                                        *   The association is made atomically. */
  RB_ASSOCIATION_COPY
};

@interface NSObject(RBAddVar)

- (void)addVarWithKey: (NSString *)key value: (id)value policy: (RBAssociationPolicy)policy;
- (id)getVarWithKey: (NSString *)key;

@end
