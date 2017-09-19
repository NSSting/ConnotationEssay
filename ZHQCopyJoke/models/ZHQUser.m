//
//  ZHQUser.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/31.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQUser.h"

@implementation ZHQUser


+ (instancetype)defaultUser
{
    static ZHQUser *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self unArchive];
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    });
    return sharedInstance;
}

- (instancetype)init
{
    self.user_id = nil;
    self.name = nil;
    self.followers = nil;
    self.followings = nil;
    self.is_pro_user = nil;
    self.is_following = nil;
    self.ugc_count = nil;
    self.user_verified = nil;
    self.avatar_url = nil;
    return self;
}

- (void)archive
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [document stringByAppendingPathComponent:@"user.archiver"];
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (instancetype)unArchive
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [document stringByAppendingPathComponent:@"user.archiver"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.user_id forKey:@"is_pro_user"];
    [aCoder encodeObject:self.name forKey:@"is_pro_user"];
    [aCoder encodeObject:self.followers forKey:@"is_pro_user"];
    [aCoder encodeObject:self.ugc_count forKey:@"ugc_count"];
    [aCoder encodeObject:self.avatar_url forKey:@"avatar_url"];
    [aCoder encodeBool:self.user_verified forKey:@"user_verified"];
    [aCoder encodeBool:self.is_pro_user forKey:@"is_pro_user"];
    [aCoder encodeBool:self.is_following forKey:@"is_following"];
    [aCoder encodeBool:self.followings forKey:@"followings"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.followers = [aDecoder decodeObjectForKey:@"followers"];
        self.followings = [aDecoder decodeObjectForKey:@"followings"];
        self.user_verified = [aDecoder decodeObjectForKey:@"user_verified"];
        self.is_following = [aDecoder decodeObjectForKey:@"is_following"];
        self.is_pro_user = [aDecoder decodeObjectForKey:@"is_pro_user"];
        self.avatar_url = [aDecoder decodeObjectForKey:@"avatar_url"];
        self.ugc_count = [aDecoder decodeObjectForKey:@"ugc_count"];
    }
    return self;
}

@end
