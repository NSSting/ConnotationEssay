//
//  ZHQDiscoverHotCell.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/7.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQDiscoverHotCell.h"
#import <Masonry.h>

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
    [self.contentView addSubview:self.nickNameLab];
    self.recommendLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.recommendLab];
    self.subCountLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.subCountLab];
    self.postCountLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.postCountLab];
    self.subscriBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.subscriBtn.layer.cornerRadius = 5;
    self.subscriBtn.clipsToBounds = YES;
    [self.contentView addSubview:self.subscriBtn];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(self.contentView.mas_left).offset();
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
