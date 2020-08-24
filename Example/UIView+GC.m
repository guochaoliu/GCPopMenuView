//
//  UIView+GC.m
//  GCObjectDemo
//
//  Created by yons on 2020/8/21.
//  Copyright © 2020 yons. All rights reserved.
//

#import "UIView+GC.h"

@implementation UIView (GC)
- (CGFloat)x{
    return self.frame.origin.x;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (CGFloat)height{
    return self.frame.size.height;
}
- (CGFloat)centerX{
    return self.x + self.width / 2;
}
- (CGFloat)centerY{
    return self.y + self.height / 2;
}
- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)minX{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}
@end
