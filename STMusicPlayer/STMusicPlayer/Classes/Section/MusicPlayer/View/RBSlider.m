//
//  RBSlider.m
//  MP
//
//  Created by Lan on 2017/6/14.
//  Copyright © 2017年 None. All rights reserved.
//

#import "RBSlider.h"

@implementation RBSlider

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self moveWithValue:self.value];
}

- (void)setValue:(CGFloat)value
{
    _value = value;
    [self moveWithValue:self.value];
}

- (void)moveWithValue: (CGFloat)value
{
    CGFloat y = 0;
    CGFloat h = self.frame.size.height;
    CGFloat w = h;
    CGFloat x = (self.frame.size.width - w) * value;
    x = MIN(x, self.frame.size.width - w);
    x = MAX(x, 0);
    self.dragImgView.frame = CGRectMake(x, y, w, h);
}

- (UIImageView *)dragImgView
{
    if (!_dragImgView) {
        self.dragImgView = ({
            UIImageView *view = [UIImageView new];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 5;
            view.clipsToBounds = YES;
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
            [self addSubview:view];
            view;
        });
    }
    return _dragImgView;
}

- (void)pan: (UIPanGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateBegan)
    {
        if (self.beginDraggingBlock) {
            self.beginDraggingBlock();
        }
    }
    else if (ges.state == UIGestureRecognizerStateChanged)
    {
        CGFloat value = ([ges locationInView:self].x - self.frame.size.height/2)/(self.frame.size.width - self.frame.size.height);
        value = MAX(0, value);
        value = MIN(1, value);
        [self moveWithValue:value];
    }
    else if(ges.state == UIGestureRecognizerStateFailed || ges.state == UIGestureRecognizerStateCancelled || ges.state == UIGestureRecognizerStateEnded)
    {
        self.value = self.dragImgView.frame.origin.x/(self.frame.size.width - self.frame.size.height);
        if (self.endDraggingBlock) {
            self.endDraggingBlock(self.value);
        }
        NSLog(@"cancelled or end");
    }
    
}

@end
