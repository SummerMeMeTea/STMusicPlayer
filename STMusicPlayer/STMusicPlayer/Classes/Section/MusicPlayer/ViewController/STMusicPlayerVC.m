//
//  STMusicPlayerVC.m
//  STMusicPlayer
//
//  Created by Lan on 2017/6/19.
//  Copyright © 2017年 SummerMeMeTea. All rights reserved.


#import "STMusicPlayerVC.h"
#import <FreeStreamer/FSAudioController.h>
#import <FreeStreamer/FSAudioStream.h>
#import <FreeStreamer/FSPlaylistItem.h>
#import "RBSlider.h"
#import <Masonry/Masonry.h>
#import "RBThemeConfig.h"

@interface STMusicPlayerVC ()

@property(nonatomic, strong) FSAudioController *audioController;
@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong) UILabel *currentTimeLabel; /**<当前播放时间*/
@property(nonatomic, strong) UILabel *totalTimeLabel;   /**<音频总时长*/
@property(nonatomic, strong) RBSlider *playSlider;      /**<播放进度条*/
@property(nonatomic, strong) UIButton *previousButton;  /**<上一首*/
@property(nonatomic, strong) UIButton *nextButton;      /**<下一首*/
@property(nonatomic, strong) UIButton *playButton;      /**<播放键*/
@property(nonatomic, strong) UIImageView *coverView;    /**<封面图*/

@end

@implementation STMusicPlayerVC

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - Public

static id instance;
+ (instancetype)controller
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (void)playWithList:(NSArray *)list index:(NSInteger)index
{
    if ([list[index][@"url"] isEqualToString:self.audioController.currentPlaylistItem.url.absoluteString])
    {
        return;
    }
    [self.audioController playFromPlaylist:({
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:list.count];
        FSPlaylistItem *item;
        for (NSDictionary *dic in list)
        {
            item = [[FSPlaylistItem alloc] init];
            item.title = dic[@"name"];
            item.url = [NSURL URLWithString:dic[@"url"]];
            [arrayM addObject:item];
        }
        arrayM;
    }) itemIndex:index];
    self.title = list[index][@"name"];
}

#pragma mark - Private

- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [RBThemeConfig redColor];
    self.previousButton.hidden = NO;
    self.nextButton.hidden = NO;
    self.playButton.hidden = NO;
    self.currentTimeLabel.hidden = NO;
    self.totalTimeLabel.hidden = NO;
    self.playSlider.hidden = NO;
    self.coverView.hidden = NO;
    [self.timer fire];
}

- (void)seekToPosition: (CGFloat)progress
{
    FSStreamPosition position = {0,0, 0, progress};
    [self.audioController.activeStream seekToPosition:position];
}

- (NSString *)timeStringFromSteamPosition: (FSStreamPosition)position
{
    return [NSString stringWithFormat:@"%02zd:%02zd", position.minute, position.second];
}

#pragma mark - Event

- (void)previoudSong: (UIButton *)button
{
    if ([self.audioController hasPreviousItem])
    {
        [self.audioController playPreviousItem];
    }
}

- (void)nextSong: (UIButton *)button
{
    if ([self.audioController hasNextItem])
    {
        [self.audioController playNextItem];
    }
}

- (void)playOrPause: (UIButton *)button
{
    [self.audioController pause];
}

- (void)timerEvent
{
    self.title = self.audioController.currentPlaylistItem.title;
    self.currentTimeLabel.text = [self timeStringFromSteamPosition:self.audioController.activeStream.currentTimePlayed];
    self.totalTimeLabel.text = [self timeStringFromSteamPosition:self.audioController.activeStream.duration];
    self.playSlider.value = self.audioController.activeStream.currentTimePlayed.position;
    if (self.audioController.isPlaying)
    {
        [self.playButton setTitle:@"PAUSE" forState:UIControlStateNormal];
    }else
    {
        [self.playButton setTitle:@"PLAY" forState:UIControlStateNormal];
    }
}

#pragma mark - Getter

- (FSAudioController *)audioController
{
    if (!_audioController) {
        self.audioController = ({
            FSAudioController *controller = [[FSAudioController alloc] init];
            controller.onStateChange = ^(FSAudioStreamState state) {
                if (state == kFSAudioStreamEndOfFile)
                {
                }
            };
            controller.onFailure = ^(FSAudioStreamError error, NSString *errorDescription) {
                NSLog(@"playError:%@", errorDescription);
            };
            controller;
        });
    }
    return _audioController;
}

- (NSTimer *)timer
{
    if (!_timer) {
        self.timer = ({
            __weak typeof(self) weak_self = self;
            NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:0.2] interval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [weak_self timerEvent];
            }];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            timer;
        });
    }
    return _timer;
}

- (UILabel *)currentTimeLabel
{
    if (!_currentTimeLabel) {
        self.currentTimeLabel = ({
            self.currentTimeLabel = ({
                UILabel *label = [UILabel new];
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentLeft;
                label.text = @"00:00";
                label.adjustsFontSizeToFitWidth = YES;
                [self.view addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10);
                    make.height.mas_equalTo(20);
                    make.bottom.mas_equalTo(self.playButton.mas_top).offset(-15);
                    make.width.mas_equalTo(60);
                }];
                label;
            });
        });
    }
    return _currentTimeLabel;
}

- (UILabel *)totalTimeLabel
{
    if (!_totalTimeLabel) {
        self.totalTimeLabel = ({
            UILabel *label = [UILabel new];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12];
            label.adjustsFontSizeToFitWidth = YES;
            label.textAlignment = NSTextAlignmentRight;
            label.adjustsFontSizeToFitWidth = YES;
            label.text = @"00:00";
            [self.view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.height.bottom.width.mas_equalTo(self.currentTimeLabel);
            }];
            label;
        });
    }
    return _totalTimeLabel;
}

- (RBSlider *)playSlider
{
    if (!_playSlider) {
        self.playSlider = ({
            RBSlider *slider = [RBSlider new];
            slider.backgroundColor = [UIColor clearColor];
            slider.layer.cornerRadius = 5;
            slider.clipsToBounds = YES;
            slider.layer.borderColor = [UIColor whiteColor].CGColor;
            slider.layer.borderWidth = 1;
            slider.value = 0;
            __weak typeof(self) weak_self = self;
            slider.beginDraggingBlock = ^{
                weak_self.timer.fireDate = [NSDate distantFuture];
            };
            slider.endDraggingBlock = ^(CGFloat value){
                [weak_self seekToPosition:value];
                weak_self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.2];
            };
            [self.view addSubview:slider];
            [slider mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.currentTimeLabel.mas_right);
                make.right.mas_equalTo(self.totalTimeLabel.mas_left);
                make.height.bottom.mas_equalTo(self.currentTimeLabel);
            }];
            slider;
        });
    }
    return _playSlider;
}

- (UIButton *)previousButton
{
    if (!_previousButton) {
        self.previousButton = ({
            UIButton *btn = [UIButton new];
            [btn setTitle:@"<" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.showsTouchWhenHighlighted = YES;
            [btn addTarget:self action:@selector(previoudSong:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(self.playButton);
                make.bottom.mas_equalTo(self.playButton);
                make.right.mas_equalTo(self.playButton.mas_left).offset(-20);
            }];
            btn;
        });
    }
    return _previousButton;
}

- (UIButton *)nextButton
{
    if (!_nextButton) {
        self.nextButton = ({
            UIButton *btn = [UIButton new];
            [btn setTitle:@">" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.showsTouchWhenHighlighted = YES;
            [btn addTarget:self action:@selector(nextSong:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(self.playButton);
                make.bottom.mas_equalTo(self.playButton);
                make.left.mas_equalTo(self.playButton.mas_right).offset(20);
            }];
            btn;
        });
    }
    return _nextButton;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        self.playButton = ({
            UIButton *btn = [UIButton new];
            [btn setTitle:@"PAUSE" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.showsTouchWhenHighlighted = YES;
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [btn addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(44);
                make.bottom.mas_equalTo(0);
                make.centerX.mas_equalTo(btn.superview);
            }];
            btn;
        });
    }
    return _playButton;
}

- (UIImageView *)coverView
{
    if (!_coverView) {
        self.coverView = ({
            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feature_0.jpeg"]];
            view.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(0);
                make.bottom.mas_equalTo(self.playSlider.mas_top);
            }];
            view;
        });
    }
    return _coverView;
}

@end
