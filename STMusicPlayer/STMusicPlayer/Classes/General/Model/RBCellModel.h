//
//  RBCellModel.h
//  Master
//
//  Created by Lan on 2017/6/1.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RBCellModel : NSObject

/* cell的重用标识符 */
@property(nonatomic, copy)NSString *reuseCellIdentifier;
/* 区别数据的类型标识符 */
@property(nonatomic, assign)NSInteger type;
/** cell高度 */
@property(nonatomic, assign) CGFloat cellHeight;
/** 供给cell的数据(可以选择用congfig类配置) */
@property(nonatomic, strong) id cellData;
/* 点击cell的回调 */
@property(nonatomic, copy)void(^cellSelectBlock)();

@end
