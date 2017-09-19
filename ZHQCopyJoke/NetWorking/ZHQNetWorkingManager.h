//
//  ZHQNetWorkingManager.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/28.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^sucessBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

@interface ZHQNetWorkingManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *baseManager;
@property (nonatomic, copy) NSString *accesstoken;


/**单例类*/
+(ZHQNetWorkingManager *)sharedManager;

- (instancetype)init NS_UNAVAILABLE;

- (void)cancelAllOperations;

@end
