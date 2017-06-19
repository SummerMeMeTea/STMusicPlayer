//
//  RBSlider.h
//  MP
//
//  Created by Lan on 2017/6/14.
//  Copyright © 2017年 None. All rights reserved.

/** 
 差一个播放进度条 一个预下载进度条
 */

#import <UIKit/UIKit.h>

@interface RBSlider : UIView

@property(nonatomic, assign) CGFloat value;
@property(nonatomic, strong) UIImageView *dragImgView;
@property(nonatomic, copy) void(^beginDraggingBlock)();
@property(nonatomic, copy) void(^endDraggingBlock)(CGFloat value);

@end
