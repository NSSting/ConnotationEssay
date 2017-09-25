//
//  ZHQDiscoverHotCell.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/7.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQDiscoverHotCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@interface ZHQDiscoverHotCell ()

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *nickNameLab;
@property (nonatomic, strong) UILabel *recommendLab;
@property (nonatomic, strong) UIButton *subscriBtn;
@property (nonatomic, strong) UILabel *subCountLab;
@property (nonatomic, strong) UILabel *postCountLab;

@end
@implementation ZHQDiscoverHotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutContentView];
    }
    return self;
}
- (void)layoutContentView
{
    self.photoView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.photoView];
    self.nickNameLab = [[UILabel alloc]init];
    self.nickNameLab.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nickNameLab];
    self.recommendLab = [[UILabel alloc]init];
    self.recommendLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.recommendLab];
    self.subCountLab = [[UILabel alloc]init];
    self.subCountLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.subCountLab];
    self.postCountLab = [[UILabel alloc]init];
    self.postCountLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.postCountLab];
    self.subscriBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.subscriBtn.layer.cornerRadius = 5;
    [self.subscriBtn setTitle:@"订阅" forState:UIControlStateNormal];
    [self.subscriBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.subscriBtn.clipsToBounds = YES;
    self.subscriBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:self.subscriBtn];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(PADDING_OF_LEFT_RIGHT);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(40);
    }];
    [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoView.mas_right).offset(10);
        make.top.equalTo(self.photoView.mas_top);
        make.height.mas_equalTo(20);
    }];
    [self.subscriBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-PADDING_OF_LEFT_RIGHT);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    [self.recommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoView.mas_right).offset(10);
        make.top.equalTo(self.nickNameLab.mas_bottom).offset(10);
        make.right.equalTo(self.subscriBtn.mas_left).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    [self.subCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoView.mas_left);
        make.top.equalTo(self.recommendLab.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
    [self.postCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subCountLab.mas_right).offset(10);
        make.centerY.equalTo(self.subCountLab.mas_centerY);
        make.height.mas_equalTo(15);
    }];
    
}
- (void)setDiscoverModel:(ZHQDiscoverListModel *)discoverModel
    {
        _discoverModel = discoverModel;
        self.nickNameLab.text= @"昵称";
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:discoverModel.icon]];
        self.recommendLab.text = discoverModel.intro;
        self.subCountLab.text = [NSString stringWithFormat:@"订阅数 \%@ ",discoverModel.total_updates];
        self.postCountLab.text = [NSString stringWithFormat:@" |   更新动态 %@",discoverModel.today_updates];
}
- (void)btnClicked
{
    if (self.userPhotoBlock) {
        self.userPhotoBlock();
    }
    [self.subscriBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.subscriBtn setTitle:@"已订阅" forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
