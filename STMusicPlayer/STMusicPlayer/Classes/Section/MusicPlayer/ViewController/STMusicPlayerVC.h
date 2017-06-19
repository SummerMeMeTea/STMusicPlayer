//
//  STMusicPlayerVC.h
//  STMusicPlayer
//
//  Created by Lan on 2017/6/19.
//  Copyright © 2017年 SummerMeMeTea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STMusicPlayerVC : UIViewController

+ (instancetype)controller;
- (void)playWithList: (NSArray *)list index: (NSInteger)index;

@end
