//
//  ZHQPageMenuView.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/30.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "ZHQPageMenuView.h"
#import "CAPSPageMenu.h"

@interface ZHQPageMenuView ()<CAPSPageMenuDelegate>
@property (nonatomic, strong) CAPSPageMenu *pageMenu;

@property (nonatomic, strong) NSDictionary *parameters ;
@end
@implementation ZHQPageMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.Controllers = [NSMutableArray array];
        [self initBasic];
    }
    return self;
}
- (void)initBasic
{
   self.parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionViewBackgroundColor:[UIColor lightGrayColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor:[UIColor orangeColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor orangeColor],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor blackColor],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:17.0],
                                 CAPSPageMenuOptionMenuHeight: @(40.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(SCREEN_WIDTH / 4),
                                 CAPSPageMenuOptionMenuItemSeparatorWidth:@(0),
                                 CAPSPageMenuOptionMenuMargin:@(0),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES),
                                 CAPSPageMenuOptionEnableHorizontalBounce: @(YES)
                                 };
    
}
- (void)setControllers:(NSMutableArray *)Controller

{
    _Controllers = Controller;
    if (Controller.count > 0) {
        // 新建分页控制控件frame为包含controller的尺寸
        _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:Controller frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) options:_parameters];
        _pageMenu.delegate = self;
        [self addSubview:_pageMenu.view];
    }
    
}
@end
