//
//  GCPopMenuArrow.m
//  GCObjectDemo
//
//  Created by yons on 2020/8/24.
//  Copyright © 2020 yons. All rights reserved.
//

#import "GCPopMenuArrow.h"
#import <Masonry/Masonry.h>

@interface GCPopMenuArrow ()
/// imageView
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation GCPopMenuArrow

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
}
- (void)setConfig:(GCPopMenuConfig *)config{
    _config = config;
    CGRect rect = CGRectMake(0, 0, config.arrowWidth, config.arrowHeight);
    self.frame = rect;
    self.imageView.frame = rect;
    self.imageView.image = [self drawArrowImage:rect.size];
}
//绘制箭头图片
- (UIImage *)drawArrowImage:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, CGRectMake(0.0f, 0.0f, size.width, size.height));
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    //根据箭头位置确认箭头的3个绘制点
    //箭头的UIPopoverArrowDirectionAny类型会被判断成上左下右中的其中一种
    switch (self.config.arrowDirection) {
        case GCPopMenuArrowDirectionUP:
            point1 = CGPointMake(size.width/2.0, size.height/2.0);
            point2 = CGPointMake(size.width, size.height);
            point3 = CGPointMake(0, size.height);
            break;
        case GCPopMenuArrowDirectionLeft:
            point1 = CGPointMake(size.width/2.0, size.height/2.0);
            point2 = CGPointMake(size.width, size.height);
            point3 = CGPointMake(size.width, 0);
            break;
        case GCPopMenuArrowDirectionRight:
            point1 = CGPointMake(0, 0);
            point2 = CGPointMake(size.width/2.0, size.height/2.0);
            point3 = CGPointMake(0, size.height);
            break;
        case GCPopMenuArrowDirectionDown:
            point1 = CGPointMake(0, 0);
            point2 = CGPointMake(size.width / 2.0, size.height/2.0);
            point3 = CGPointMake(size.width, 0);
            break;
        default:
            break;
    }
    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowPath, NULL, point1.x, point1.y);
    CGPathAddLineToPoint(arrowPath, NULL, point2.x, point2.y);
    CGPathAddLineToPoint(arrowPath, NULL, point3.x, point3.y);
    CGPathCloseSubpath(arrowPath);
    CGContextAddPath(ctx, arrowPath);
    CGPathRelease(arrowPath);
    UIColor *fillColor = self.config.arrowColor;
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
