//
//  ZHQHomeViewController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/24.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQHomeViewController.h"
#import "ZHQSegmentView.h"
#import "ZHQPageMenuView.h"
#import "ZHQHeaderOptionView.h"
#import "ZHQBasicNavViewController.h"
#import "ZHQNetWorkingManager.h"
#import "ZHQNetWorkingManager+ZHQHome.h"
#import <MJExtension.h>
#import "ZHQBasicTableViewController.h"
#import "UIBarButtonItem+ZHQBarButton.h"

@interface ZHQHomeViewController ()
@property (nonatomic, strong) ZHQPageMenuView *pageView;
@property (nonatomic, strong) ZHQHeaderOptionView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat barLength;
@end

@implementation ZHQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadata];
    [self setUpItems];
}

- (void)setUpItems
{
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(userPhotoBtnClicked) image:@"userPhoto_default" highImage:@"userPhoto_default"];
    self.navigationItem.leftBarButtonItem = leftItem;
    WeakSelf(weakSelf);
   //导航栏添加segment
    ZHQSegmentView *segment = [[ZHQSegmentView alloc]initWithItemTitles:@[@"精华",@"关注"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 130, 40);
    [self.view addSubview:self.pageView];
    segment.segmentItemClickedBlock = ^(ZHQSegmentView *segmentView, UIButton *btn) {
        if (btn.tag != 1) {
           //精选
            weakSelf.pageView.hidden = YES;
        } else {
            weakSelf.pageView.hidden =NO;
        }
    };
    
}
- (void)loadata
{
    WeakSelf(weakself);
    [[ZHQNetWorkingManager sharedManager] getServiceTipsWithsucces:^(id responseObject) {
        NSArray *array = responseObject[@"data"];
        NSMutableArray*pageArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            
            ZHQServiceModel *model = [ZHQServiceModel mj_objectWithKeyValues:dic];
            if (model.type.integerValue == 1) {
                [weakself.dataArray addObject:model.name];
                ZHQBasicTableViewController *basicTabVC = [[ZHQBasicTableViewController alloc]init];
                basicTabVC.navigationItem.backBarButtonItem.title= @"";
                basicTabVC.hidesBottomBarWhenPushed = YES;
                basicTabVC.list_id = model.list_id;
                basicTabVC.title = model.name;
                basicTabVC.parentController = weakself;
                [pageArray addObject:basicTabVC];
            }
        }
        self.pageView.Controllers = pageArray;

    } withFailure:^(NSError *error) {
        NSLog(@"====%@",error);
    }];

}

- (void)userPhotoBtnClicked
{
    
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (ZHQPageMenuView *)pageView
{
    if (!_pageView) {
        _pageView = [[ZHQPageMenuView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _pageView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
