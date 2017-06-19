//
//  RBTextView.h
//  Master
//
//  Created by Lan on 2017/6/1.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBTextView : UIView

/** 
 /////写的不好，再说吧，不好用
 * 提供控件，不负责布局和样式
 * @width：左侧控件长度
 * @image & @title，二选一作为左侧内容，image优先级高
 * @placeHolder：占位文字
 */
+ (instancetype)textViewWithLeftWidth: (CGFloat)width padding: (CGFloat)padding image: (UIImage *)image title: (NSString *)title placeHolder: (NSString *)placeHolder;

/** textField必有值 imageView和label根据类方法实例化一个 暴露出来方便自定义 */
@property(nonatomic, weak, readonly) UITextField *textField;
@property(nonatomic, weak, readonly) UIImageView *imageView;
@property(nonatomic, weak, readonly) UILabel *label;

@end
