//
//  ZHQGroupModel.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/1.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHQUser.h"
#import "ZHQImageModel.h"

@interface ZHQVideoModel : NSObject

@property (nonatomic, copy) NSDictionary *video_360p;
@property (nonatomic, strong)NSDictionary *video_720p;
@property (nonatomic, strong)NSDictionary *video_480p;
@property (nonatomic, copy)NSString * mp4_url;
+ (NSDictionary *)mj_replacedKeyFromPropertyName;


@end

@interface ZHQGroupModel : NSObject

@property (nonatomic, copy)NSString *video;
@property (nonatomic, strong) ZHQUser *user;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, strong)NSArray *dislike_reason;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *Id;
@property (nonatomic, copy)NSString *favorite_count;
@property (nonatomic, copy)NSString *go_detail_count;
@property (nonatomic, copy)NSString *user_favorite;
@property (nonatomic, copy)NSString *share_type;
@property (nonatomic, copy)NSString *max_screen_width_percent;
@property (nonatomic, copy)NSString *is_can_share;
@property (nonatomic, copy)NSString *category_type;
@property (nonatomic, copy)NSString *share_url;
@property (nonatomic, copy)NSString *label;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *comment_count;
@property (nonatomic, copy)NSString *id_str;
@property (nonatomic, copy)NSString *media_type;
@property (nonatomic, copy)NSString *share_count;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *has_comments;
@property (nonatomic, strong)ZHQImageModel *large_image;
@property (nonatomic, copy)NSString *user_bury;
@property (nonatomic, copy)NSString *status_desc;
@property (nonatomic, copy)NSString *display_type;
@property (nonatomic, copy)NSString *is_personal_show;
@property (nonatomic, copy)NSString *user_digg;
@property (nonatomic, copy)NSString *online_time;
@property (nonatomic, copy)NSString *category_name;
@property (nonatomic, copy)NSString *category_visible;
@property (nonatomic, copy)NSString *bury_count;
@property (nonatomic, copy)NSString *is_anonymous;
@property (nonatomic, copy)NSString *repin_count;
@property (nonatomic, copy)NSString *min_screen_width_percent;
@property (nonatomic, copy)NSString *digg_count;
@property (nonatomic, copy)NSString *has_hot_comments;
@property (nonatomic, copy)NSString *allow_dislike;
@property (nonatomic, copy)NSString *image_status;
@property (nonatomic, copy)NSString *user_repin;
@property (nonatomic, copy)NSString *activity;
@property (nonatomic, copy)NSString *group_id;
@property (nonatomic, strong)ZHQImageModel *middle_image;
@property (nonatomic, copy)NSString *category_id;
@property (nonatomic, strong)ZHQVideoModel *gifvideo;
////视频


@end


