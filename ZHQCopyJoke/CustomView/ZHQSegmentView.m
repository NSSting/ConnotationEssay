//
//  ZHQSegmentView.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/25.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQSegmentView.h"
#import "UIView+ZHQLayer.h"

@implementation ZHQSegmentView
{
    NSArray *itemTitle;
    UIButton *lastBtn;
}

- (instancetype)initWithItemTitles:(NSArray *)itemTitles
{
    if (self = [super init]) {
        itemTitle = itemTitles;
        self.layerCornerRadius = 5;
        self.layerBorderWidth = 3;
        self.layerBorderColor = [UIColor whiteColor];
    }
    [self setUpSegmen];
    return self;
}

- (void)setUpSegmen
{
    if (itemTitle > 0) {
        for (int i = 0;i<itemTitle.count;i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            btn.tag = i + 1;
            btn.frame = CGRectMake((130 / itemTitle.count)*i, self.center.y , 130 / itemTitle.count, 40);
            [btn setTitle:itemTitle[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lastBtn = (UIButton *)[self viewWithTag:1];
            lastBtn.backgroundColor = [UIColor blueColor];
            }
    }
}

-(void)btnClicked:(UIButton *)btn
{
    lastBtn.backgroundColor = [UIColor whiteColor];
    btn.backgroundColor = [UIColor blueColor];
    if (self.segmentItemClickedBlock) {
        self.segmentItemClickedBlock(self,btn);
    }
    lastBtn = btn;
}
@end
