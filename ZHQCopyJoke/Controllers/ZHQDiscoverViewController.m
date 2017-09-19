//
//  ZHQDiscoverViewController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/24.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQDiscoverViewController.h"
#import "ZHQSegmentView.h"
#import "UIBarButtonItem+ZHQBarButton.h"
#import "ZHQDiscoverHotViewController.h"
#import "ZHQSubscribeViewController.h"

@interface ZHQDiscoverViewController ()
@property (nonatomic, strong) ZHQDiscoverHotViewController *hotVC;
@property (nonatomic, strong) ZHQSubscribeViewController *subVC;
@property (nonatomic,assign) NSInteger tag;
@end

@implementation ZHQDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tag = 1;
    [self.view addSubview:self.hotVC.view];
    [self setUpItems];
}

- (void)setUpItems
{
    

    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchBtnClicked) image:@"search_bar" highImage:@"search_bar"];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTarget:self action:@selector(locationBtnClicked) image:@"location_bar" highImage:@"location_bar"];
    self.navigationItem.rightBarButtonItem = rightItem;
    ZHQSegmentView *segment = [[ZHQSegmentView alloc]initWithItemTitles:@[@"热帖",@"关注"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 130, 40);
    WeakSelf(weakSelf);
    segment.segmentItemClickedBlock = ^(ZHQSegmentView *segmentView, UIButton *btn) {
        if (btn.tag != self.tag) {
            if (btn.tag == 1) {
                //精选
                [weakSelf.subVC.view removeFromSuperview];
                [weakSelf.view addSubview:weakSelf.hotVC.view];
            } else {
                [weakSelf.hotVC.view removeFromSuperview];
                [weakSelf.view addSubview:weakSelf.subVC.view];
            }
        }
        weakSelf.tag = btn.tag;
        
    };
    
}

- (void)searchBtnClicked
{
    
}
- (void)locationBtnClicked
{
    
}

- (ZHQDiscoverHotViewController *)hotVC
{
    if (!_hotVC) {
        _hotVC = [[ZHQDiscoverHotViewController alloc]init];
    }
    return _hotVC;
}
- (ZHQSubscribeViewController *)subVC
{
    if (!_subVC) {
        _subVC = [[ZHQSubscribeViewController alloc]init];
    }
    return _subVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
