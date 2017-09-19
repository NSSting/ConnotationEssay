//
//  ZHQAVPlayerManager.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/5.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQAVPlayerManager.h"
#import "ZHQCustomDisplayView.h"

@implementation ZHQAVPlayerManager
- (instancetype)initWithFrame:(CGRect)frame withUrl:(NSString *)url
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor brownColor];
        if (url != nil) {
            NSString * videoURLstr = [self StringIntoUtf8:url];
            if ([videoURLstr rangeOfString:@"http"].location != NSNotFound) {
                //播放远程视频
                self.item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:videoURLstr]];            }
            
        } else {
            AVAsset * avSet = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:url] options:nil];
            self.item = [[AVPlayerItem alloc]initWithAsset:avSet];
            
        }
        self.player = [[AVPlayer alloc]initWithPlayerItem:self.item];
        AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        layer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self AddObserverAVplayerSituation];
        /** 实时监听播放状态 */
        [self monitoringPlayersituation];
        /** 实时监听屏幕方向.. */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        [self setPlayer:self.player];
    }
    
    
    return self;
}

/** 播放监听 */
-(void)AddObserverAVplayerSituation
{    /** 监听status属性变化 */
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    /** 监听缓存量的变化 */
    [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    /** 注册监听，视屏播放完成 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xjPlayerEndPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.item];
    /** 视频播放被中断 */
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(moviePlayInterrupt:)
                                                name:AVPlayerItemPlaybackStalledNotification
                                              object:self.item];
    /** 当APP挂起状态时 播放器是否仍然继续播放 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    /** APP回到前台时，是否要做出改变 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
}
//实时监听播放状态
- (void)monitoringPlayersituation{
    //一秒监听一次CMTimeMake(a, b),a/b表示多少秒一次；
    WeakSelf(weakSelf);
    self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        //value/timescale = seconds
        
        CGFloat currentSecond = self.item.currentTime.value/self.item.currentTime.timescale;//获取当前时间
        ZHQCustomDisplayView * videoP = [ZHQCustomDisplayView new];
        videoP.SliderisDrag = ^(BOOL isdrag){
            if (isdrag) {//如果正在拖动
                return ;
            }else{
                if (weakSelf.currentTimeBlock) {//调用代码块 去让进度滑块移动
                    weakSelf.currentTimeBlock(currentSecond);
                }
            }
            
        };
        
    }];
}

#pragma mark - **************************** 监听事件 *************************************
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            
            NSLog(@"播放成功");
            
            _issuccess = YES;
            
            CMTime duration = self.item.duration;//获取视屏总长
            CGFloat totalSecond = CMTimeGetSeconds(duration);//转换成秒
            if (self.TotalTimeBlock) {
                /** 代码块传递出去视频总长度 */
                self.TotalTimeBlock(totalSecond);
            }
            if (self.PlaySuccessBlock) {
                /** 调用准备成功代码块 主要作用是 播放按钮点击时 做出相应的提示 */
                self.PlaySuccessBlock();
            }
            CGFloat currentSecond = self.item.currentTime.value/self.item.currentTime.timescale;//获取当前时间
            if (self.currentTimeBlock) {
                self.currentTimeBlock(currentSecond);
            }
            
            //            [self monitoringXjPlayerBack];//监听播放状态
            
        }else if (playerItem.status == AVPlayerItemStatusUnknown){
            NSLog(@"播放未知");
            _issuccess = NO;
            if (self.playFailBlock) {
                self.playFailBlock(@"播放未知");
            }
            
        }else if (playerItem.status == AVPlayerStatusFailed){
            NSLog(@"播放失败");
            _issuccess = NO;
            if (self.playFailBlock) {
                self.playFailBlock(@"播放失败");
            }
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        
        NSTimeInterval timeInterval = [self xjPlayerAvailableDuration];
        CMTime duration = self.item.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        if (self.cacheTimeBlock) {
            /** 传递给外部的是缓冲进度 */
            self.cacheTimeBlock(timeInterval/totalDuration);
        }
    }
    
}


#pragma mark  - action
/** 视频播放结束回调 */
-(void)xjPlayerEndPlay:(NSNotification *)sender
{
    if (self.playEndBlock) {
        self.playEndBlock();
    }
}
/** 视频播放被中断 */
-(void)moviePlayInterrupt:(NSNotification *)sender
{
    //avplayer自动保存了播放进度.
    NSLog(@"视频被打断了");
}
-(void)orientChange:(NSNotification*)sender
{
    UIDeviceOrientation orient = [[UIDevice currentDevice] orientation];
    if (self.OrientationChange) {
        /** 传递给外界 当前屏幕的方向 */
        self.OrientationChange(orient);
    }
    
}

/** 滑块移动 */
-(void)playerSeekToTimeWithSecond:(float)second
{
    //    WS(weakSelf);
    [self.player pause];
    [self.player seekToTime:CMTimeMakeWithSeconds(second, NSEC_PER_SEC)];
    //    [self.player seekToTime:CMTimeMakeWithSeconds(second, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
    //        [weakSelf.player play];
    //    }];
    
}
/** 计算缓存了多少 */
- (NSTimeInterval)xjPlayerAvailableDuration{
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];//获取缓冲区域
    CGFloat startSeconds = CMTimeGetSeconds(timeRange.start);
    CGFloat durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;//计算缓冲进度
    return result;
}
/** dealloc */
-(void)dealloc
{
    [self removeObserver:self.item forKeyPath:@"loadedTimeRanges"];
    [self removeObserver:self.item forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.playbackTimeObserver = nil;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)p {
    [(AVPlayerLayer *)[self layer] setPlayer:p];
}

- (void)setIsVideo:(BOOL)isVideo
{
    _isVideo = isVideo;
}

- (void)startPlay
{
    [self.player play];
}
- (void)endPlay
{
    [self.player pause];
}

#pragma mark - method
-(NSString *)StringIntoUtf8:(NSString *)oriStr
{
    NSString *resourceUrl ;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] <= 9.0) {
        resourceUrl = [oriStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        resourceUrl = [oriStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    }
    return resourceUrl;
}

@end
