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
@interface ZHQBasicTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
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
    [self loadData];
    
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"commonCell" cacheByIndexPath:indexPath configuration:^(ZHQCommonCell* cell) {
        cell.groupModel = [self.dataArray objectAtIndex:indexPath.row];
    }];
    return height;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
