//
//  ZHQCommonCell.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/30.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQCommonCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <Masonry.h>
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "ZHQCustomDisplayView.h"

@interface ZHQCommonCell ()

@property (nonatomic, strong) UIButton *userPhoto;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *hostLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *markLab;
@property (nonatomic, strong) UIImageView *videoView;
@property (nonatomic, strong) UILabel* styleLab;
//@property (nonatomic, strong) ZHQCustomDisplayView *playerView;
@end
@implementation ZHQCommonCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutContentView];
    }
    return self;
}
- (void)layoutContentView
{
    //头像
    
    [self.contentView addSubview:self.userPhoto];
    //昵称
    self.userName = [[UILabel alloc]init];
    self.userName.text = @"执拗是滴哦15680995678";
    self.userName.numberOfLines = 0;
    self.userName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.userName];
    //段子类型标签
    self.hostLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.hostLab];
    //段子内容
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.contentLab.numberOfLines = 0;
    self.contentLab.font = [UIFont systemFontOfSize:15];
    self.contentLab.text = @"ehgfd";
    [self.contentView addSubview:self.contentLab];
    //热门标签
    self.markLab = [[UILabel alloc]init];
    NSString *str = @"热门";
    self.markLab.text = @"热门";
    self.markLab.numberOfLines = str.length;
    self.markLab.font = [UIFont systemFontOfSize:13];
    self.markLab.textColor = [UIColor redColor];
    [self.contentView addSubview:self.markLab];
        //新闻类型标签
    self.styleLab = [[UILabel alloc]init];
    self.styleLab.textAlignment = NSTextAlignmentCenter;
    self.styleLab.layer.cornerRadius = 8;
    self.styleLab.clipsToBounds = YES;
    self.styleLab.layer.borderWidth = 2;
    self.styleLab.font = [UIFont systemFontOfSize:15];
    self.styleLab.layer.borderColor = [UIColor brownColor].CGColor;
    [self.contentView addSubview:self.styleLab];
    
    self.videoView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.videoView];

    //布局
   
    [self.markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.userPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.markLab.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userPhoto.mas_right).offset(10);
        make.centerY.equalTo(self.userPhoto.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userPhoto.mas_bottom).offset(5);
        make.left.equalTo(self.markLab.mas_right).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];

    [self.styleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLab.mas_bottom).offset( 10);
        make.left.equalTo(self.contentLab.mas_left);
        make.height.mas_equalTo(20);
        
    }];
   }

- (void)setGroupModel:(ZHQGroupModel *)groupModel
{
    _groupModel = groupModel;
    [self.userPhoto sd_setImageWithURL:[NSURL URLWithString:groupModel.user.avatar_url] forState:UIControlStateNormal];
    self.userName.text = groupModel.user.name;
    self.contentLab.text = groupModel.text;
    self.styleLab.text = [NSString stringWithFormat:@"  %@  ",groupModel.category_name];
    ZHQImageModel *imageModel = groupModel.large_image;
    
    if (imageModel.url_list.count > 0) {
        NSLog(@"-width==>%@--height>>%@--url--->%@",imageModel.width,imageModel.height,imageModel.url_list[0][@"url"]);
        [self.videoView sd_setImageWithURL:[NSURL URLWithString:imageModel.url_list[0][@"url"]]];
        [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.styleLab.mas_bottom).offset(5);
           make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    } else {
        [self.styleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
}
- (UIButton *)userPhoto
{
    if (!_userPhoto) {
        _userPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        _userPhoto.clipsToBounds = YES;
        _userPhoto.layer.cornerRadius = 25;
        [_userPhoto setImage:[UIImage imageNamed:@"userPhoto_default"] forState:UIControlStateNormal];
        [_userPhoto addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userPhoto;
}
- (void)btnClicked
{
    if (self.userInfoBlock) {
        self.userInfoBlock(self.groupModel.user);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
