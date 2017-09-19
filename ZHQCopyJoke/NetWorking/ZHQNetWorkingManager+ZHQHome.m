//
//  ZHQNetWorkingManager+ZHQHome.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/28.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQNetWorkingManager+ZHQHome.h"

@implementation ZHQNetWorkingManager (ZHQHome)

- (void)getServiceTipsWithsucces:(sucessBlock )succes withFailure:(failureBlock )failure
{
    [self.baseManager GET:service parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succes(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
- (void)getNewListWithListId:(NSString *)listId  WithSuccess:(sucessBlock)success withFailure:(failureBlock)failure
{
    
    [self.baseManager GET:newList parameters:@{@"content_type":listId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"success"]) {
            NSDictionary *listData = responseObject[@"data"];
            success(listData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
