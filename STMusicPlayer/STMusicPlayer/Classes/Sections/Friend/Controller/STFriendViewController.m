//
//  FriendViewController.m
//  STMusicPlayer
//
//  Created by Nie on 2017/6/15.
//  Copyright © 2017年 SummerMeMeTea. All rights reserved.
//

#import "STFriendViewController.h"

@interface STFriendViewController ()

@end

@implementation STFriendViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavbar];
    [self setupSubviews];
    [self fetchData];
}

#pragma mark - Setup navbar

- (void)setupNavbar {
    
}

#pragma mark - Setup subViews

- (void)setupSubviews {
    self.view.backgroundColor = [UIColor ms_backgroundColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"朋友";
    label.textColor = [UIColor ms_blackColor];
    label.font = [UIFont systemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor randomColor];
    
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
}

#pragma mark - Layout

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
}

#pragma mark - Fetch data

- (void)fetchData {
    
}

#pragma mark - Event Handler

#pragma mark - Getter


@end