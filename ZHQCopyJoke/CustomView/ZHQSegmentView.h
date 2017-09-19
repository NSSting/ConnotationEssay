//
//  ZHQSegmentView.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/25.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHQSegmentView : UIView

@property (nonatomic, copy)void (^segmentItemClickedBlock)(ZHQSegmentView *segmentView, UIButton *btn);
//自定义初始化类型
- (instancetype)initWithItemTitles:(NSArray *)itemTitles;

@end
