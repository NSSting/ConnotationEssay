
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



@interface ZHQDiscoverHotViewController () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>

@end

@implementation ZHQDiscoverHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ZHQDiscoverHotCell class] forCellReuseIdentifier:@"hotCell"];
    [self setUpHeaderView];
    [self loadData];
}
- (void)setUpHeaderView
{
    SDCycleScrollView *scrolView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    scrolView.imageURLStringsGroup =  self.urlArray;
    scrolView.autoScrollTimeInterval = 5;
    self.tableView.tableHeaderView = scrolView;
}

- (void)loadData
{
    [[ZHQNetWorkingManager sharedManager] getDiscoverAdsWithsucces:^(id responseObject) {
       
        
    } withFailure:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHQDiscoverHotCell *hotcell = [tableView dequeueReusableCellWithIdentifier:@"hotCell" forIndexPath:indexPath];
    hotcell.textLabel.text = @"请助我上头条";
    return hotcell;
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
