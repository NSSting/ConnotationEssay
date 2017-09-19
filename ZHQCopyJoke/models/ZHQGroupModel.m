//
//  ZHQGroupModel.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/1.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQGroupModel.h"

@implementation ZHQGroupModel


@end
@implementation ZHQVideoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"video_360P": @"360p_video",
             @"video_720P": @"720p_video" ,
             @"video_480P":@"480p_video",
             };
}

@end
