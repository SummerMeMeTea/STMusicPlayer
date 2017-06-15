//
//  ViewController.m
//  STMusicPlayer
//
//  Created by Lan on 2017/6/15.
//  Copyright © 2017年 SummerMeMeTea. All rights reserved.
//

#import "ViewController.h"
#import <FreeStreamer/FSAudioStream.h>

@interface ViewController ()

@property(nonatomic, strong) FSAudioStream *audioStream;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

//改变播放位置 progress:0(开始)-1(结尾)
- (void)seekWithValue: (CGFloat)progress
{
    int seconds = progress * self.audioStream.duration.playbackTimeInSeconds;
    int min = seconds/60;
    int second = seconds%60;
    FSStreamPosition position = {min,second, seconds, progress};
    [self.audioStream seekToPosition: position];
}

//播放/暂停
- (void)playOrPause:(UIButton *)button
{
    if (self.audioStream.isPlaying) {
        [self.audioStream pause];
    }else{
        [self.audioStream pause];
    }
}

//音频地址
-(NSURL *)getFileUrl
{
    return [NSURL URLWithString:@"http://audio.xmcdn.com/group15/M00/6B/FA/wKgDZVc6yBCjkn7AACdnGevNZjg091.mp3"];
}

//播放器
-(FSAudioStream *)audioStream
{
    if (!_audioStream)
    {
        _audioStream=[[FSAudioStream alloc]initWithUrl:[self getFileUrl]];
        _audioStream.onFailure=^(FSAudioStreamError error,NSString *description){
            NSLog(@"播放过程中发生错误，错误信息：%@",description);
        };
        _audioStream.onCompletion=^(){
            NSLog(@"播放完成!");
        };
    }
    return _audioStream;
}

@end

/*
 音频资源
 1
 http://audio.xmcdn.com/group15/M00/6B/FA/wKgDZVc6yBCjkn7AACdnGevNZjg091.mp3
 2
 http://audio.xmcdn.com/group15/M00/6B/FB/wKgDZVc6yB2RI6FVAPXqCmNNdW0231.mp3
 3
 http://audio.xmcdn.com/group16/M01/6D/9C/wKgDbFc6yAbCHjAUAPMa2x90urI376.mp3
 4
 http://audio.xmcdn.com/group16/M01/6D/88/wKgDalc6x_CSjJyWANvW9DlLtFs823.mp3
 5
 http://audio.xmcdn.com/group14/M00/6E/9E/wKgDZFc6x9jyDFjrAOBM_s0iJcs464.mp3
 6
 http://audio.xmcdn.com/group8/M06/6D/3F/wKgDYFc6x92BuheGAN7fR2fER7U429.mp3
 7
 http://audio.xmcdn.com/group11/M02/78/61/wKgDbVc6x6XyAgKaAOZaYehLvRU118.mp3
 8
 http://audio.xmcdn.com/group13/M01/6D/D4/wKgDXVc6x37DFP-1ANuh5Dacrt4780.mp3
 9
 http://audio.xmcdn.com/group13/M01/6D/D4/wKgDXVc6x4Tx0gJfANu5kBxLUyo956.mp3
 */
