//
//  ZHQCommonCell.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/30.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHQGroupModel.h"
#import "ZHQUser.h"

@interface ZHQCommonCell : UITableViewCell

@property (nonatomic, copy)void (^userInfoBlock)(ZHQUser *user);//点击头像回调
@property (nonatomic, strong) ZHQGroupModel*groupModel;
@end
