//
//  ZHQAVPlayerView.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2018/1/5.
//  Copyright © 2018年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQAVPlayerView.h"
@interface ZHQAVPlayerView() <UIGestureRecognizerDelegate>

@end

@implementation ZHQAVPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self videoplayer:frame];
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
    self.tap.delegate = self;
    [self addSubview:self.progressSlider];
    self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    return self;
}
-(void)videoplayer:(CGRect )frame
{
    // 1、获取媒体资源地址
    NSString *videoStr = @"http://ic.snssdk.com/neihan/video/playback/?video_id=f58a655b49f642fbb05b4ec603e9b9ec&quality=480p&line=0&is_gif=0&device_platform=.mp4";
    NSURL *videoUrl = [NSURL URLWithString:videoStr];
    
    // 2、创建AVPlayerItem
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    
    // 3、根据AVPlayerItem创建媒体播放器
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    // 4、创建AVPlayerLayer，用于呈现视频
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    // 5、设置显示大小和位置
    playerLayer.frame = CGRectMake(PADDING_OF_LEFT_RIGHT, PADDING_OF_LEFT_RIGHT, frame.size.width, 300);
    // 6、设置拉伸模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 7、获取播放持续时间
    [self.layer addSublayer:playerLayer];
    self.isPlay = NO;
    [self addSubview:self.playBtn];
    //帧率
    self.fps = [[[playerItem.asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] nominalFrameRate];
    self.duration = CMTimeGetSeconds(playerItem.asset.duration);//总帧长
    
    //注册通知
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

//视频播放结束通知监听事件
- (void)runLoopTheMovie:(NSNotification *)videoNotification{
    //注册的通知  可以自动把 AVPlayerItem 对象传过来，只要接收一下就OK
    AVPlayerItem * item = [videoNotification object];
    //关键代码
    [item seekToTime:kCMTimeZero];
    self.isPlay = NO;
}
//进度条进度监测
- (void)timer
{
    self.progressSlider.value = CMTimeGetSeconds(_player.currentTime)/CMTimeGetSeconds(_player.currentItem.asset.duration);
}
//滑动条点击事件监听
- (void)tapEvent:(UITapGestureRecognizer *)tapGester
{
    CGPoint touchPoint = [tapGester locationInView:_progressSlider];
    CGFloat value = touchPoint.x/CGRectGetWidth(self.progressSlider.frame);
    [_progressSlider setValue:value animated:YES];
    if(self.isPlay){
        [_player pause];
    }
    CMTime time = CMTimeMakeWithSeconds(self.duration *value,self.fps);
    [_player seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        if(self.isPlay){
            [_player play];
        }
    }];
}
//滑动滑动条监听事件
- (void)sliderChange
{
    CMTime time = CMTimeMakeWithSeconds(self.duration * _progressSlider.value, self.fps);
    [_player seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
}
//暂停和播放
- (void)videoPlay
{
    self.isPlay  = !self.isPlay;
    if (self.isPlay) {
        [self.playBtn setImage:[UIImage imageNamed:@"stop_btn"] forState:UIControlStateNormal];
        [_player play];
    } else {
        [self.playBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
        [_player pause];
    }
}
- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.center = CGPointMake(SCREEN_WIDTH/2, 150);
        _playBtn.bounds = CGRectMake(0, 0, 100, 60);
        [_playBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(videoPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
- (UISlider *)progressSlider
{
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc]initWithFrame:CGRectMake(PADDING_OF_LEFT_RIGHT,350 , SCREEN_WIDTH - PADDING_OF_LEFT_RIGHT *2, 15)];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"slider_dian"] forState:UIControlStateNormal];
        _progressSlider.tintColor = COLOR_APP_RED;
        [_progressSlider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
        [_progressSlider addGestureRecognizer:self.tap];
    }
    return _progressSlider;
}

- (void)dealloc
{
    [_playerTimer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _player = nil;
    //    _player.currentItem.asset.cancelLoading();
    //    _player.currentItem.cancelPendingSeeks();
}

@end
