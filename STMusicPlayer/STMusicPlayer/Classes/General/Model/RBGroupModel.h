//
//  RBGroupModel.h
//  Master
//
//  Created by Lan on 2017/6/6.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RBGroupModel : NSObject

/** 头部视图 */
@property(nonatomic, weak) UIView *headerView;
/** 头部高度 */
@property(nonatomic, assign) CGFloat headerHeight;
/** 给cell的RBCellModel模型 */
@property(nonatomic, strong) NSArray *cellModels;
/* 点击头部的回调 */
@property(nonatomic, copy)void(^headerSelectBlock)();

@end
