//
//  ZHQNetWorkingManager+ZHQDiscover.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/7.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQNetWorkingManager+ZHQDiscover.h"
#import "ZHQDiscoverListModel.h"
#import "ZHQBanerModel.h"
#import <MJExtension.h>

@implementation ZHQNetWorkingManager (ZHQDiscover)

- (void)getDiscoverAdsWithsucces:(sucessBlock )succes withFailure:(failureBlock )failure
{
    [self.baseManager GET:adsUrl parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionary];
        NSDictionary *data = responseObject[@"data"];
        [dic setValue:data[@"rotate_banner"][@"banners"] forKey:@"banners"];
        [dic setValue:data[@"categories"] forKey:@"category_list"];
        succes(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
