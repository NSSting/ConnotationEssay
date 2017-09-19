//
//  ZHQBasicNavViewController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/25.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQBasicNavViewController.h"

@interface ZHQBasicNavViewController ()
@end

@implementation ZHQBasicNavViewController

//初始化样式
+(void)initialize
{
    [[UINavigationBar appearance]setTranslucent:NO];//顶部导航不透明
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]];
    //设置导航
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    [[UINavigationBar appearance]setTitleTextAttributes:dic];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    //hide back button title
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
