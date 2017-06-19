//
//  RBTextView.m
//  Master
//
//  Created by Lan on 2017/6/1.
//  Copyright © 2017年 LongCai. All rights reserved.
//

#import "RBTextView.h"
#import "Masonry.h"

@interface RBTextView()

@property(nonatomic, weak) UITextField *textField;
@property(nonatomic, weak) UIImageView *imageView;
@property(nonatomic, weak) UILabel *label;

@end

@implementation RBTextView

+ (instancetype)textViewWithLeftWidth: (CGFloat)width padding: (CGFloat)padding image: (UIImage *)image title: (NSString *)title placeHolder: (NSString *)placeHolder
{
    RBTextView *textView = [[RBTextView alloc] init];
    
    UIView *leftView = ({
        UIView *view;
        if (image)
        {
            view = [[UIImageView alloc] initWithImage:image];
        }else
        {
            view = [[UILabel alloc] init];
            ((UILabel *)view).text = title;
        }
        [textView addSubview:view];
        if (image)
        {
            textView.imageView = (UIImageView *)view;
        }else
        {
            textView.label = (UILabel *)view;
        }
        view;
    });
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(0);
        make.width.mas_equalTo(width);
    }];
    
    UITextField *textField = ({
        UITextField *field = [[UITextField alloc] init];
        field.backgroundColor = [UIColor whiteColor];
        field.placeholder = placeHolder;
        [textView addSubview:field];
        textView.textField = field;
        field;
    });
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(leftView.mas_right).offset(padding);
    }];
    
    return textView;
}

@end
