//
//  ZHQRefreshManager.h
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/25.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZHQRefreshHandle)(void);
@interface ZHQRefreshManager : NSObject

/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断头部是否在刷新 */
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断是否尾部在刷新 */
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView;

/** 提示没有更多数据的情况 */
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**   重置footer */
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**  停止下拉刷新 */
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView;

/**  停止上拉加载 */
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView;

/**  隐藏footer */
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView;

/** 隐藏header */
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView;

/** 下拉刷新 */
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(ZHQRefreshHandle)loadMoreCallBackBlock;

/** 上拉加载 */
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(ZHQRefreshHandle)pullRefreshCallBackBlock;
@end
