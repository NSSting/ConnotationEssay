//
//  TAImageBrowser.m
//  TeraAutoDriver
//
//  Created by 灏 孙  on 2017/9/5.
//  Copyright © 2017年 TongFangCloud. All rights reserved.
//

#import "TAImageBrowser.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@interface TAImageBrowser ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIImageView *enlargeImage;
@property (nonatomic, strong)UIScrollView *scrollView;
@end
@implementation TAImageBrowser
- (instancetype)initWithFrame:(CGRect)frame imagename:(NSString *)imageName{
    if (self = [super initWithFrame:frame]) {

        
        [self initUI:imageName];
    }
    return self;
}
- (void)initUI:(NSString *)imgName{
    
    UIScrollView *scroll = [UIScrollView new];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.minimumZoomScale = 1.0;
    scroll.maximumZoomScale = 10;
    scroll.bounces = NO;
    scroll.delegate = self;
    
    [self addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        
    }];
    self.scrollView = scroll;
    
    UIImageView *imgv = [[UIImageView alloc]init];
    [imgv sd_setImageWithURL:[NSURL URLWithString:imgName]];
    imgv.frame = self.bounds;
    [scroll addSubview:imgv];
    self.enlargeImage = imgv;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.enlargeImage;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGRect frame = self.enlargeImage.frame;
    
    frame.origin.y = (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) * 0.5 : 0;
    self.enlargeImage.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(self.enlargeImage.frame.size.width, self.enlargeImage.frame.size.height);
}
- (void)dealloc
{
    
}
@end
