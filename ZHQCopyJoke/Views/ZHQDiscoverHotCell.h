//
//  ZHQDiscoverHotCell.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/7.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHQDiscoverListModel.h"

@interface ZHQDiscoverHotCell : UITableViewCell
@property(nonatomic, strong) ZHQDiscoverListModel *discoverModel;
@property (nonatomic, copy) void (^userPhotoBlock)();
@end
