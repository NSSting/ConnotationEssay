//
//  ZHQCustomDisplayView.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/4.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZHQCustomDisplayView : UIView

/**
 滑块是否移动...
 */
@property (copy,nonatomic)void(^SliderisDrag)(BOOL);

/**
 初始化视频播放器控件
 
 @param frame frame
 @param  videoURLstr sss
 @return 视图对象
 */
-(instancetype)initWithFrame:(CGRect)frame andvideoURLstr:(NSString*)videoURLstr;



@end
