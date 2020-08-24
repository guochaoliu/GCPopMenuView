//
//  GCPopMenuConfig.h
//  GCObjectDemo
//
//  Created by yons on 2020/8/21.
//  Copyright © 2020 yons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCPopMenuItem.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    GCPopMenuArrowDirectionUP,
    GCPopMenuArrowDirectionLeft,
    GCPopMenuArrowDirectionRight,
    GCPopMenuArrowDirectionDown
} GCPopMenuArrowDirection;
@interface GCPopMenuConfig : NSObject
#pragma mark -- 必须设置项
/// 发起menu的view
@property (nonatomic, strong) UIView *souceView;
/// 触发点相对于屏幕位置 tips: 无souceView或者自定义位置显示时需要设置。设置souceView，souceRect无效
@property (nonatomic, assign) CGRect souceRect;
/// 设置则menu显示在targetView范围内
@property (nonatomic, weak) UIView *targetView;
/// 数据源
@property (nonatomic, strong) NSArray<GCPopMenuItem *> *itemArray;
#pragma mark -- menu config
/// 箭头方向 默认：GCPopMenuArrowDirectionUP
@property (nonatomic, assign) GCPopMenuArrowDirection arrowDirection;
/// 圆角大小 默认：5
@property (nonatomic, assign) CGFloat radius;
/// menu宽 默认：100
@property (nonatomic, assign) CGFloat menuWidth;
/// menu高 默认：150
@property (nonatomic, assign) CGFloat menuHeight;
/// menu间隔 默认：12
@property (nonatomic, assign) CGFloat menuInterval;
/// 箭头宽 默认：20
@property (nonatomic, assign) CGFloat arrowWidth;
/// 箭头高 默认：20
@property (nonatomic, assign) CGFloat arrowHeight;
/// 箭头到souceView距离 默认：5
@property (nonatomic, assign) CGFloat arrowInterval;
/// 箭头颜色
@property (nonatomic, strong) UIColor *arrowColor;
#pragma mark -- item config
/// item高 默认：55
@property (nonatomic, assign) CGFloat itemHeight;
/// iconWidth 默认：25
@property (nonatomic, assign) CGFloat iconWidth;
/// iconHeight 默认：25
@property (nonatomic, assign) CGFloat iconHeight;
/// item背景颜色
@property (nonatomic, strong) UIColor *itemBackgroundColor;
/// 分割线颜色
@property (nonatomic, strong) UIColor *lineColor;
/// 字体颜色
@property (nonatomic, strong) UIColor *titleColor;
/// titleFont
@property (nonatomic, assign) CGFloat titleFont;
@end

NS_ASSUME_NONNULL_END
