//
//  ZHQHeaderOptionView.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/28.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHQHeaderOptionView : UIView

/** 标题数组*/
@property (nonatomic, strong) NSArray <NSString *>*titles;
/** 点击item回调*/
@property (nonatomic, copy) void(^homeHeaderOptionalViewItemClickHandle)(ZHQHeaderOptionView *optialView, NSString *title, NSInteger currentIndex);
/** 偏移量*/
@property (nonatomic, assign) CGPoint contentOffset;

@end
