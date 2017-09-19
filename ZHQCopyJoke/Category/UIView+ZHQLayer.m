//
//  UIView+ZHQLayer.m
//  ZHQCopyJoke
//
//  Created by ZQ on 2017/8/25.
//  Copyright © 2017年 DaisyLiLiFamilies. All rights reserved.
//

#import "UIView+ZHQLayer.h"

@implementation UIView (ZHQLayer)

- (void)setLayerCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
}

- (void)setLayerBorderColor:(UIColor *)layerBorderColor
{
    self.layer.borderColor = layerBorderColor.CGColor;
    [self _config];
}
- (void)setLayerBorderWidth:(CGFloat)layerBorderWidth
{
    self.layer.borderWidth = layerBorderWidth;
    [self _config];
}
- (void)setLayerCornerRadius:(CGFloat)layerCornerRadius
{
    self.layer.cornerRadius = layerCornerRadius;
    [self _config];
}
- (UIColor *)layerBorderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (CGFloat)layerBorderWidth
{
    return self.layer.borderWidth;
}
- (CGFloat)layerCornerRadius
{
    return self.layer.cornerRadius;
}

- (void)_config {
    
    self.layer.masksToBounds = YES;
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}
@end
