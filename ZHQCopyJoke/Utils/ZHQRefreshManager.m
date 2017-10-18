//
//  ZHQRefreshManager.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/9/25.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQRefreshManager.h"
#import <MJRefresh.h>
#import "ZHQRefreshFooter.h"

@implementation ZHQRefreshManager

/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView
{
    [scrollView.mj_header beginRefreshing];
}

/** 判断头部是否在刷新 */
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView;
{
    BOOL flag =  scrollView.mj_header.isRefreshing;
    return flag;
    
}

/** 判断是否尾部在刷新 */
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView
{
    return  scrollView.mj_footer.isRefreshing;
}

/** 提示没有更多数据的情况 */
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView
{
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}

/**   重置footer */
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView
{
    [scrollView.mj_footer resetNoMoreData];

}

/**  停止下拉刷新 */
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView
{
    [scrollView.mj_header endRefreshing];

}

/**  停止上拉加载 */
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView{
    [scrollView.mj_footer endRefreshing];

}

/**  隐藏footer */
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView
{
    scrollView.mj_footer.hidden = YES;

}

/** 隐藏header */
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView{
    
}

/** 下拉刷新 */
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(ZHQRefreshHandle)loadMoreCallBackBlock{
    if (scrollView == nil || loadMoreCallBackBlock == nil) {
        return ;
    }
    ZHQRefreshFooter *footer = [ZHQRefreshFooter footerWithRefreshingBlock:^{
        if (loadMoreCallBackBlock) {
            loadMoreCallBackBlock();
        }
    }];
    [footer setTitle:@"正在刷新数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"内涵正在为您加载数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了~" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = [UIColor colorWithRed:90 green:90 blue:90 alpha:1];
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    footer.automaticallyHidden = YES;
    scrollView.mj_footer = footer;
    footer.backgroundColor = [UIColor clearColor];
}

/** 上拉加载 */
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(ZHQRefreshHandle)pullRefreshCallBackBlock
{
    
}
@end
