//
//  RBBinder.h
//  Master
//
//  Created by Lan on 2017/6/1.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIView;
@interface RBBinder : NSObject

+ (void)bindView: (UIView *)view withData: (NSObject *)data;

@end
