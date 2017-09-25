
//
//  ZHQDiscoverHotViewController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/7.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQDiscoverHotViewController.h"
#import "ZHQDiscoverHotCell.h"
#import <SDCycleScrollView.h>
#import "ZHQNetWorkingManager+ZHQDiscover.h"
#import "ZHQDiscoverListModel.h"
#import <MJExtension.h>
#import "ZHQBanerModel.h"
#import "ZHQBasicTableViewController.h"
#import "ZHQUserInfoViewController.h"
@interface ZHQDiscoverHotViewController () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) NSMutableArray *bannersArray;
@property (nonatomic,strong) NSMutableArray *bannerstitle;

@property (nonatomic, strong) SDCycleScrollView *scrolView;

@end

@implementation ZHQDiscoverHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    [self.tableView registerClass:[ZHQDiscoverHotCell class] forCellReuseIdentifier:@"hotCell"];
    [self loadData];
    [self setUpHeaderView];
}
- (void)setUpHeaderView
{
    self.scrolView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _scrolView.autoScrollTimeInterval = 5;
    self.tableView.tableHeaderView = _scrolView;
}

- (void)loadData
{
    [[ZHQNetWorkingManager sharedManager] getDiscoverAdsWithsucces:^(id responseObject) {
        if (responseObject) {
            //广告数据
            NSArray *banners = responseObject[@"banners"];
            for (NSDictionary *dic in banners) {
                ZHQBanerModel *banner = [ZHQBanerModel mj_objectWithKeyValues:dic[@"banner_url"]];
                [self.bannerstitle addObject:banner.title];
                if (banner.url_list.count >0) {
                    NSDictionary *url = banner.url_list[0];
                    banner.url = url[@"url"];
                    [self.bannersArray addObject:url[@"url"]];
                }
            }
                        //列表数据
            NSArray *listDic = responseObject[@"category_list"][@"category_list"];
            for (NSDictionary *dic in listDic) {
                ZHQDiscoverListModel *discoverModel = [ZHQDiscoverListModel mj_objectWithKeyValues:dic];
                [self.listArray addObject:discoverModel];
            }
            self.scrolView.imageURLStringsGroup = self.bannersArray;
            self.scrolView.titlesGroup = self.bannerstitle;
            [self.tableView reloadData];
            
        }
        
    } withFailure:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHQDiscoverHotCell *hotcell = [tableView dequeueReusableCellWithIdentifier:@"hotCell" forIndexPath:indexPath];
    ZHQDiscoverListModel *model = self.listArray[indexPath.row];
    hotcell.discoverModel = model;
    WeakSelf(blockSelf);
    ZHQUserInfoViewController *infoVC = [[ZHQUserInfoViewController alloc]init];
    hotcell.userPhotoBlock = ^{
        [blockSelf.pareViewController.navigationController pushViewController:infoVC animated:YES];
    };
    return hotcell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     ZHQBasicTableViewController *detailVC = [[ZHQBasicTableViewController alloc]init];
     ZHQDiscoverListModel *model = self.listArray[indexPath.row];
    detailVC.list_id = @"-104";
    NSLog(@"==id==>%@",model.Id);
    [self.pareViewController.navigationController pushViewController:detailVC animated:YES];
}

- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _listArray;
}

- (NSMutableArray *)bannersArray
{
    if (!_bannersArray) {
        _bannersArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _bannersArray;
}
- (NSMutableArray *)bannerstitle
{
    if (!_bannerstitle) {
        _bannerstitle = [NSMutableArray arrayWithCapacity:0];
    }
    return _bannerstitle;
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
