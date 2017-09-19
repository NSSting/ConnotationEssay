//
//  ZHQSubscribeViewController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/7.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQSubscribeViewController.h"
#import "ZHQSubscribeCell.h"

@interface ZHQSubscribeViewController ()

@end

@implementation ZHQSubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ZHQSubscribeCell class] forCellReuseIdentifier:@"subscribeCell"];
  
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHQSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subscribeCell" forIndexPath:indexPath];
    cell.textLabel.text = @"订阅关注更多内容";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
