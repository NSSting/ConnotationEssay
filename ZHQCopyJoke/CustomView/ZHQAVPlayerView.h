//
//  ZHQAVPlayerView.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2018/1/5.
//  Copyright © 2018年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ZHQAVPlayerView : UIView

{
    AVPlayer *_player;
}
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, strong) UISlider *progressSlider;
@property (nonatomic, weak) NSTimer *playerTimer;
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) CGFloat fps;
@property (nonatomic, assign) CGFloat duration;

- (instancetype)initWithFrame:(CGRect)frame;
@end
