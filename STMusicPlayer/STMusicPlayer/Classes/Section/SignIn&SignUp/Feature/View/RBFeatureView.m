//
//  GXGeatureView.m
//  GXSign
//
//  Created by 蓝其 on 16/11/17.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "RBFeatureView.h"
#import "RBDefine.h"
#import "UIView+RBAdd.h"
#import "Masonry.h"

@interface RBFeatureView ()<UIScrollViewDelegate>

@property(nonatomic, strong)NSMutableArray *dataSource;
@property(nonatomic, strong)UIScrollView *scrollView;

@end

@implementation RBFeatureView

#pragma mark - System

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.rbWidth * (self.dataSource.count + 1), self.scrollView.rbHeight);
    for (UIImageView *imgView in self.scrollView.subviews)
    {
        if ([imgView isKindOfClass:[UIImageView class]])
        {
            imgView.frame = CGRectMake(self.scrollView.rbWidth * imgView.tag, 0, self.scrollView.rbWidth, self.scrollView.rbHeight);
        }
    }
}

#pragma mark - Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > self.scrollView.rbWidth * (self.dataSource.count - 1)) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [self dismiss];
        }];
    }
}

#pragma mark - Private

- (void)dismiss
{
    [self removeFromSuperview];
}

#pragma mark - Getter

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        self.scrollView = ({
            UIScrollView *scrollView = [UIScrollView new];
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.delegate = self;
            scrollView.bounces = NO;
            scrollView.pagingEnabled = YES;
            for (int i = 0; i < self.dataSource.count; i++) {
                UIImage *image = self.dataSource[i];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                imageView.tag = i;
                [scrollView addSubview:imageView];
                UIPageControl *pageControl = [UIPageControl new];
                pageControl.numberOfPages = self.dataSource.count;
                pageControl.currentPage = i;
                pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.95 alpha:1];
                pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
                [imageView addSubview:pageControl];
                [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_equalTo(0);
                    make.bottom.mas_equalTo(-5);
                }];
            }
            [self addSubview:scrollView];
            scrollView;
        });
    }
    return _scrollView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = ({
            NSMutableArray *array = [NSMutableArray array];
            [array addObject:[UIImage imageNamed:@"feature_0.jpeg"]];
            [array addObject:[UIImage imageNamed:@"feature_1.jpeg"]];
            [array addObject:[UIImage imageNamed:@"feature_2.jpeg"]];
            [array addObject:[UIImage imageNamed:@"feature_3.jpeg"]];
            array;
        });
    }
    return _dataSource;
}

@end
