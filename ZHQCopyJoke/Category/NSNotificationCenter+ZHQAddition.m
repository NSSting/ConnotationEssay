//
//  NSNotificationCenter+ZHQAddition.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/25.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "NSNotificationCenter+ZHQAddition.h"
@implementation NSNotificationCenter (ZHQAddition)



+ (void)postNotification:(NSString *)notiname {
    [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:nil];
    
}

+ (void)postNotification:(NSString *)notiname object:(id)object {
    if (object == nil) {
        [self postNotification:notiname];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:object userInfo:nil];
    }
}

+ (void)removeAllObserverForObj:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj];
}

+ (void)addObserver:(id)observer action:(SEL)action name:(NSString *)name {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:action name:name object:nil];
}

@end
