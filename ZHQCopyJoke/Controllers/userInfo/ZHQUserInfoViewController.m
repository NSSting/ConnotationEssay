//
//  ZHQUserInfoViewController.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/1.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQUserInfoViewController.h"
#import "ZHQCommonCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface ZHQUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *headerBackView;
@property (nonatomic, strong) UIImageView*headerImgaeView;
@property (nonatomic, strong) UILabel *userNameeLab;
@property (nonatomic, strong) UIImageView *avatarImgView;
@end

@implementation ZHQUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInterface];
}

- (void)setUpInterface
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ZHQCommonCell class] forCellReuseIdentifier:@"cell"];
    self.title = @"个人中心";
//    self.tableView.fd_debugLogEnabled = YES;
    [self layoutHeaderImageView];
}

#pragma mark----表头拉伸视图
- (void)layoutHeaderImageView
{
    UIView *headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    headerBackView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableHeaderView = headerBackView;
    self.headerImgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    self.headerImgaeView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImgaeView.clipsToBounds = YES;
    [self.headerImgaeView sd_setImageWithURL:[NSURL URLWithString:self.userModel.avatar_url]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [headerBackView addSubview:self.headerImgaeView];
    self.avatarImgView = [[UIImageView alloc]init];
    self.avatarImgView.frame = CGRectMake(30, 250 - 50 -30, 50, 50);
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:self.userModel.avatar_url]];
    self.avatarImgView.layer.cornerRadius = 25;
    self.avatarImgView.clipsToBounds = YES;
    [headerBackView addSubview:self.avatarImgView];
    _userNameeLab = [[UILabel alloc]init];
    _userNameeLab.frame = CGRectMake(30 + 50 + 5, 250 - 20 -30, SCREEN_WIDTH - 30-50-5, 20);
    _userNameeLab.font = [UIFont systemFontOfSize:12];
    _userNameeLab.textColor = [UIColor whiteColor];
    _userNameeLab.textAlignment = NSTextAlignmentCenter;
    _userNameeLab.clipsToBounds = YES;
    _userNameeLab.text = self.userModel.name;
    [headerBackView addSubview:_userNameeLab];
    [_userNameeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImgView.mas_right).offset(5);
        make.centerY.equalTo(self.avatarImgView.mas_centerY);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHQCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    cell.groupModel.user = self.userModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(ZHQCommonCell* cell) {
        cell.groupModel.user = self.userModel;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset <= 250 - 30){
        if (yOffset < 0){
            CGFloat totalOffset = 250 + ABS(yOffset);
            CGFloat f = totalOffset / 250;
            self.headerImgaeView.frame = CGRectMake(-(width * f - width) / 2, yOffset, width * f, totalOffset);
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
