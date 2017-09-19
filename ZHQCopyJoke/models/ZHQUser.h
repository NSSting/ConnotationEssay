//
//  ZHQUser.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/31.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHQUser : NSObject

@property (nonatomic, copy) NSString* user_id;
@property (nonatomic, copy) NSString* user_verified;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* ugc_count;
@property (nonatomic, copy) NSString* avatar_url;
@property (nonatomic, copy) NSString* followers;
@property (nonatomic, copy) NSString* followings;
@property (nonatomic, copy) NSString* is_following;
@property (nonatomic, copy) NSString* is_pro_user;
@property (nonatomic, copy) NSString* large_avatar_url;


+ (instancetype)defaultUser;
- (void)archive;
- (instancetype)init NS_UNAVAILABLE;
@end
