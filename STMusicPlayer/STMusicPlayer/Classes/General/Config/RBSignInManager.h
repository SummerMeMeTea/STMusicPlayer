//
//  RBSignInManager.h
//  Master
//
//  Created by Lan on 2017/6/2.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBSignInManager : NSObject

@property(nonatomic, assign) BOOL accountAvailable;

+ (instancetype)manager;

@end
