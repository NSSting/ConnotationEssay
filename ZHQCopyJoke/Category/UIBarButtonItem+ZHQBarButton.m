//
//  UIBarButtonItem+ZHQBarButton.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/30.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "UIBarButtonItem+ZHQBarButton.h"

@implementation UIBarButtonItem (ZHQBarButton)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIView *bgView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, 60, 44)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.layer.masksToBounds = YES;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image]  forState:UIControlStateNormal];
    // 设置尺寸
    [bgView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:bgView];

}
@end
