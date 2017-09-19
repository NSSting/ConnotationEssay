//
//  ZHQHeaderItemView.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/28.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHQHeaderItemView : UILabel

/** 填充色，从左开始*/
@property (nonatomic, strong) UIColor *fillColor;
/** 滑动进度*/
@property (nonatomic, assign) CGFloat progress;

@end
