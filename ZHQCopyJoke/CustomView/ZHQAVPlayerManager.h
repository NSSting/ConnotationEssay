//
//  ZHQAVPlayerManager.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/5.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import "ZHQImageModel.h"

@interface ZHQAVPlayerManager : UIView

/** 界面更新时间ID */
@property (nonatomic, strong) id playbackTimeObserver;
@property (assign,nonatomic)BOOL            issuccess;

@property (nonatomic, assign)BOOL isVideo;
/** 准备播放 */
@property (nonatomic, copy)void (^PlaySuccessBlock)();
/** 提示播放失败的原因 */
@property (nonatomic, copy)void (^playFailBlock)(NSString * );

@property (nonatomic, strong) UIButton *playBtn;//播放按钮
//播放类
@property (nonatomic, strong) AVPlayer *player;
//控制类
@property (nonatomic, strong) AVPlayerItem *item;

/** 缓存的时间 */
@property (nonatomic, copy)void (^cacheTimeBlock)(CGFloat cachetime);
/** 当前播放的时间 */
@property (nonatomic, copy)void (^currentTimeBlock)(CGFloat currentTime);
/** 回调总时间 */
@property (nonatomic, copy)void (^TotalTimeBlock)(CGFloat totalTime);
/** 播放完成 */
@property (nonatomic, copy)void (^playEndBlock)();
/** 屏幕方向 */
@property (nonatomic, copy)void (^OrientationChange)(UIDeviceOrientation orient);

- (instancetype)initWithFrame:(CGRect )frame withUrl:(NSString *)url;

/**
 滑块拖动到多少秒
 
 @param second second即为slider.value;
 */
-(void)playerSeekToTimeWithSecond:(float)second;

- (void)startPlay;
- (void)endPlay;

@end
