//
//  ZHQNetWorkingManager.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/28.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQNetWorkingManager.h"

@interface ZHQNetWorkingManager ()

@property (nonatomic, copy) NSString *cookie;
@end
@implementation ZHQNetWorkingManager

+(ZHQNetWorkingManager *)sharedManager{
    static ZHQNetWorkingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        
    });
    return manager;

}
- (instancetype)init
{
    self.baseManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:basicUrl]];
    [self.baseManager.requestSerializer setValue:[self cookie]forHTTPHeaderField:@"Cookie"];//请求头标记
    self.baseManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];//请求数据类型
    return self;
}

+ (NSString *)cookie {
    
    return @"_ga=GA1.2.732729183.1467731127; install_id=5316804410; login_flag=319157cead347271ef233ba429923e3b; qh[360]=1; sessionid=b391787a2cd16be0f914259f0cf829a4; sid_guard=\"b391787a2cd16be0f914259f0cf829a4|1473218826|2591916|Fri\054 07-Oct-2016 03:25:42 GMT\"; sid_tt=b391787a2cd16be0f914259f0cf829a4; uuid=\"w:9ce15113cb34468795d7aff3edddd670";
}

- (void)cancelAllOperations
{
    [self.baseManager.operationQueue cancelAllOperations];
}
@end
