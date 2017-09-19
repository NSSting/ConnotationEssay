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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.layer.masksToBounds = YES;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image]  forState:UIControlStateNormal];
    // 设置尺寸
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

}
@end
