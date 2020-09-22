//
//  GCPopMenuConfig.m
//  GCObjectDemo
//
//  Created by yons on 2020/8/21.
//  Copyright © 2020 yons. All rights reserved.
//

#import "GCPopMenuConfig.h"

#define Table_Width 100.0f
#define Table_Height 150.0f
#define Table_Interval 12.0f
#define Table_CornerRadius 5.0f
#define Arrow_Width 10.0f
#define Arrow_Height 10.0f
#define Arrow_Interval 5.0f
#define Item_Height 55.0f
#define Icon_Width 25.0f
#define Icon_Height Icon_Width
#define Title_Font 17.0f

@implementation GCPopMenuConfig
- (instancetype)init{
    if ([super init]) {
        [self config];
    }
    return self;
}
//默认配置
- (void)config{
    self.arrowDirection = GCPopMenuArrowDirectionUP;
    self.automaticMenuWidth = NO;
    self.menuWidth = Table_Width;
    self.menuMaxHeight = Table_Height;
    self.menuInterval = Table_Interval;
    self.radius = Table_CornerRadius;
    self.arrowWidth = Arrow_Width;
    self.arrowHeight = Arrow_Height;
    self.arrowInterval = Arrow_Interval;
    self.arrowColor = [UIColor colorWithRed:75.0f/255.0f green:75.0f/255.0f blue:75.0f/255.0f alpha:1];
    self.itemHeight = Item_Height;
    self.iconWidth = Icon_Width;
    self.iconHeight = Icon_Height;
    self.itemBackgroundColor = [UIColor colorWithRed:67.0f/255.0f green:67.0f/255.0f blue:67.0f/255.0f alpha:1];
    self.lineColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1];
    self.titleColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1];
    self.titleFont = Title_Font;
}
- (CGFloat)calculateMenuWidthWithItem:(GCPopMenuItem *)item{
    CGRect rect = [item.title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.itemHeight)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.titleFont]}
                                            context:nil];
    CGFloat iconWidth = self.iconWidth;
    if ((!item.image && !item.imageUrl) || self.iconWidth <= 0) {
        iconWidth = 0;
    }
    CGFloat menuWidth = Item_Interval + iconWidth + Item_Interval + rect.size.width + Item_Interval;
    return menuWidth;
}
@end
