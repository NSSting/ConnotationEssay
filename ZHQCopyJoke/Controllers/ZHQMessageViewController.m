//
//  ZHQMessageViewController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/24.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQMessageViewController.h"
#import "ZHQCheckViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ZHQAVPlayerView.h"
@interface ZHQMessageViewController ()<UIGestureRecognizerDelegate>



@end

@implementation ZHQMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    ZHQAVPlayerView *playView =[[ZHQAVPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    playView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:playView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
