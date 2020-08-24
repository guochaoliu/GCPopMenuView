//
//  UIView+GC.h
//  GCObjectDemo
//
//  Created by yons on 2020/8/21.
//  Copyright © 2020 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GC)
- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGFloat)maxX;
- (CGFloat)maxY;
- (CGFloat)minX;
- (CGFloat)minY;
@end

NS_ASSUME_NONNULL_END
