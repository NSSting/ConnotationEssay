//
//  ZHQBasicTabBarController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/24.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQBasicTabBarController.h"
#import "ZHQHomeViewController.h"
#import "ZHQDiscoverViewController.h"
#import "ZHQCheckViewController.h"
#import "ZHQMessageViewController.h"
#import "ZHQBasicNavViewController.h"

@interface ZHQBasicTabBarController ()

@end

@implementation ZHQBasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance]setTranslucent:NO];//底部导航栏不透明
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
//    [[UINavigationBar appearance]setBarTintColor:[UIColor redColor]];//顶部导航背景色
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addChildViewControllerWithClassname:[ZHQHomeViewController description] imagename:@"home" title:@"首页"];
    [self addChildViewControllerWithClassname:[ZHQDiscoverViewController description] imagename:@"discover" title:@"发现"];
    [self addChildViewControllerWithClassname:[ZHQCheckViewController description] imagename:@"check" title:@"审核"];
    [self addChildViewControllerWithClassname:[ZHQMessageViewController description] imagename:@"message" title:@"消息"];
    
    //初始化请求
    ZHQBasicNavViewController *homeNav = (ZHQBasicNavViewController *)self.viewControllers.firstObject;
    
    
}

// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    ZHQBasicNavViewController *nav = [[ZHQBasicNavViewController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
