//
//  ZHQServiceModel.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/28.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQServiceModel.h"

@implementation ZHQServiceModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"url":@"url",
             @"name":@"name",
             @"type" : @"type",
             @"list_id":@"list_id"
             };
}
@end
