//
//  ZHQHeaderOptionView.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/28.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQHeaderOptionView.h"
#import "ZHQHeaderItemView.h"

@interface ZHQHeaderOptionView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) CALayer *lineLayer;
@property (nonatomic, assign) NSInteger currentIndex;


@end
@implementation ZHQHeaderOptionView 
// 设置偏移量
- (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;
    
    CGFloat offsetX = contentOffset.x;
    // 当前索引
    NSInteger index = offsetX / SCREEN_WIDTH;
    
    ZHQHeaderItemView *leftItem = (ZHQHeaderItemView *)[self.scrollView viewWithTag:index + 1];
    // 下一个按钮 如果rightBtnLeftDelta > 0则下一个按钮开始渲染
    ZHQHeaderItemView *rightItem = (ZHQHeaderItemView *)[self.scrollView viewWithTag:index + 2];
    
    // right
    // 相对于当前屏幕的宽度
    CGFloat rightPageLeftDelta = offsetX - index * SCREEN_WIDTH;
    CGFloat progress = rightPageLeftDelta / SCREEN_WIDTH;
    
    if ([leftItem isKindOfClass:[ZHQHeaderItemView class]]) {
        leftItem.textColor = [UIColor redColor];
        leftItem.fillColor = [UIColor blackColor];
        leftItem.progress = progress;
    }
    if ([rightItem isKindOfClass:[ZHQHeaderItemView class]]) {
        rightItem.textColor = [UIColor blackColor];
        rightItem.fillColor = [UIColor redColor];
        rightItem.progress = progress;
    }
    
    for (ZHQHeaderItemView *itemView in self.scrollView.subviews) {
        if ([itemView isKindOfClass:[ZHQHeaderItemView class]]) {
            if (itemView.tag != index + 1 && itemView.tag != index + 2) {
                itemView.textColor = [UIColor blackColor];
                itemView.fillColor = [UIColor redColor];
                itemView.progress = 0.0;
            }
        }
    }
    
    // 重置当前索引
    self.currentIndex = index;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    // 标题
    if (titles.count) {
        for (int i = 0; i < titles.count; i++) {
            ZHQHeaderItemView *item = [[ZHQHeaderItemView alloc] init];
            [self.scrollView addSubview:item];
            item.text = titles[i];
            item.tag = i + 1;
            item.textAlignment = NSTextAlignmentCenter;
            item.userInteractionEnabled = YES;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapGest:)]];
        }
    }
    
    // 位置
    if (self.titles.count) {
        self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 1);
        self.scrollView.contentSize = CGSizeMake(60 * self.titles.count, self.scrollView.bounds.size.height - 1);
        CGFloat btnW = self.scrollView.contentSize.width / self.titles.count;
        for (int i = 0 ; i < self.titles.count; i++) {
            ZHQHeaderItemView *item = (ZHQHeaderItemView *)[self.scrollView viewWithTag:i + 1];
            item.frame = CGRectMake(btnW * i, 0, btnW, self.scrollView.frame.size.height);
        }
    }
    // 分割线
    self.lineLayer.frame = CGRectMake(0, self.scrollView.bounds.size.height - 1, SCREEN_WIDTH, 1);
}

// 点击item执行回调
- (void)itemTapGest:(UITapGestureRecognizer *)tapGest {
    ZHQHeaderItemView *item = (ZHQHeaderItemView *)tapGest.view;
    if (item) {
        
        if (self.homeHeaderOptionalViewItemClickHandle) {
            self.homeHeaderOptionalViewItemClickHandle(self, item.text, item.tag - 1);
        }
        self.currentIndex = item.tag - 1;
    }
}

- (UIScrollView *)scrollView {
    if(!_scrollView){
        UIScrollView *sc = [[UIScrollView alloc] init];
        sc.delegate = self;
        [self addSubview:sc];
        _scrollView = sc;
        sc.backgroundColor = [UIColor clearColor];
        sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        CALayer *line = [CALayer layer];
        [self.scrollView.layer addSublayer:line];
        line.backgroundColor = [UIColor lightGrayColor].CGColor;
        _lineLayer = line;
    }
    return _lineLayer;
}


@end
