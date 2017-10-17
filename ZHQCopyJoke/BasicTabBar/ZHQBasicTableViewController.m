//
//  ZHQBasicTableViewController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/30.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQBasicTableViewController.h"
#import "ZHQCommonCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "ZHQNetWorkingManager+ZHQHome.h"
#import "ZHQGroupModel.h"
#import <MJExtension.h>
#import "ZHQUserInfoViewController.h"
#import "ZHQDiscoverHotViewController.h"
#import "ZHQRefreshManager.h"
#import <MJRefresh.h>
#import <NYTPhotosViewController.h>
#import <Masonry.h>

@interface ZHQBasicTableViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,NYTPhotosViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIScrollView *coverView;

@end

@implementation ZHQBasicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    self.tableView.fd_debugLogEnabled = YES;
    self.tableView.rowHeight = 100;
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.tableView registerClass:[ZHQCommonCell class] forCellReuseIdentifier:@"commonCell"];
    [self.tableView addSubview:self.refreshBtn];
    [self.tableView bringSubviewToFront:self.refreshBtn];
    [self loadData];
    WeakSelf(blockSelf);
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf loadData];
    } ];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [blockSelf loadData];
    }];
}

- (void)loadData
{
    
    [[ZHQNetWorkingManager sharedManager]getNewListWithListId:self.list_id WithSuccess:^(id responseObject) {
        NSArray *datas = responseObject[@"data"];
        if (datas.count > 0) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                ZHQGroupModel*group = [ZHQGroupModel mj_objectWithKeyValues: dic[@"group"]];
                [self.dataArray addObject:group];
                [self.tableView reloadData];
            }
        }
    } withFailure:^(NSError *error) {
        NSLog(@"---->>%@",error);
    }];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"===%ld",self.dataArray.count);
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHQCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commonCell"forIndexPath:indexPath];
    cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:"
    ZHQGroupModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.groupModel = model;
    WeakSelf(weakSelf);
    cell.userInfoBlock = ^(ZHQUser *user){
       //进入用户信息页面
        ZHQUserInfoViewController *infoVC = [[ZHQUserInfoViewController alloc]init];
        infoVC.userModel = user;
        [weakSelf.parentController.navigationController pushViewController:infoVC animated:YES];
    };
    cell.imagebigBlock = ^(ZHQGroupModel *groupModel) {
        //weakSelf.coverVie
        if (weakSelf.coverView ) {
            [weakSelf.view.window addSubview:weakSelf.coverView];
            weakSelf.coverView.contentSize = CGSizeMake(SCREEN_WIDTH, groupModel.large_image.r_height.floatValue);
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"commonCell" cacheByIndexPath:indexPath configuration:^(ZHQCommonCell* cell) {
        cell.groupModel = [self.dataArray objectAtIndex:indexPath.row];
    }];
    return height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"======%f",scrollView.contentOffset.y);
    _refreshBtn.frame = CGRectMake(_refreshBtn.frame.origin.x, scrollView.contentOffset.y + (self.view.bounds.size.height - 100), 60, 60);
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (UIButton *)refreshBtn
{
    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refreshBtn setImage:[UIImage imageNamed:@"home_refresh"] forState:UIControlStateNormal];
        _refreshBtn.frame = CGRectMake(SCREEN_WIDTH - 60 - PADDING_OF_LEFT_RIGHT, self.view.bounds.size.height - 100, 60, 60);
        [_refreshBtn addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

- (UIScrollView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIScrollView alloc]init];
        _coverView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _coverView.delegate = self;
        _coverView.backgroundColor = [UIColor yellowColor];
        _coverView.showsVerticalScrollIndicator = YES;
    }
    return _coverView;
}
- (void)refreshData
{
    [ZHQRefreshManager beginPullRefreshForScrollView:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
