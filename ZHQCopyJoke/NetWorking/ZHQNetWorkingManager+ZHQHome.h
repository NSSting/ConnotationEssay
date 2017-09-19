//
//  ZHQNetWorkingManager+ZHQHome.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/28.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQNetWorkingManager.h"

@interface ZHQNetWorkingManager (ZHQHome)

- (void)getServiceTipsWithsucces:(sucessBlock )succes withFailure:(failureBlock )failure;

- (void)getNewListWithListId:(NSString *)listId  WithSuccess:(sucessBlock)success withFailure:(failureBlock)failure;
@end
